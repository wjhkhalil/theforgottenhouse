extends Node
## AdMob ads. Autoloaded as "Ads".
##
## The game asks two things: "show a rewarded ad and tell me whether the player
## earned the reward" (show_rewarded) and "show a full-screen ad between chapters
## and tell me when it is gone" (show_interstitial). Starting the SDK, the consent
## form for European players, keeping one ad of each kind loaded and loading the
## next one after it is used all happen in here.
##
## In the editor the AdMob plugin shows a mock ad (a fake video with a countdown),
## so the whole flow can be played and tested on this computer. Debug builds use
## Google's test ad unit: a development build must never request live ads, AdMob
## closes accounts that show ads to their own developers.

## Fires when an ad becomes ready (true) or has just been used up (false).
signal rewarded_ready_changed(is_ready: bool)

const LIVE_REWARDED_UNIT_ID := "ca-app-pub-9402738271959820/8939903125"
const TEST_REWARDED_UNIT_ID := "ca-app-pub-3940256099942544/5224354917"
## Paste the "Interstitial" ad unit from the AdMob console here. While it is
## empty, release builds skip interstitials and go straight to the next chapter.
const LIVE_INTERSTITIAL_UNIT_ID := ""
const TEST_INTERSTITIAL_UNIT_ID := "ca-app-pub-3940256099942544/1033173712"
## Seconds before loading is tried again after a failed load (no internet, no ad to serve).
const RETRY_SECONDS := 20.0

## Tests set this to behave as if the phone is offline: no ad is ever ready.
var simulate_offline: bool = false:
	set(value):
		simulate_offline = value
		if not value:
			_load_ads()

var _sdk_started: bool = false
var _retry_timer: Timer

var _rewarded_ad: RewardedAd = null
var _rewarded_loader: RewardedAdLoader = null
var _loading_rewarded: bool = false
var _reward_earned: bool = false
var _rewarded_callback: Callable = Callable()

var _interstitial_ad: InterstitialAd = null
var _interstitial_loader: InterstitialAdLoader = null
var _loading_interstitial: bool = false
var _interstitial_callback: Callable = Callable()


func _ready() -> void:
	# Ads play while the room is paused, so this node (and the mock ad) must keep running.
	process_mode = Node.PROCESS_MODE_ALWAYS
	_retry_timer = Timer.new()
	_retry_timer.one_shot = true
	_retry_timer.timeout.connect(_load_ads)
	add_child(_retry_timer)
	_keep_mock_running_while_paused()
	_request_consent_then_start_sdk()


## True when a rewarded ad is loaded and can be shown right now.
func is_rewarded_ready() -> bool:
	return _rewarded_ad != null and not simulate_offline


## Shows the loaded rewarded ad. `on_result` is called exactly once when the ad
## has closed, with true if the player watched enough of it to earn the reward.
## Returns false (and never calls `on_result`) when no ad is ready; a new load is
## started so a later try can succeed.
func show_rewarded(on_result: Callable) -> bool:
	if not is_rewarded_ready():
		_load_ads()
		return false
	_rewarded_callback = on_result
	_reward_earned = false
	var listener := OnUserEarnedRewardListener.new()
	listener.on_user_earned_reward = func(_item: RewardedItem) -> void:
		_reward_earned = true
	_rewarded_ad.show(listener)
	return true


## True when a full-screen interstitial ad is loaded and can be shown right now.
func is_interstitial_ready() -> bool:
	return _interstitial_ad != null and not simulate_offline


## Shows the loaded interstitial ad. `on_closed` is called exactly once when the
## player has closed it. Returns false (and never calls `on_closed`) when no ad
## is ready, so the caller simply carries on without an ad.
func show_interstitial(on_closed: Callable) -> bool:
	if not is_interstitial_ready():
		_load_ads()
		return false
	_interstitial_callback = on_closed
	_interstitial_ad.show()
	return true


# ---------------------------------------------------------------------------
# SDK start-up
# ---------------------------------------------------------------------------

func _request_consent_then_start_sdk() -> void:
	# Without the native plugin (editor, desktop) the consent calls would never
	# answer, so the SDK (or its mock) is started straight away.
	if not Engine.has_singleton("PoingGodotAdMobUserMessagingPlatform"):
		_start_sdk()
		return
	var info := UserMessagingPlatform.consent_information
	info.update(ConsentRequestParameters.new(), _on_consent_info_updated,
			func(_error: FormError) -> void: _start_sdk())


## Google requires a consent form for players in the EEA/UK before any ad is
## requested. Elsewhere the SDK reports that no form is needed.
func _on_consent_info_updated() -> void:
	var info := UserMessagingPlatform.consent_information
	var needs_form := info.get_is_consent_form_available() \
			and info.get_consent_status() == ConsentInformation.ConsentStatus.REQUIRED
	if not needs_form:
		_start_sdk()
		return
	UserMessagingPlatform.load_consent_form(
			func(form: ConsentForm) -> void:
				form.show(func(_error: FormError) -> void: _start_sdk()),
			func(_error: FormError) -> void: _start_sdk())


func _start_sdk() -> void:
	if _sdk_started:
		return
	_sdk_started = true
	# The first ad is requested once the SDK reports that it is ready. The plugin's
	# own way of hearing that (MobileAds.initialize(listener)) connects a static
	# method one-shot to the plugin's signal, which makes Godot 4.7 crash with a
	# double free when the game quits. Listening on the plugin object directly works.
	var plugin: Object = MobileSingletonPlugin._get_plugin("PoingGodotAdMob")
	if plugin != null and plugin.has_signal("on_initialization_complete"):
		plugin.connect("on_initialization_complete",
				func(_status: Dictionary) -> void: _load_ads(), CONNECT_ONE_SHOT)
	MobileAds.initialize()


# ---------------------------------------------------------------------------
# Loading and showing
# ---------------------------------------------------------------------------

func _rewarded_unit_id() -> String:
	return TEST_REWARDED_UNIT_ID if OS.is_debug_build() else LIVE_REWARDED_UNIT_ID


func _interstitial_unit_id() -> String:
	return TEST_INTERSTITIAL_UNIT_ID if OS.is_debug_build() else LIVE_INTERSTITIAL_UNIT_ID


## Makes sure one ad of each kind is loaded (or loading).
func _load_ads() -> void:
	if simulate_offline or not _sdk_started:
		return
	_load_rewarded()
	_load_interstitial()


func _load_rewarded() -> void:
	if _loading_rewarded or _rewarded_ad != null:
		return
	_loading_rewarded = true
	var callback := RewardedAdLoadCallback.new()
	callback.on_ad_loaded = _on_rewarded_loaded
	callback.on_ad_failed_to_load = _on_load_failed.bind("rewarded")
	_rewarded_loader = RewardedAdLoader.new()
	_rewarded_loader.load(_rewarded_unit_id(), AdRequest.new(), callback)


func _load_interstitial() -> void:
	if _loading_interstitial or _interstitial_ad != null or _interstitial_unit_id().is_empty():
		return
	_loading_interstitial = true
	var callback := InterstitialAdLoadCallback.new()
	callback.on_ad_loaded = _on_interstitial_loaded
	callback.on_ad_failed_to_load = _on_load_failed.bind("interstitial")
	_interstitial_loader = InterstitialAdLoader.new()
	_interstitial_loader.load(_interstitial_unit_id(), AdRequest.new(), callback)


func _on_rewarded_loaded(ad: RewardedAd) -> void:
	_loading_rewarded = false
	_rewarded_ad = ad
	var callbacks := FullScreenContentCallback.new()
	callbacks.on_ad_dismissed_full_screen_content = _on_rewarded_closed
	callbacks.on_ad_failed_to_show_full_screen_content = func(_error: AdError) -> void:
		_on_rewarded_closed()
	ad.full_screen_content_callback = callbacks
	rewarded_ready_changed.emit(true)


func _on_interstitial_loaded(ad: InterstitialAd) -> void:
	_loading_interstitial = false
	_interstitial_ad = ad
	var callbacks := FullScreenContentCallback.new()
	callbacks.on_ad_dismissed_full_screen_content = _on_interstitial_closed
	callbacks.on_ad_failed_to_show_full_screen_content = func(_error: AdError) -> void:
		_on_interstitial_closed()
	ad.full_screen_content_callback = callbacks


func _on_load_failed(error: LoadAdError, kind: String) -> void:
	if kind == "rewarded":
		_loading_rewarded = false
	else:
		_loading_interstitial = false
	print("Ads: %s ad failed to load (%s), retrying in %d s" % [kind, error.message, int(RETRY_SECONDS)])
	_retry_timer.start(RETRY_SECONDS)


## The rewarded ad is gone (watched, closed early or failed to open): free it,
## start loading the next one, then report the result to whoever asked for it.
func _on_rewarded_closed() -> void:
	if _rewarded_ad != null:
		_rewarded_ad.destroy()
		_rewarded_ad = null
	rewarded_ready_changed.emit(false)
	_load_ads()
	var callback := _rewarded_callback
	_rewarded_callback = Callable()
	if callback.is_valid():
		callback.call(_reward_earned)


func _on_interstitial_closed() -> void:
	if _interstitial_ad != null:
		_interstitial_ad.destroy()
		_interstitial_ad = null
	_load_ads()
	var callback := _interstitial_callback
	_interstitial_callback = Callable()
	if callback.is_valid():
		callback.call()


## In the editor the "ad" is a mock node in the scene tree. The room pauses the
## game while an ad plays, so the mock must be told to keep running or its
## countdown and close button would freeze.
func _keep_mock_running_while_paused() -> void:
	if not OS.has_feature("editor"):
		return
	for plugin_name in ["PoingGodotAdMobRewardedAd", "PoingGodotAdMobInterstitialAd"]:
		var mock: Object = MobileSingletonPlugin._get_plugin(plugin_name)
		if mock is Node:
			(mock as Node).process_mode = Node.PROCESS_MODE_ALWAYS
