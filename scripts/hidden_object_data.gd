@tool
class_name HiddenObjectData
extends Resource
## All the editable information about ONE hidden object.
##
## Each object has its own .tres file in res://resources/objects/.
## Double-click one in the FileSystem dock to edit its text or artwork in the
## Inspector - no gameplay code needs to change.

## Which procedural placeholder drawing to use while no texture is assigned.
## (New styles must be added at the END so existing .tres files keep their style.)
enum PlaceholderStyle {
	GENERIC, KEY, PHOTOGRAPH, LETTER, DIARY, TEDDY_BEAR,
	WRISTBAND, FILM_NEGATIVES, MUSIC_BOX, RAIN_BOOTS, POCKET_WATCH, NEWSPAPER,
	SMALL_KEY, DOCUMENT, LEDGER, CHILD_DRAWING, SPECTACLES, LOCKET, TELEGRAM,
	# Chapter Four: The Grand Staircase
	PHONE_CORD, NAMEPLATE, RIBBON, KEY_RING, GLOVE, IRON_KEY, MAP,
	# Chapter Five: The Washroom
	HAIRBRUSH, RUBBER_DUCK, PERFUME, RAZOR, TINY_KEY, PILL_BOTTLE, WET_PHOTO, SOAP,
	# Chapter Six: The Living Room
	RECORD, PIPE, MATCHBOX, SCARF, CROSSWORD, POLICY, DESK_KEY, KEY_BUNCH,
	# Chapter Seven: The Kitchen
	SPOON, EGG_TIMER, RECIPE_CARD, POISON_TIN, TIN_OPENER, BURNT_LETTER, SERVANTS_KEY, SUGAR_MOUSE, PEBBLE,
	# Chapter Eight: The Study
	FORGED_PAGE, FOUNTAIN_PEN, MAGNIFIER, SIGNET_RING, CALENDAR, LETTER_OPENER, BOATHOUSE_KEY, WILL_SCROLL, PORTRAIT,
	# House Two, Chapter One: The Jetty
	POLICE_SEAL, CIGARETTE_CASE, FISHING_FLOAT, NAME_BOARD, MESSAGE_BOTTLE, COMPASS, TACKLE_KEY, LOG_PAGE,
	REGISTRATION, PRESCRIPTION,
	# House Two, Chapter Two: The Boat Shed
	HANDKERCHIEF, TRAIN_TICKET, COAT_BUTTON, SHIP_BELL, PURSE, TORCH, GOGGLES, ETHER_BOTTLE, BENCH_KEY,
	BANK_RECEIPT, LOFT_KEY,
	# House Two, Chapter Three: The Loft
	CANDLE_STUB, TIN_CUP, HAIRPIN, VISITING_CARD, POCKET_MIRROR, BEDSHEET_ROPE, RAG_DOLL, PADLOCK_KEY,
	SEDATIVE_VIAL, UNSENT_LETTER, PRESSED_VIOLET, WORKSHOP_KEY,
	# House Two, Chapter Four: The Workshop
	HAND_DRILL, WOODEN_BUNG, OIL_CAN, WOOD_PLANE, PAINT_TIN, LETTER_STENCIL, WORK_GLOVE, JOB_BOOK, HULL_PLAN,
	CUPBOARD_KEY, BOAT_MODEL, MALLET, DIVING_LAMP,
	# House Two, Chapter Five: The Sunken Boat
	SHIP_LOG, SHIP_LANTERN, TEACUP, HAIR_COMB, IRON_SHACKLE, STEEL_FILE, WINE_BOTTLE, SEXTANT, CABIN_KEY,
	PEARL_EARRING, DRILL_BIT, SILVER_FRAME, ICE_HOUSE_KEY,
	# House Two, Chapter Six: The Ice House
	ICE_PICK, ICE_TONGS, HORSE_BLANKET, TORN_SLEEVE, FROZEN_PIKE, SOUP_TIN, LOST_MITTEN, KEEPERS_NOTE,
	SIGNAL_WHISTLE, SCRATCHED_SLATE, ICE_SAW, FROZEN_BROOCH, SNOWSHOE, LIGHTHOUSE_KEY,
	# House Two, Chapter Seven: The Lighthouse Steps
	OILSKIN_HAT, TELESCOPE, KEEPER_LOGBOOK, WICK_TRIMMER, PARAFFIN_CAN, GULL_FEATHER, KNITTING_NEEDLES,
	BANDAGE_ROLL, TIDE_TABLE, BAROMETER, SHIP_IN_BOTTLE, LIFESAVING_MEDAL, KEEPERS_PHOTO, LAMP_ROOM_KEY,
	# House Two, Chapter Eight: The Lamp Room
	LENS_CLOTH, LAMP_MANTLE, TELEGRAM_FORM, POSTCARD, PENCIL_SKETCH, NEWSPAPER_PAGE, OIL_FUNNEL, BINOCULARS,
	RADIO_VALVE, BELL_HAMMER, TOBACCO_TIN, ROSARY, FERRY_TICKET, WIND_GAUGE, CHAPEL_KEY,
	# House Two, Chapter Nine: The Island Chapel
	HYMN_BOOK, COLLECTION_PLATE, PRAYER_CARD, GREY_VEIL, PARISH_REGISTER, HAND_BELL, PEWTER_CUP,
	EMBROIDERY_HOOP, TROWEL, DOCTORS_LETTER, CANDLE_SNUFFER, WOODEN_CROSS, OARLOCK, VESTRY_KEY, COTTAGE_MAP,
	# House Two, Chapter Ten: Dr Vane's Cottage
	STETHOSCOPE, GLASS_SYRINGE, DEATH_CERTIFICATE, CHEQUE_BOOK, PEN_KNIFE, CARRIAGE_CLOCK, DECANTER,
	SPECIMEN_JAR, CELLAR_KEY, TIMETABLE, PASSPORT, CONFESSION, GREY_SHAWL, MEDICAL_FILE, POLICE_WHISTLE,
	NAME_BRACELET,
}

@export_group("Identity")
## Unique id used by the code (never shown to the player). Must be different for every object.
@export var object_id: StringName = &""
## Name shown in the objective list.
@export var display_name: String = "Object"
## Short description of the object.
@export_multiline var description: String = ""

@export_group("Story Text")
## Headline shown in the notification when the object is found.
@export var collection_message: String = "You found something!"
## Clue shown under the headline when the object is found.
@export_multiline var clue_text: String = ""
## Text shown when the player asks for a hint about this object.
@export_multiline var hint_text: String = "Look carefully around the room."
## Short riddle shown in the objective list INSTEAD of the name, in rooms whose
## LevelData has "Objective Riddles" turned on. Keep it under about 26 characters.
@export var riddle_text: String = ""

@export_group("Artwork")
## Procedural drawing used when "Texture" is empty.
@export var placeholder_style: PlaceholderStyle = PlaceholderStyle.GENERIC
## Real artwork for the object in the room. Leave empty to use the placeholder.
@export var texture: Texture2D
## Optional small image for the objective list. If empty, "Texture" is used,
## and if that is empty too, the placeholder drawing is used.
@export var icon_texture: Texture2D

@export_group("Rules")
## Required objects must be found to finish the room.
@export var is_required: bool = true
## If false, the object starts hidden (useful for future puzzles that reveal objects).
@export var starts_visible: bool = true
