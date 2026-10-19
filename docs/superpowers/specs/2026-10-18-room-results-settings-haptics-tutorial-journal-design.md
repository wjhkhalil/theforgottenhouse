# Room results, settings, haptics, tutorial and journal

Date: 2026-10-18. Five features that bring The Forgotten House up to what
players expect from a hidden-object game on the Play Store. All five are
additive: old save files keep working, and no chapter scene needs editing
except the bedroom's level data.

## 1. Room results (stars)

**What the player sees.** The chapter-complete screen shows three large stars
that pop in one after another, then a line with the time taken, hints used and
wrong taps, and the three star rules with a tick or a cross. The Chapters list
shows the best stars next to every completed chapter, and the panel title shows
the total stars collected.

**Rules.** Stars are simple enough to explain in one line each:

| Star | Rule |
|------|------|
| 1 | Finish the chapter |
| 2 | Use no hints |
| 3 | At most 3 wrong taps |

Time is recorded and the best time is kept, but it never costs a star: rooms
with tides, power cuts and bats make a fair par time impossible to tune.

**Wrong tap** = a tap or click that lands on nothing (not an object, container,
button or panel), and that does not move more than a few pixels (a drag is
looking around, not a tap). A full-room `MissCatcher` Area2D sits behind every
other node and receives exactly those clicks, because physics picking is set to
"first only". The loft's bat colony already owns the lowest catcher there, so in
that room the colony's `stirred`, `swarm_started` and `click_blocked` signals
count the wrong taps instead.

**Where the numbers live.** `GameManager` (one per room) keeps
`elapsed_seconds`, `hints_used` and `wrong_taps`. The clock only runs while
searching is enabled and the room is not complete; pausing stops it because
`_process` stops. The three numbers are saved with the room progress, so
leaving and coming back keeps them. `RoomResult` (static helpers) turns them
into stars and formats the time. `SaveManager.record_result()` keeps the best
stars and best time per chapter and reports whether either improved.

## 2. Settings

A `SettingsPanel` scene used by both the main menu and the pause menu:
music volume, effects volume, all sound on/off, vibration on/off, and Back.
Sliders play the click sound on release so the level can be heard.
`AudioManager` creates two buses at start, "Music" and "SFX", both sent to
Master, and the sliders set their volume. Values are stored in the save
file's settings section: `music_volume`, `sfx_volume`, `sound_muted`,
`vibration_enabled`. The HUD's Sound button keeps working and stays in sync.

## 3. Haptics

A small `Haptics` autoload with named pulses: `found()`, `open()`, `wrong()`,
`tap()` and `complete()`. Each calls `Input.vibrate_handheld()` with a short
duration, only when vibration is enabled in the settings. Desktop builds
ignore the call. Called when an object is collected, a container opens, a wrong
tap or a wrong keypad code happens, a star pops in, and the chapter completes.

## 4. Tutorial

A `Tutorial` CanvasLayer shown in the first room on the first play (the
bedroom's level data has `show_tutorial` on, and the save flag `tutorial_done`
is off). A card at the bottom of the screen explains one thing at a time, and a
drawn hand with a pulsing ring points at the thing to tap. Steps:

1. Tap an object in the room (hand on the first unfound object; advances when
   anything is collected).
2. Clues: every find leaves a clue, kept in the Journal. (Got it)
3. Hint button (hand on it; advances on Hint or Got it). Says that no hints
   earns a star, so the player is not pushed into losing it.
4. Zooming and looking around, phone or desktop wording. (Got it)
5. Wrong taps and the third star. (Got it, finishes)

Skip is always available. Finishing or skipping sets `tutorial_done`. The card
and hand never block the room: only the card's buttons take input.

## 5. Journal

A `Journal` CanvasLayer opened from the main menu and the pause menu. The left
column lists completed chapters under their house headings; the right side is
the letter on paper, the way the in-room letter looks, followed by the clues
found in that chapter. Clues are recorded in the save file when an object is
collected (`journal_clues`, per chapter, name and clue text) and stay after the
chapter is complete. Letters come from each chapter's `LevelData` file. An empty
journal explains that finishing a chapter adds its letter.

## Testing

The gameplay test gains checks for: the tutorial appearing on first play and
not after Skip; stars, time and the saved result on the bedroom's completion
screen; stars in the Chapters list; a journal entry with the bedroom letter and
its five clues; settings values surviving a save and reload. The full test run
is the acceptance gate, plus screenshots of each new screen on desktop and the
phone layout.
