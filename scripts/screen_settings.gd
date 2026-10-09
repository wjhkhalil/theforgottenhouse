extends Node
## Autoload "ScreenSettings": makes the game easier to see on phones.
##
## A phone screen is much smaller than a computer screen, so on phones the
## buttons, text and room are drawn bigger (`PHONE_UI_SCALE`) and the game uses
## the whole width of long phone screens. Each room's RoomCamera then lets the
## player drag around the room and zoom in further.
##
## To try the phone layout on a computer, run the game with:  -- --phone

## How much bigger everything is drawn on a phone (1.0 = same as a computer).
const PHONE_UI_SCALE := 1.35


func _ready() -> void:
	if is_phone():
		var window := get_window()
		window.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND
		window.content_scale_factor = PHONE_UI_SCALE


## True on phones and tablets (and with the --phone test option).
func is_phone() -> bool:
	return OS.has_feature("mobile") or DisplayServer.is_touchscreen_available() \
			or OS.get_cmdline_user_args().has("--phone")
