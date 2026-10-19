class_name PrivacyPolicy
extends Control
## An in-game copy of the policy players can read without leaving the game.

signal closed

@onready var _policy_text: RichTextLabel = %PolicyText
@onready var _back_button: Button = %BackButton

const POLICY := """[font_size=18][color=#f2c27a]The short version[/color][/font_size]
You do not create an account and we do not ask for your name, email address, photos, contacts, camera, microphone, files or precise location. Your progress and settings stay on your device. The game uses Google AdMob to show ads; Google may process limited device and advertising data to provide and measure those ads. We do not sell your personal information or run our own analytics.

[font_size=18][color=#f2c27a]What the game stores[/color][/font_size]
The game stores a small save file in its private storage on your device. It contains completed and unlocked chapters, objects found, open containers, best scores and times, Journal clues, and sound, vibration and volume settings. This file is not sent to us or anyone else. You can remove it by clearing the game’s storage in your device settings or by uninstalling the game.

[font_size=18][color=#f2c27a]Advertising[/color][/font_size]
The game is supported by ads served by Google AdMob. You may choose to watch a video ad for a hint, and full-screen ads may appear between some chapters. To deliver, limit, measure and protect ads from fraud, Google may process your advertising ID, IP address (which can indicate an approximate location), device and app information, ad interactions, and ad-related diagnostic data. We receive only aggregate reports, such as how many ads were shown. No ads are requested while you are offline.

[font_size=18][color=#f2c27a]Your choices[/color][/font_size]
In the European Economic Area, the United Kingdom and Switzerland, Google presents a consent form before ads are requested. You can choose whether to allow personalised advertising. You can also manage or reset your Android advertising ID in Settings → Google → Ads, or Settings → Privacy → Ads on some devices.

[font_size=18][color=#f2c27a]Permissions[/color][/font_size]
The game uses internet and network-state access to load ads, the Android advertising ID for AdMob, and vibration for optional haptic feedback. The game itself can be played offline. You can turn vibration off in Settings.

[font_size=18][color=#f2c27a]Children and changes[/color][/font_size]
The game is not directed at children under 13. If this policy changes because the game’s data practices change, we will update the effective date above.

[font_size=18][color=#f2c27a]Contact[/color][/font_size]
For questions about privacy, contact heyitswajeeha@gmail.com. Google’s privacy policy is available at policies.google.com/privacy.
"""


func _ready() -> void:
	hide()
	_policy_text.text = POLICY
	_back_button.pressed.connect(close)


func is_open() -> bool:
	return visible


func open() -> void:
	show()
	_back_button.grab_focus()


func close() -> void:
	if not visible:
		return
	AudioManager.play_sfx("click")
	hide()
	closed.emit()


func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close()
