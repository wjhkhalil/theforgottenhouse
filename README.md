# The Forgotten House

A small 2D hidden-object mystery made with **Godot 4.7** and GDScript, told across several houses.
Each chapter is a different room with its own twist.

### House One: Ashworth Manor (complete, 8 chapters)

The lakeside home of the vanished Ashworth sisters.

| # | Room | Lighting | What makes it different |
|---|---|---|---|
| 1 | The Old Bedroom | lit | the basics: find 5 objects |
| 2 | The Basement | dark, lantern | door keypad, a trunk to open |
| 3 | The Attic | dark, flickering lantern | a box that needs a key found in the room |
| 4 | The Grand Staircase | moonlit | the room is **two screens tall**: scroll up and down |
| 5 | The Washroom | bright | **steam** hides everything; wipe it with the mouse, it drifts back |
| 6 | The Living Room | lit, with **random power cuts** | a chain of locks: box, then key, then desk |
| 7 | The Kitchen | firelight | the list shows **riddles** instead of names |
| 8 | The Study | desk lamp | a **safe** whose code you work out from a Kitchen clue (the finale) |

### House Two: The Blackwater Boathouse

Greaves is arrested, but he hints he never worked alone. The trail leads down to the boathouse
on Blackwater Lake, to the sunken boat *Lady Margaret*, and to "R.V.": Dr Robert Vane.

| # | Room | Lighting | What makes it different |
|---|---|---|---|
| 1 | The Jetty | moonlight and lamps | the room is **two screens wide**: look left and right. Three clues **drift on the lake** and must be caught as they float by. A padlocked crate and a code locker (10 objects) |
| 2 | The Boat Shed | a storm lantern | the lake **floods the boat slip and drains out again**, over and over. Objects at the bottom can only be reached at low water. A code tool chest, a key chain through a sunken strongbox (11 objects) |
| 3 | The Loft | moonlight through a round window | **bats** sleep under the beam. Clicking empty spots wakes them, and while they swoop around nothing can be picked up. A code sea chest, a padlocked doctor's case (12 objects) |
| 4 | The Workshop | work lamp and stove | the hull plan was **torn into 4 scraps**: find them all and the plan puts itself back together. A code cash box, a locked tool cupboard (13 objects) |
| 5 | The Sunken Boat | **dark**, murky water lit by your diving lamp | an **air gauge** drains while you search; when it runs out you swim up for a breath and can't pick anything up for a few seconds (13 objects) |
| 6 | The Ice House | cold daylight through the roof grating | things are **frozen in blocks of ice** that take several blows, and **frost creeps back** over objects (click once to rub it off) (14 objects) |
| 7 | The Lighthouse Steps | dim, with the lighthouse beam | **two screens tall**; the turning **beam sweeps past** and five objects can only be picked up while it lights them (14 objects) |
| 8 | The Lamp Room | the great lamp | **gusts of wind** blow the loose papers to new places; a paper can't be caught while it flies (15 objects) |
| 9 | The Island Chapel | **dark**, candlelight only | draughts **blow candles out**; click a candle to relight it. Only things in candlelight can be picked up (15 objects) |
| 10 | Dr Vane's Cottage | firelight (the finale) | Vane **patrols the garden**: when his lantern looks in, keep still, or you must hide for a few seconds. Two code locks and the cellar door (16 objects) |

Difficulty keeps rising from House One: the test checks every chapter against the one before it (the jetty against the study, and so on).
The flooding water is `scripts/tide_water.gd` (`TideWater`): set the slip area, the low-water level and how
long each part of the cycle lasts in the Inspector.
The bats are `scripts/bat_colony.gd` (`BatColony`): set where they hang, how many careless clicks wake
them and how long they fly in the Inspector. A drag (looking around on a phone) never counts as a careless click.
Chapters Four to Ten each have their own effect script with Inspector settings: `torn_pieces.gd`, `air_supply.gd`,
`frost_cover.gd`, `sweeping_beam.gd`, `wind_gusts.gd`, `candle_lights.gd` and `patrol_lantern.gd`. A container can
need several clicks to open (`hits_to_open`, used by the blocks of ice). Any room effect can show a message by
emitting a `notice(title, message, wrong_sound)` signal, without changing `room_level.gd`.

Progress is **saved automatically**: finished chapters, objects found so far, opened containers,
the solved door code and the sound setting.

All artwork is currently **drawn with code** as placeholder art, so the game is fully playable
with no image or sound files. Everything is designed so real art can be swapped in later
**without changing any code**.

---

## How to run

1. Open Godot, click **Import**, and select `project.godot` in this folder.
2. Press **F5** (or the ▶ Play button). The game starts at the main menu.

**Controls:** left-click objects · **H** = hint · **Esc** or **P** = pause ·
number keys + **Enter** on the keypad · on the staircase: **mouse wheel**, **arrow keys / W S**,
or hold the mouse near the top/bottom edge to scroll.

### Chapter difficulty

Each chapter is a clear step harder than the one before it, but never a wall: the Hint button
always works, keypads always give the answer in the end, and every locked box tells you what it needs.

| Ch | Objects | Locked-away layers* | Hint wait | Hint circle (radius / max offset) | Code hints after |
|---|---|---|---|---|---|
| 1 | 5 | 0 | 3 s | 85 / 25 | – |
| 2 | 6 | 1 | 10 s | 120 / 45 | 2 and 4 wrong tries |
| 3 | 7 | 3 | 20 s | 150 / 65 | 3 and 6 |
| 4 | 7 | 3 (room twice as big) | 25 s | 160 / 75 | – |
| 5 | 8 | 3 | 30 s | 170 / 85 | 3 and 6 |
| 6 | 8 | 4 | 35 s | 180 / 95 | – |
| 7 | 9 | 4 (+ riddles) | 40 s | 190 / 105 | – |
| 8 | 9 | 6 | 45 s | 200 / 115 | 3 and 6 (safe) |
| House Two, 1 | 10 | 6 (room twice as wide) | 50 s | 210 / 120 | 4 and 7 |
| House Two, 2 | 11 | 7 | 55 s | 220 / 125 | 5 and 8 |
| House Two, 3 | 12 | 8 | 60 s | 230 / 130 | 6 and 9 |
| House Two, 4 | 13 | 8 | 65 s | 240 / 135 | 6 and 9 |
| House Two, 5 | 13 | 9 | 70 s | 250 / 140 | 7 and 10 |
| House Two, 6 | 14 | 9 | 75 s | 260 / 145 | 7 and 10 |
| House Two, 7 | 14 | 10 (room twice as tall) | 80 s | 270 / 150 | 8 and 11 |
| House Two, 8 | 15 | 10 | 85 s | 280 / 155 | 8 and 11 |
| House Two, 9 | 15 | 11 | 90 s | 290 / 160 | 9 and 12 |
| House Two, 10 | 16 | 12 | 95 s | 300 / 165 | 9 and 12 (two locks) |

\* Every container counts as one layer; a container that also needs a key or a code counts as two.
Objects also get smaller and better hidden as the chapters go on.

**Darkness is not used to make chapters harder.** Each room picks its own lighting for mood:
only Chapters 2 and 3 are dark, and in Chapter 6 the lights go out at **random** moments
(a random gap of 12–24 s, then a random 3–5.5 s cut).

**Rule for future chapters** (the automated test checks it for every chapter in
`SaveManager.CHAPTERS`, so a chapter that is accidentally easier than the one before it fails the test):
* never fewer objects, and never fewer locked-away layers;
* a longer hint wait and a vaguer hint circle;
* code hints that come no earlier than in the last chapter with a code;
* and at least one real step up: more objects, more layers, or a bigger room.

The hint and keypad values are in each room's LevelData file (`resources/levels/*.tres`).
Lighting and effects are nodes in each room scene (`LanternDarkness`, `SteamFog`, `PowerCuts`, `RoomCamera`).

---

## Playing on an Android phone

A ready-to-install file is at `build/TheForgottenHouse.apk` (a debug build that works on 64-bit and older 32-bit phones).

* **Install it:** copy the APK to the phone, open it and allow "Install unknown apps" when the phone asks.
  With a USB cable and USB debugging on, you can instead run `~/Android/Sdk/platform-tools/adb install -r build/TheForgottenHouse.apk`.
* **Bigger on phones:** on a phone everything is drawn 35% bigger and fills long screens edge to edge
  (`PHONE_UI_SCALE` in `scripts/screen_settings.gd`). The chapter list uses two columns, and the keypad and
  letter are laid out wider so they fit the short screen.
* **Controls on a phone:** tap to pick up objects and press buttons. Drag one finger to look around the room
  and pinch with two fingers to zoom. In rooms where your finger moves the lantern light or wipes the steam
  (basement, attic, washroom, living room), look around with TWO fingers instead.
* **Try the phone layout on a computer:** `godot --path . --resolution 1200x540 -- --phone`.
  `tests/phone_screenshots.gd` saves a picture of every screen in that layout.
* **Build it again after changes:** in the editor choose **Project > Export > Android > Export Project**. The preset is
  saved in `export_presets.cfg`. Or run this from the command line:
  `godot --headless --path . --export-debug "Android" build/TheForgottenHouse.apk`.
  The editor needs **Editor Settings > Export > Android > Java SDK Path** set to `/usr/lib/jvm/java-17-openjdk-amd64`.

## Zoom (every chapter)

Every room has a camera (`scripts/room_camera.gd`) that can zoom in up to 2.5 times:

* **+ and - buttons** in the bottom-left corner, **Ctrl + mouse wheel**, or **pinching** on a phone.
* When zoomed in, look around with the **arrow keys / WASD**, the **mouse wheel** (up and down),
  by **dragging with the right or middle mouse button**, or by **dragging a finger** on a phone.
* Hints move the camera to the hinted object. Rooms without their own camera in the scene
  get one automatically from `room_level.gd`.

## Project layout

```
res://
├── project.godot              1280x720, scales to any window (stretch: canvas_items, keep)
├── scenes/
│   ├── main_menu.tscn         Continue / New Game / Chapters / About / Quit
│   ├── bedroom.tscn           Chapter One room
│   ├── basement.tscn          Chapter Two room (keypad, lantern, trunk)
│   ├── attic.tscn             Chapter Three room (keypad, flickering lantern, locked box)
│   ├── staircase.tscn         Chapter Four (tall room with a scrolling camera)
│   ├── washroom.tscn          Chapter Five (keypad, steam)
│   ├── living_room.tscn       Chapter Six (random power cuts, chained locks)
│   ├── kitchen.tscn           Chapter Seven (riddle list)
│   ├── study.tscn             Chapter Eight (code safe, finale)
│   ├── victory_screen.tscn    "Chapter One Complete" screen
│   ├── objects/
│   │   ├── hidden_object.tscn       Reusable clickable object (Area2D)
│   │   └── openable_container.tscn  Trunk/box that reveals an object when clicked (can need a key)
│   └── ui/
│       ├── hud.tscn           Room name, counter, objective list, buttons
│       ├── notification.tscn  Messages that fade away by themselves
│       ├── pause_menu.tscn    Resume / Restart / Main Menu
│       ├── letter_popup.tscn  The final letter
│       └── keypad_lock.tscn   4-digit code lock
├── scripts/                   One script per scene, plus:
│   ├── room_level.gd          Shared script for EVERY chapter room
│   ├── game_manager.gd        Progress + completion state for one room
│   ├── save_manager.gd        Autoload: chapter list + save file
│   ├── lantern_darkness.gd    Darkness with lantern light around the mouse
│   ├── room_camera.gd         Scrolling camera for rooms taller than the screen
│   ├── steam_fog.gd           Steam that the mouse wipes away
│   ├── power_cuts.gd          Lights that fail at random moments
│   ├── hidden_object_data.gd  Resource type that holds an object's text and art
│   ├── level_data.gd          Resource type for a room's story text
│   ├── room_art.gd            Base class for procedural room drawings
│   ├── bedroom_art.gd         Draws the placeholder bedroom
│   ├── basement_art.gd        Draws the placeholder basement
│   ├── attic_art.gd           Draws the placeholder attic
│   ├── staircase_art.gd, washroom_art.gd, living_room_art.gd, kitchen_art.gd, study_art.gd
│   ├── object_art/            Placeholder drawings of the Chapter 4–8 objects (one file per chapter)
│   ├── placeholder_art.gd     Draws the placeholder objects + colour palette
│   ├── placeholder_visual.gd  Shows a placeholder drawing in the room
│   ├── object_icon.gd         Small icon in the objective list
│   ├── hint_highlight.gd      Pulsing circle used by hints
│   └── audio_manager.gd       Autoload: sound effects, music, mute
├── resources/
│   ├── objects/*.tres         One file per hidden object (EDIT TEXT AND ART HERE)
│   ├── levels/*.tres          Per chapter: room name, intro, difficulty, door code, final letter
│   └── ui/game_theme.tres     Colours and styles for all buttons and panels
├── assets/                    Empty for now; put your real art and audio here
│   ├── backgrounds/  objects/  ui/  fonts/
│   └── audio/sfx/  audio/music/
└── tests/gameplay_test.tscn   Automated test that plays the game with real clicks
```

### How the pieces talk to each other (signals)

```
HiddenObject --collected--> GameManager
GameManager  --object_collected--> bedroom.gd --> HUD checkmark + notification
GameManager  --progress_changed--> HUD counter ("Objects Found: 2 / 5")
GameManager  --room_completed (exactly once)--> bedroom.gd --> victory screen --> letter
HUD          --hint_requested / pause_requested--> bedroom.gd
```

`GameManager` is a normal node inside each room scene, not an autoload. **Restart** and
**Replay** reload the scene, so every restart begins from a clean state.
There are two autoloads, because their data must survive scene changes:
`SaveManager` (progress and the save file) and `AudioManager` (sounds, music, mute).

### Save system

* The save file is `user://savegame.cfg`, a readable text file. On Linux it's in
  `~/.local/share/godot/app_userdata/The Forgotten House/`.
  In Godot, use **Project › Open User Data Folder** to find it.
* It saves automatically when an object is found, a container is opened, the door code is
  entered, a chapter is finished, or sound is toggled.
* **Continue** goes to the first unfinished chapter and restores the objects already found there.
* **Restart Room** forgets that room's progress. **Main Menu** keeps it.
* **New Game** starts Chapter One from scratch, but unlocked chapters stay unlocked.
* **Chapters › Reset All Progress** (click twice) erases everything except the sound setting.

### Adding a new chapter

1. Duplicate `scenes/basement.tscn` (or `bedroom.tscn`) and change the art, objects and positions.
2. Duplicate a file in `resources/levels/`, give it a new **Chapter Id**, and assign it to the
   new scene's root node (**Level Data**).
3. Add one line to `CHAPTERS` at the top of `scripts/save_manager.gd`, using the same id and the
   `"house"` it belongs to.

### Adding a new house

Add a line to `HOUSES` at the top of `scripts/save_manager.gd`, e.g.
`{"id": "my_house", "title": "House Two: ..."}`, then give that house's chapters `"house": "my_house"`.
The Chapters menu shows a heading above the first chapter of each house.

The previous chapter's completion screen then shows **Continue**, and the Chapters menu lists it.
**Keypad Lock** and **Lantern Darkness** on the root node are optional. Leave them empty for a
normal lit room with no lock. Remember the difficulty rule above: run the automated test to
confirm the new chapter is harder than the previous one.

**Locked containers:** on an `OpenableContainer`, set **Lock › Required Object** to another hidden
object in the room (for example a small key). Until the player finds it, clicking the container
only shows **Locked Message**. Or set **Lock › Required Code**: clicking then opens the keypad
(with a **Step Back** button), and the room needs a `KeypadLock` node. **Artwork › Style** picks the
placeholder (trunk, jewellery box, hat box, cabinet, drawer, safe, basket, box, book spines) and
**Tint** its colour.

**Room effects** (add the node to a room scene; all optional, combine as you like):
* `LanternDarkness`: dark room, light around the mouse (`darkness`, `light_radius`, `flicker_strength`).
* `SteamFog`: steam the mouse wipes away (`thickness`, `wipe_radius`, `return_seconds`).
* `PowerCuts` + a hidden `LanternDarkness`: random blackouts (gap and length ranges in seconds).
* `RoomCamera` (set the root's **Room Camera** and both art nodes' **Room Size**): a room taller than the screen.
* **Objective Riddles** in the LevelData: the list shows each object's **Riddle Text** until it is found.
  With more than 7 objects the list automatically uses smaller one-line rows.

---

## Changing text (no code needed)

* **Object names, clues, hints and messages:** double-click a file in
  `resources/objects/` and edit it in the Inspector.
* **Room name, intro, final letter, chapter ending:** edit the chapter's file in `resources/levels/` (one per room, e.g. `kitchen_level.tres`).
* **Moving an object:** open `scenes/bedroom.tscn`, select the object under `HiddenObjects`,
  and drag it. The placeholder art is visible in the editor.

### Adding another object

1. Duplicate one of the `.tres` files in `resources/objects/` and give it a **new unique `object_id`**.
2. In `bedroom.tscn`, drag `scenes/objects/hidden_object.tscn` onto the `HiddenObjects` node.
3. Assign the new `.tres` file to the object's **Data** property.

The objective list, the counter and the hints update automatically.
Untick **Is Required** to make an object optional, so it isn't counted for completion.

---

## Replacing placeholder art with real images

| Asset to make | Suggested size | Where it goes | Shown by |
|---|---|---|---|
| Bedroom background (walls, floor, furniture) | 1280×720 PNG | `assets/backgrounds/` | `bedroom.tscn` › `RoomBackground` (also the main menu's `RoomArt`) |
| Bedroom foreground (blanket edge, desk books) | 1280×720 **transparent** PNG | `assets/backgrounds/` | `bedroom.tscn` › `RoomForeground` |
| Basement background (stairs, bench, shelves, furnace) | 1280×720 PNG | `assets/backgrounds/` | `basement.tscn` › `RoomBackground` |
| Basement foreground (stair post, front jar) | 1280×720 **transparent** PNG | `assets/backgrounds/` | `basement.tscn` › `RoomForeground` |
| Wristband, film negatives, music box, boots, pocket watch, newspaper clipping | about 50–110 px, transparent PNG | `assets/objects/` | each object's `.tres` › **Texture** |
| Trunk, closed and open | about 120×80 PNG each | `assets/objects/` | `basement.tscn` › `OldTrunk` › **Closed Texture / Open Texture** |
| Attic background (roof, window, dresser, chairs, hat boxes) | 1280×720 PNG | `assets/backgrounds/` | `attic.tscn` › `RoomBackground` |
| Attic foreground (sheet hem, book, chair arm) | 1280×720 **transparent** PNG | `assets/backgrounds/` | `attic.tscn` › `RoomForeground` |
| Brass key, will, ledger, child's drawing, spectacles, locket, telegram | about 30–100 px, transparent PNG | `assets/objects/` | each object's `.tres` › **Texture** |
| Jewellery box and hat box, closed and open | about 60×40 and 90×70 PNG | `assets/objects/` | `attic.tscn` › `JewelleryBox` / `HatBox` › **Closed Texture / Open Texture** |
| Staircase background + foreground | **1280×1440** PNGs (two screens tall) | `assets/backgrounds/` | `staircase.tscn` › `RoomBackground` / `RoomForeground` |
| Washroom, living room, kitchen, study backgrounds + foregrounds | 1280×720 PNGs (foregrounds transparent) | `assets/backgrounds/` | each room scene › `RoomBackground` / `RoomForeground` |
| 41 objects of Chapters 4–8 | about 30–100 px, transparent PNG | `assets/objects/` | each object's `.tres` › **Texture** |
| 14 containers of Chapters 4–8 (clock, drawers, cabinets, basket, boxes, safe, bookcase), closed and open | sized like their **Size** in the scene | `assets/objects/` | each container › **Closed Texture / Open Texture** |
| Rusty key, photograph, letter, diary, teddy bear | about 60–120 px, transparent PNG | `assets/objects/` | each object's `.tres` › **Texture** |
| Objective list icons (optional) | 64×64 PNG | `assets/ui/` | each object's `.tres` › **Icon Texture** |
| Font (optional) | .ttf / .otf | `assets/fonts/` | `resources/ui/game_theme.tres` › Default Font |

### Object images

1. Copy the PNG into `assets/objects/`.
2. Open the object's `.tres` file (for example `resources/objects/rusty_key.tres`).
3. Drag the PNG onto **Texture**.

That's all. The procedural drawing hides itself, and the image appears in the room and in the
objective list. The game logic does not change.

**Adjusting size and position:** in `bedroom.tscn`, select the object and use
**Replacement Art Placement › Texture Scale** and **Texture Offset**.
You can also scale or rotate the whole object node.

**Keeping the clickable area right:**
* With **Click Size** left at `(0, 0)`, the click area automatically matches the image
  size × Texture Scale, plus **Click Padding** pixels on each side.
* If your image has a lot of empty transparent space, set **Click Size** by hand
  (for example `(60, 30)` for a key) so empty pixels can't be clicked.
* Turn on **Debug › Visible Collision Shapes** in the editor menu and run the game
  to see the click areas.

### Background images

Select `RoomBackground` in `bedroom.tscn` and drag your image onto **Replacement Texture**.
The procedural room stops drawing. Do the same with `RoomForeground` using a transparent PNG
that contains only the things that should cover objects (or leave it empty).
After changing the background, move the objects so they sit naturally in your new painting.

---

## Adding sound later

The game runs silently without audio files. Built-in generated tones are used as placeholders.

* **Sound effects:** put files in `assets/audio/sfx/` with these exact names
  (`.ogg`, `.wav` or `.mp3`):
  `collect`, `hint`, `click`, `pause`, `paper` (letter opens), `complete` (chapter finished),
  `open` (containers), `unlock`, `wrong`, `keypress` (keypad), `power_down`, `power_up` (Chapter Six).
  For example `assets/audio/sfx/collect.ogg`. A file replaces its generated tone automatically.
* **Music:** put `assets/audio/music/ambient.ogg` in place. It starts automatically on the
  menu and in the room. To make it loop, select the file, open the **Import** tab,
  tick **Loop**, then click **Reimport**.
* **New sounds:** call `AudioManager.play_sfx("my_sound")` and add `my_sound.ogg` to `assets/audio/sfx/`.

---

## Running the automated test

From this folder, in a terminal:

```
godot --path . res://tests/gameplay_test.tscn
```

It first checks that every chapter is harder than the one before it. Then it opens a window and
plays through all eighteen chapters of both houses with simulated mouse clicks, wheel turns and key presses,
including saving and resuming, every keypad, every locked box and every room's special effect.
It prints `PASS`/`FAIL` for every check (about 15 minutes).
It uses its own save file, so your real progress isn't touched. It needs a real window: in `--headless` mode Godot does
not deliver mouse clicks to objects, so the click checks fail there.
See `TESTING_REPORT.md` for the latest results.
