# Testing Report

**Date:** 2026-10-09 · **Engine:** Godot 4.7.2.stable (Linux, GL Compatibility, Intel HD 530)
**Version:** v0.8 (House One complete, House Two Chapters One to Three, zoom, phone layout)

## How it was tested

1. **Import and editor load:** `godot --headless --import` and `--editor --quit` gave no script,
   scene or resource errors and no warnings.
2. **Scene smoke runs:** all nine scenes (menu + 8 rooms) ran headless with no errors.
3. **Automated play-through** (`tests/gameplay_test.tscn`): it runs in a real window with simulated
   mouse motion, clicks, wheel turns and key presses, and uses a separate test save file.
   On the final version, **288 / 288 checks passed in every run** (3 runs: 1 with screenshots, 2 without).
4. **Screenshots** of every room were inspected by eye. Each room was first checked by the
   person who built it (lit, with its effect, all containers open). Then the full test run was
   checked: chapter list, staircase, steam, power cut, riddle list, safe keypad and the ending screen.

## New in v0.8 (House Two, Chapter Three: The Loft)

| Check | Result |
|---|---|
| Full play-through: **416 / 416** on the final version (all eleven chapters) | ✅ |
| Difficulty: the loft is checked against the boat shed (12 objects, 8 locked layers, 60 s hint wait, vaguer hint circle, code hints after 6 tries) | ✅ (6 checks) |
| The boat shed now offers Continue to Chapter Three; the loft is the last chapter so far and says "more chapters coming soon" | ✅ |
| Loft: not dark; the bats start asleep; dragging across the room does not wake them; one click on an empty spot makes them stir, a second wakes them | ✅ |
| Loft: while the bats fly, clicking an object does not collect it and says "The bats are in the way!"; they settle by themselves and the object can then be collected | ✅ |
| Loft: the sea chest refuses a wrong code and opens with 1405; the doctor's case stays padlocked until its key is found; 12 / 12 completes once without ever waking the bats; the letter appears; completion is saved | ✅ |
| Screenshots: the loft asleep, the bats flying, all containers open, and the phone layout | ✅ |

**Problems found and fixed while building it:** the flapping bat wings sometimes failed to draw (a flat polygon mid-flap),
so each wing is now drawn as two triangles. The hatbox and three bats were hidden behind the "Objects to Find"
panel, so they were moved left. A click on an object that disappears could have been paired with an older press
and counted as a careless click; every new press now resets this.

## New in v0.7 (House Two, Chapter Two: The Boat Shed)

| Check | Result |
|---|---|
| Full play-through: **374 / 374** in both runs on the final version (all ten chapters) | ✅ |
| Difficulty: the boat shed is checked against the jetty (11 objects, 7 locked layers, 55 s hint wait, vaguer hint circle, code hints after 5 tries) | ✅ (6 checks) |
| The jetty now offers Continue to Chapter Two; the boat shed is the last chapter so far and says "more chapters coming soon" | ✅ |
| Boat shed: not dark; at high water the bell and the strongbox are under the water; clicking a covered object does not collect it and says "It's under the water"; a covered container won't open | ✅ |
| Boat shed: the water drains by itself; at low water the bell can be reached | ✅ |
| Boat shed: the tool chest refuses a wrong code and opens with 2350; the workbench drawer stays locked until its key is found; 11 / 11 completes once; the letter appears; completion is saved | ✅ |
| Screenshots: high water, draining, low water, all containers open, the phone layout, and the chapter list with two houses | ✅ |

**Problem found and fixed:** clicking the water first ignored the click's own position and used the real mouse
pointer instead (the test caught this). It now uses the click's position, so it also works with touch.
"Monogrammed Handkerchief" was cut off in the list, so it is now "R.V. Handkerchief".

## New in v0.6 (House Two, Chapter One: The Jetty)

| Check | Result |
|---|---|
| Full play-through: **336 / 336** in both runs on the final version, including every chapter of House One and the jetty | ✅ |
| Difficulty: the jetty is checked against the study by the same rule (10 objects, 6 locked layers, a bigger room, 50 s hint wait, vaguer hint circle, code hints after 4 tries) | ✅ (6 checks) |
| The study now offers **Continue: House Two**; the jetty is the last chapter so far and says "more chapters coming soon" instead of THE END | ✅ |
| Jetty: not dark; two screens wide and starts at the left end; objects lie beyond the first screen; the mouse wheel scrolls sideways and back | ✅ |
| Jetty: three objects drift on the lake by themselves and can be clicked while moving | ✅ |
| Jetty: the locker refuses a wrong code and opens with 2209; the fish crate stays padlocked until its key is found; 10 / 10 completes once; the letter appears; completion is saved | ✅ |
| Chapters menu shows both house headings. On a phone the list uses two columns; on a computer it scrolls when it is too tall (checked in screenshots) | ✅ |

**Problems found and fixed while building it:** the lake mist particles drew as grey squares, so they were removed.
The floating bottle drifted in front of the barrels, so it now floats in open water. "Lady Margaret Nameboard" was
cut off in the list, so it is now called "Boat Nameboard".

## New in v0.5 (zoom and phones)

| Check | Result |
|---|---|
| Full play-through still passes on the computer layout: **299 / 299** (288 earlier checks, 10 zoom and touch checks, 1 house-name check) | ✅ |
| Every room has a zoom camera that starts zoomed out; the + button zooms in; it stops at 2.5×; the - button zooms back to the whole room | ✅ |
| Arrow keys look around a zoomed room; objects can still be clicked while zoomed in | ✅ |
| Ctrl + mouse wheel zooms; a simulated two-finger pinch zooms; a simulated one-finger drag looks around | ✅ |
| Phone layout (`--phone`, 1200×540 window, the shape of a 20:9 phone): screenshots of the menu, the chapter list, every room, both keypads, pause, victory and the longest letter. Everything fits on screen | ✅ |
| Android APK exports, is signed and passes `apksigner verify` | ✅ |

One earlier run failed "Staircase starts at the top" because the computer's real mouse scrolled the room
while it loaded. That was a test problem, not a game bug: the test now parks the real mouse before
loading the staircase.

**Not tested on a real phone:** no phone was connected. Touch was tested only with simulated touch
events, so real-finger feel (drag speed, pinch sensitivity) still needs a try on a device.

## Chapters One to Three (all passing, as in v0.3)

Menus, collecting, hints, pause, restart, the letter, keypads, darkness, the trunk, the locked
jewellery box, save and resume, and Continue to the next chapter.

## New in v0.4

| Check | Result |
|---|---|
| Difficulty curve for all 7 chapter pairs: never fewer objects or layers, longer hint wait, vaguer hint circle, code hints no earlier, plus a real step up (more objects, more layers or a bigger room) | ✅ (39 checks) |
| Chapters 4–8 are not dark | ✅ |
| Chapters list shows 8 chapters; only Chapter One is unlocked at first; all are completed at the end; Reset locks all but the first | ✅ |
| **Staircase:** taller than the screen and starts at the top; some objects lie below the first screen; the mouse wheel scrolls down and back up; a hint scrolls the camera to the object; the drawer stays locked until the iron key is found; 7 / 7 completes once | ✅ |
| **Washroom:** keypad 0606 opens it; steam covers the room; moving the mouse wipes it; it returns after a few seconds; the cabinet stays locked until its key is found; 8 / 8 | ✅ |
| **Living room:** lights start on; the first cut is scheduled at a random time; a cut makes the room dark and tells the player; the cut has a random length; objects can be found during a cut; the lights come back; no more cuts after finishing; 8 / 8 | ✅ |
| **Kitchen:** the list shows riddles; a found object's riddle turns into its name; the biscuit tin stays shut until the tin opener is found; 9 / 9 | ✅ |
| **Study:** the safe asks for a code; Step Back closes the keypad without opening it; a wrong code keeps it shut; 1704 opens it and reveals the will; the opened safe is saved; the jammed drawer needs the letter opener; 9 / 9 | ✅ |
| Every chapter's letter appears and its completion is saved; Continue appears until the last chapter; the last one says THE END | ✅ |

## Problems found and fixed

* **Kitchen riddles were cut off** with "…" in the objective list. Riddle rows now wrap onto two lines.
* **The study's secret compartment** looked like a small cupboard. A new "book spines" container style fixes it.
* **The sugar mouse** was called pink in one text and white in another. Both now say white.
* **Test only, not a game bug:** Godot reads the REAL mouse pointer every frame. In the test, the
  computer's actual mouse could scroll the staircase or clear steam. The test now moves the real cursor
  where it needs it and turns off edge scrolling. The game itself now edge-scrolls only while its
  window has focus.

## Limitations and notes

* **Headless mode:** Godot doesn't deliver mouse clicks to objects in `--headless` mode,
  so the play-through needs a real window. Don't use the mouse while it runs.
* **Not tested automatically:**
  * whether the sound is audible;
  * the hover cursor;
  * edge scrolling on the staircase (it depends on the real mouse);
  * the second keypad hint;
  * a random power cut firing *by itself* (the test triggers one directly and checks the random timer values);
  * the Quit button (only its existence is checked) and fullscreen.
* **Difficulty balance** was judged from screenshots and numbers, not by real players. The test proves
  each chapter is harder *by the numbers*; how hard it *feels* still needs players.
* **Performance** of the steam effect was only seen on this machine (smooth). It updates a
  80×45 grid every frame; raise `cell_size` on `SteamFog` if a slow computer stutters.
