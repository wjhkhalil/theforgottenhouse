extends Node
## AudioManager (autoload): plays sound effects and music.
##
## Why an autoload? The sound on/off setting and the music must survive scene
## changes (menu -> room -> menu), which a normal scene node cannot do.
##
## ADDING REAL SOUNDS LATER
##   Put files named after the sound in res://assets/audio/sfx/, for example
##   collect.ogg, hint.wav, click.ogg, complete.ogg, paper.ogg, pause.ogg,
##   open.ogg (containers), unlock.ogg / wrong.ogg / keypress.ogg (keypad),
##   power_down.ogg / power_up.ogg (Chapter Six power cuts).
##   A file is used automatically when it exists; otherwise a small generated
##   tone is played instead. Music: res://assets/audio/music/ambient.ogg
##   (no music plays if that file does not exist - that is fine).

const SFX_FOLDER := "res://assets/audio/sfx/"
const MUSIC_FOLDER := "res://assets/audio/music/"
const AUDIO_EXTENSIONS: Array[String] = ["ogg", "wav", "mp3"]
const SAMPLE_RATE := 22050

## Recipes for the generated fallback sounds: [note frequencies (Hz), seconds per note, volume].
## A frequency of 0 makes a soft noise (sounds like rustling paper).
const FALLBACK_SOUNDS := {
	"collect": [[659.3, 784.0, 1046.5], 0.09, 0.3],
	"hint": [[523.3, 392.0], 0.14, 0.22],
	"click": [[880.0], 0.035, 0.15],
	"complete": [[392.0, 493.9, 587.3, 784.0], 0.2, 0.28],
	"paper": [[0.0], 0.18, 0.12],
	"pause": [[329.6], 0.08, 0.18],
	"open": [[110.0, 98.0, 146.8], 0.16, 0.3],
	"unlock": [[523.3, 659.3, 784.0], 0.08, 0.25],
	"wrong": [[196.0, 174.6], 0.13, 0.25],
	"keypress": [[1174.7], 0.03, 0.12],
	"power_down": [[220.0, 146.8, 98.0], 0.12, 0.3],
	"power_up": [[98.0, 146.8, 220.0], 0.07, 0.22],
}

var is_muted: bool = false

var _sfx_players: Array[AudioStreamPlayer] = []
var _next_player_index: int = 0
var _music_player: AudioStreamPlayer
var _stream_cache: Dictionary = {}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS  # Sounds also work in the pause menu.
	for i in range(4):
		var player := AudioStreamPlayer.new()
		add_child(player)
		_sfx_players.append(player)
	_music_player = AudioStreamPlayer.new()
	_music_player.volume_db = -8.0
	add_child(_music_player)
	# Use the sound setting from the save file (SaveManager loads before us).
	set_muted(SaveManager.sound_muted)
	# Prepare all sounds now so the first click does not stutter.
	for sound_name: String in FALLBACK_SOUNDS:
		_get_sfx_stream(sound_name)


func play_sfx(sound_name: String) -> void:
	var stream := _get_sfx_stream(sound_name)
	if stream == null:
		return
	var player := _sfx_players[_next_player_index]
	_next_player_index = (_next_player_index + 1) % _sfx_players.size()
	player.stream = stream
	player.play()


func play_music(track_name: String = "ambient") -> void:
	var path := _find_audio_file(MUSIC_FOLDER + track_name)
	if path == "":
		return  # No music file yet - the game simply runs without music.
	if _music_player.playing and _music_player.stream != null and _music_player.stream.resource_path == path:
		return  # Already playing this track.
	_music_player.stream = load(path)
	_music_player.play()


func set_muted(muted: bool) -> void:
	is_muted = muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), muted)


## Switches sound on/off and remembers the choice in the save file.
func toggle_muted() -> void:
	set_muted(not is_muted)
	SaveManager.set_sound_muted(is_muted)


func _get_sfx_stream(sound_name: String) -> AudioStream:
	if _stream_cache.has(sound_name):
		return _stream_cache[sound_name]
	var stream: AudioStream = null
	var path := _find_audio_file(SFX_FOLDER + sound_name)
	if path != "":
		stream = load(path)
	elif FALLBACK_SOUNDS.has(sound_name):
		stream = _generate_tone_stream(FALLBACK_SOUNDS[sound_name])
	_stream_cache[sound_name] = stream
	return stream


## Returns the first existing file among name.ogg / name.wav / name.mp3, or "".
## ResourceLoader.exists() does not print errors, so missing files are silent.
func _find_audio_file(path_without_extension: String) -> String:
	for extension in AUDIO_EXTENSIONS:
		var path := path_without_extension + "." + extension
		if ResourceLoader.exists(path):
			return path
	return ""


## Builds a short sound from sine waves (no audio file needed).
func _generate_tone_stream(recipe: Array) -> AudioStreamWAV:
	var frequencies: Array = recipe[0]
	var note_length: float = recipe[1]
	var volume: float = recipe[2]
	var samples_per_note := int(note_length * SAMPLE_RATE)
	var bytes := PackedByteArray()
	bytes.resize(samples_per_note * frequencies.size() * 2)  # 2 bytes per 16-bit sample
	var rng := RandomNumberGenerator.new()
	rng.seed = 42

	for note_index in range(frequencies.size()):
		var frequency: float = frequencies[note_index]
		for i in range(samples_per_note):
			var time := float(i) / SAMPLE_RATE
			var progress := float(i) / samples_per_note
			# Quick fade-in and smooth fade-out so the notes don't "click".
			var envelope := minf(progress * 20.0, 1.0) * pow(1.0 - progress, 2.0)
			var wave := 0.0
			if frequency <= 0.0:
				wave = rng.randf_range(-1.0, 1.0) * 0.6
			else:
				wave = sin(TAU * frequency * time) + 0.3 * sin(TAU * frequency * 2.0 * time)
			var sample := clampf(wave * envelope * volume, -1.0, 1.0)
			bytes.encode_s16((note_index * samples_per_note + i) * 2, int(sample * 32767.0))

	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = SAMPLE_RATE
	stream.stereo = false
	stream.data = bytes
	return stream
