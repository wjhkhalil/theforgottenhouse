# Art Prompts for Objects and Containers

Ready-to-paste prompts for an AI image generator, one per asset. See `REQUIRED_OBJECTS.md` for the
full list and `ART_DIRECTION.md` for the style rules these prompts follow.

## How to use

1. Paste one prompt at a time. For a consistent look, attach a finished sprite (for example
   `assets/objects/music_box_v1.png`) as a style reference with each request.
2. If the result has a background, remove it with a background remover before saving.
3. **Containers need two images.** Generate the closed one first, then attach it when you paste
   the open prompt so the angle and size match.
4. Save objects as `assets/objects/<id>_v1.png` and containers as
   `assets/objects/<id>_closed_v1.png` and `assets/objects/<id>_open_v1.png`. Several rooms reuse a
   container id (`desk_drawer`, `sea_chest`, `key_box`...), so the suggested file names below add
   the room name.
5. Open-container images deliberately leave out the hidden object: the game draws it on top.
6. Prompts ask for illegible writing on purpose. AI lettering comes out garbled, and clue text is
   shown by the game, not by the picture.

To work faster, ask for a whole room at once: "Draw these N objects as separate items on one
plain sheet, evenly spaced, not touching", followed by that room's prompts, then cut them apart.

## House One: Ashworth Manor

### Bedroom

#### Objects (5)

**Missing Letter** — `missing_letter_v1.png` (already has art)

```
Missing Letter. A folded letter containing a mysterious message. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Old Diary** — `old_diary_v1.png` (already has art)

```
Old Diary. A worn diary belonging to the former owner. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Old Photograph** — `old_photograph_v1.png` (already has art)

```
Old Photograph. A faded photograph showing two people. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Rusty Key** — `rusty_key_v1.png` (already has art)

```
Rusty Key. An old rusty key that may unlock something in the house. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Teddy Bear** — `teddy_bear_v1.png` (already has art)

```
Teddy Bear. An old teddy bear with a small hidden clue. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Basement

#### Objects (6)

**Film Negatives** — `film_negatives_v1.png` (already has art)

```
Film Negatives. A strip of photographic film negatives. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and damp-stained. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Hospital Wristband** — `hospital_wristband_v1.png` (already has art)

```
Hospital Wristband. A small plastic hospital wristband. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and damp-stained. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Muddy Boots** — `muddy_boots_v1.png` (already has art)

```
Muddy Boots. A pair of small rubber boots. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and damp-stained. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Music Box** — `music_box_v1.png` (already has art)

```
Music Box. A small wooden music box with an inlaid flower. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and damp-stained. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Newspaper Clipping** — `newspaper_clipping_v1.png` (already has art)

```
Newspaper Clipping. An old newspaper clipping. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and damp-stained. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pocket Watch** — `pocket_watch_v1.png` (already has art)

```
Pocket Watch. A tarnished gold pocket watch. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and damp-stained. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (1)

**old_trunk** — already has art (`old_trunk_closed_v1.png`, `old_trunk_open_v1.png`)

### Attic

#### Objects (7)

**Account Ledger** — `account_ledger_v1.png`

```
Account Ledger. A green cloth account book. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Small Brass Key** — `brass_key_v1.png`

```
Small Brass Key. A tiny, ornate brass key. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Child's Drawing** — `childs_drawing_v1.png`

```
Child's Drawing. A crayon drawing pinned to the wood. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Cracked Spectacles** — `cracked_spectacles_v1.png`

```
Cracked Spectacles. Wire-rimmed reading glasses. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Last Will** — `last_will_v1.png`

```
Last Will. A folded legal document with a black ribbon. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Silver Locket** — `silver_locket_v1.png`

```
Silver Locket. A silver locket on a fine chain. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Telegram** — `telegram_v1.png`

```
Telegram. A yellow telegram. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (2)

**jewellery_box** — `attic_jewellery_box_closed_v1.png`, `attic_jewellery_box_open_v1.png`

Closed:

```
A small wooden jewellery box with a brass keyhole, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid raised, faded velvet lining, otherwise empty. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**hat_box** — `attic_hat_box_closed_v1.png`, `attic_hat_box_open_v1.png`

Closed:

```
A round striped cardboard hat box with its lid on. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid off and leaning against the box, crumpled tissue paper inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Staircase

#### Objects (7)

**Boathouse Map** — `boathouse_map_v1.png`

```
Boathouse Map. A hand-drawn map of the lake path. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Empty Key Ring** — `empty_key_ring_v1.png`

```
Empty Key Ring. A heavy iron ring with paper labels. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Blue Hair Ribbon** — `hair_ribbon_v1.png`

```
Blue Hair Ribbon. A blue ribbon tied in a double knot. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Small Iron Key** — `iron_key_v1.png`

```
Small Iron Key. A small iron key with a drawer tag. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Leather Glove** — `leather_glove_v1.png`

```
Leather Glove. A man's leather glove, caked with mud. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Brass Nameplate** — `portrait_nameplate_v1.png`

```
Brass Nameplate. A small engraved brass plate. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Cut Telephone Cord** — `telephone_cord_v1.png`

```
Cut Telephone Cord. The telephone's cord, sliced through. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (2)

**grandfather_clock** — `staircase_grandfather_clock_closed_v1.png`, `staircase_grandfather_clock_open_v1.png`

Closed:

```
A tall dark-wood grandfather clock, long case door closed, hands stopped. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: long case door swung open, the still brass pendulum visible inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**hall_table_drawer** — `staircase_hall_table_drawer_closed_v1.png`, `staircase_hall_table_drawer_open_v1.png`

Closed:

```
The front of a narrow hall-table drawer with an iron keyhole and a brass pull, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer pulled out, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Washroom

#### Objects (8)

**Hairbrush** — `hairbrush_v1.png`

```
Hairbrush. A silver-backed hairbrush. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Perfume Bottle** — `perfume_bottle_v1.png`

```
Perfume Bottle. A nearly empty perfume bottle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Rubber Duck** — `rubber_duck_v1.png`

```
Rubber Duck. An old faded rubber duck. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Sleeping Pills** — `sleeping_pills_v1.png`

```
Sleeping Pills. A brown pill bottle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Soap with a Key Mark** — `soap_imprint_v1.png`

```
Soap with a Key Mark. A bar of soap with a key pressed into it. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Straight Razor** — `straight_razor_v1.png`

```
Straight Razor. A folding razor engraved 'T.G.' Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Tiny Cabinet Key** — `tiny_cabinet_key_v1.png`

```
Tiny Cabinet Key. A tiny key on a ribbon. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wet Photograph** — `wet_photograph_v1.png`

```
Wet Photograph. A soaked photograph. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (2)

**medicine_cabinet** — `washroom_medicine_cabinet_closed_v1.png`, `washroom_medicine_cabinet_open_v1.png`

Closed:

```
A small white-painted wall medicine cabinet with a mirrored door and a tiny keyhole, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, shelves of old glass bottles. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**laundry_basket** — `washroom_laundry_basket_closed_v1.png`, `washroom_laundry_basket_open_v1.png`

Closed:

```
A tall wicker laundry basket with its lid on. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, damp towels inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Living Room

#### Objects (8)

**Crossword** — `crossword_v1.png`

```
Crossword. A folded newspaper crossword. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Desk Key** — `desk_key_v1.png`

```
Desk Key. A brass desk key. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Gramophone Record** — `gramophone_record_v1.png`

```
Gramophone Record. A black shellac record. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Insurance Policy** — `insurance_policy_v1.png`

```
Insurance Policy. A life insurance policy. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Knitted Scarf** — `knitted_scarf_v1.png`

```
Knitted Scarf. A half-finished scarf. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Matchbox** — `matchbox_v1.png`

```
Matchbox. A matchbox from the Blackwater Inn. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Spare Key Ring** — `spare_keys_v1.png`

```
Spare Key Ring. A ring full of keys. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Tobacco Pipe** — `tobacco_pipe_v1.png`

```
Tobacco Pipe. A briar pipe, still warm. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (3)

**piano_bench** — `living_room_piano_bench_closed_v1.png`, `living_room_piano_bench_open_v1.png`

Closed:

```
An upholstered piano bench with a hinged seat, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: seat lifted, old sheet music inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**cigar_box** — `living_room_cigar_box_closed_v1.png`, `living_room_cigar_box_open_v1.png`

Closed:

```
A wooden cigar box, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, a row of cigars inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**desk_drawer** — `living_room_desk_drawer_closed_v1.png`, `living_room_desk_drawer_open_v1.png`

Closed:

```
The front of a writing-desk drawer with a brass keyhole, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer pulled out, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Kitchen

#### Objects (9)

**Burnt Letter** — `burnt_letter_v1.png`

```
Burnt Letter. A half-burnt letter. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Egg Timer** — `egg_timer_v1.png`

```
Egg Timer. A small sand timer. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lake Pebble** — `lake_pebble_v1.png`

```
Lake Pebble. A smooth black pebble, still wet. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Rat Poison Tin** — `rat_poison_tin_v1.png`

```
Rat Poison Tin. A rusty tin of rat poison. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Recipe Card** — `recipe_card_v1.png`

```
Recipe Card. Mother's handwritten recipe card. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Servants' Door Key** — `servants_key_v1.png`

```
Servants' Door Key. A long old iron key. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Sugar Mouse** — `sugar_mouse_v1.png`

```
Sugar Mouse. A white sugar mouse in wax paper. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Tin Opener** — `tin_opener_v1.png`

```
Tin Opener. An old tin opener. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wooden Spoon** — `wooden_spoon_v1.png`

```
Wooden Spoon. A well-used wooden spoon. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (3)

**bread_bin** — `kitchen_bread_bin_closed_v1.png`, `kitchen_bread_bin_open_v1.png`

Closed:

```
A chipped enamel bread bin with its lid on. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**oven** — `kitchen_oven_closed_v1.png`, `kitchen_oven_open_v1.png`

Closed:

```
The black cast-iron door of an old kitchen range oven, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door hanging open, cold grey ashes inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**biscuit_tin** — `kitchen_biscuit_tin_closed_v1.png`, `kitchen_biscuit_tin_open_v1.png`

Closed:

```
A decorated round biscuit tin with a tight lid. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid prised off, crumpled wax paper inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Study

#### Objects (9)

**Boathouse Key** — `boathouse_key_v1.png`

```
Boathouse Key. A heavy key tagged 'Boathouse'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Calendar Page** — `calendar_page_v1.png`

```
Calendar Page. A page from a wall calendar. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Forged Signatures** — `forged_signatures_v1.png`

```
Forged Signatures. A page of practice signatures. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Fountain Pen** — `fountain_pen_v1.png`

```
Fountain Pen. A black fountain pen. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Letter Opener** — `letter_opener_v1.png`

```
Letter Opener. A silver letter opener. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Magnifying Glass** — `magnifying_glass_v1.png`

```
Magnifying Glass. A brass magnifying glass. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Mara's Portrait** — `mara_portrait_v1.png`

```
Mara's Portrait. A small oil portrait. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**The Real Will** — `real_will_v1.png`

```
The Real Will. The Ashworth family's true will. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Signet Ring** — `signet_ring_v1.png`

```
Signet Ring. A gold ring stamped 'T.G.' Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (4)

**humidor** — `study_humidor_closed_v1.png`, `study_humidor_open_v1.png`

Closed:

```
A polished wooden cigar humidor, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, cigars inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**desk_drawer** — `study_desk_drawer_closed_v1.png`, `study_desk_drawer_open_v1.png`

Closed:

```
The front of a heavy mahogany desk drawer with a brass handle and keyhole, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer forced open, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**wall_safe** — `study_wall_safe_closed_v1.png`, `study_wall_safe_open_v1.png`

Closed:

```
A small steel wall safe with a combination dial, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door swung open, an empty shelf inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**bookcase_compartment** — `study_bookcase_compartment_closed_v1.png`, `study_bookcase_compartment_open_v1.png`

Closed:

```
A row of old leather book spines on a shelf, seen from the front. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: the whole row of spines swung outward as one hinged panel, a dark empty compartment behind. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, dusty and worn with age. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

## House Two: Blackwater Boathouse

### Jetty

#### Objects (10)

**Brass Compass** — `brass_compass_v1.png`

```
Brass Compass. A ship's compass, its glass cracked. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Silver Cigarette Case** — `cigarette_case_v1.png`

```
Silver Cigarette Case. A dented silver case engraved 'R.V.' Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Fishing Float** — `fishing_float_v1.png`

```
Fishing Float. A red and white float bobbing on the water. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Torn Logbook Page** — `log_page_v1.png`

```
Torn Logbook Page. A page torn from a boat's logbook. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Bottle with a Note** — `message_bottle_v1.png`

```
Bottle with a Note. A corked green bottle with paper inside. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Boat Nameboard** — `name_board_v1.png`

```
Boat Nameboard. A broken plank with a boat's name painted on it. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Broken Police Seal** — `police_seal_v1.png`

```
Broken Police Seal. Police tape that sealed the boathouse door, torn through. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Prescription Pad** — `prescription_v1.png`

```
Prescription Pad. A doctor's prescription pad, half the pages missing. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Boat Registration** — `registration_v1.png`

```
Boat Registration. The Lady Margaret's registration papers. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Small Padlock Key** — `tackle_key_v1.png`

```
Small Padlock Key. A tiny key on a cork key ring. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (4)

**bait_bucket** — `jetty_bait_bucket_closed_v1.png`, `jetty_bait_bucket_open_v1.png`

Closed:

```
A galvanised metal bait bucket, upright. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: tipped over on its side, old bait spilled out. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**tackle_box** — `jetty_tackle_box_closed_v1.png`, `jetty_tackle_box_open_v1.png`

Closed:

```
A metal fishing tackle box, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, hooks and lures in trays. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**fish_crate** — `jetty_fish_crate_closed_v1.png`, `jetty_fish_crate_open_v1.png`

Closed:

```
A wooden fish crate with a lid held shut by a small padlock. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: padlock off, lid open, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**dock_locker** — `jetty_dock_locker_closed_v1.png`, `jetty_dock_locker_open_v1.png`

Closed:

```
A tall narrow iron dock locker with a four-wheel combination lock, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, an old oilskin coat hanging inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Boat Shed

#### Objects (11)

**Bank Receipt** — `bank_receipt_v1.png`

```
Bank Receipt. A bank slip for a monthly payment. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Workbench Key** — `bench_key_v1.png`

```
Workbench Key. A small key tagged 'bench'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Brass Coat Button** — `coat_button_v1.png`

```
Brass Coat Button. A brass button with a snake-and-staff crest. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Diving Goggles** — `diving_goggles_v1.png`

```
Diving Goggles. Rubber diving goggles, still wet. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Dropped Torch** — `dropped_torch_v1.png`

```
Dropped Torch. An electric torch, still switched on. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Bottle of Ether** — `ether_bottle_v1.png`

```
Bottle of Ether. A brown glass bottle, half empty. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**R.V. Handkerchief** — `handkerchief_v1.png`

```
R.V. Handkerchief. A white handkerchief embroidered 'R.V.' Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Loft Hatch Key** — `loft_key_v1.png`

```
Loft Hatch Key. A long iron key tagged 'LOFT'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Mara's Purse** — `maras_purse_v1.png`

```
Mara's Purse. A small beaded purse, soaked through. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ship's Bell** — `ship_bell_v1.png`

```
Ship's Bell. A small brass bell, green with age. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Train Ticket** — `train_ticket_v1.png`

```
Train Ticket. A one-way railway ticket. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (5)

**first_aid_box** — `boat_shed_first_aid_box_closed_v1.png`, `boat_shed_first_aid_box_open_v1.png`

Closed:

```
A white metal wall-mounted first-aid box with a red cross, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, bare shelves inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**strongbox** — `boat_shed_strongbox_closed_v1.png`, `boat_shed_strongbox_open_v1.png`

Closed:

```
A small rusty iron strongbox, wet and streaked with lake weed, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid prised open, wet and empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**workbench_drawer** — `boat_shed_workbench_drawer_closed_v1.png`, `boat_shed_workbench_drawer_open_v1.png`

Closed:

```
The front of a rough wooden workbench drawer with a small keyhole, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer pulled out, screws and nails inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**net_basket** — `boat_shed_net_basket_closed_v1.png`, `boat_shed_net_basket_open_v1.png`

Closed:

```
A wicker basket heaped with old fishing nets. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: nets pulled out and draped over the side, basket empty. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**tool_chest** — `boat_shed_tool_chest_closed_v1.png`, `boat_shed_tool_chest_open_v1.png`

Closed:

```
A large wooden tool chest with iron bands and a four-wheel combination padlock, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, trays of hand tools inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Loft

#### Objects (12)

**Knotted Bedsheet** — `bedsheet_rope_v1.png`

```
Knotted Bedsheet. Torn sheets knotted together into a rope, cut short. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Warm Candle Stub** — `candle_stub_v1.png`

```
Warm Candle Stub. A stub of white candle in a tin holder. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Bent Hairpin** — `hairpin_v1.png`

```
Bent Hairpin. A black hairpin, bent and worn bright at the tip. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Padlock Key** — `padlock_key_v1.png`

```
Padlock Key. A little brass key on a loop of red string. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Cracked Mirror** — `pocket_mirror_v1.png`

```
Cracked Mirror. A little hand mirror with a crack across the glass. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pressed Violet** — `pressed_violet_v1.png`

```
Pressed Violet. A dried violet folded in a scrap of paper. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Rag Doll** — `rag_doll_v1.png`

```
Rag Doll. A doll sewn from sacking, with odd button eyes. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Sedative Vial** — `sedative_vial_v1.png`

```
Sedative Vial. A small vial with a chemist's label. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Dented Tin Cup** — `tin_cup_v1.png`

```
Dented Tin Cup. A battered tin cup with chipped blue enamel. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Unsent Letter** — `unsent_letter_v1.png`

```
Unsent Letter. An envelope addressed to Eleanor Ashworth, never posted. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Visiting Card** — `visiting_card_v1.png`

```
Visiting Card. Dr R. Vane, M.D. - Sundays by arrangement. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Workshop Key** — `workshop_key_v1.png`

```
Workshop Key. A heavy iron key tagged WORKSHOP. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (6)

**sewing_basket** — `loft_sewing_basket_closed_v1.png`, `loft_sewing_basket_open_v1.png`

Closed:

```
A small wicker sewing basket with its lid on. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, cotton reels and a thimble inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**hatbox** — `loft_hatbox_closed_v1.png`, `loft_hatbox_open_v1.png`

Closed:

```
A striped round hatbox with its lid on. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid off beside it, a scrap of blanket inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**biscuit_tin** — `loft_biscuit_tin_closed_v1.png`, `loft_biscuit_tin_open_v1.png`

Closed:

```
An old dented square biscuit tin, lid on. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid off beside it, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**loose_floorboard** — `loft_loose_floorboard_closed_v1.png`, `loft_loose_floorboard_open_v1.png`

Closed:

```
A short section of worn wooden floorboard seen from above, one end slightly raised. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: the board lifted aside, a dusty dark gap beneath. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**doctors_case** — `loft_doctors_case_closed_v1.png`, `loft_doctors_case_open_v1.png`

Closed:

```
A black leather doctor's case fastened with a small padlock, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: case open, cotton wool and rows of small glass vials inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**sea_chest** — `loft_sea_chest_closed_v1.png`, `loft_sea_chest_open_v1.png`

Closed:

```
A wooden sea chest with rope handles and a four-wheel combination lock, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, a folded coat inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Workshop

#### Objects (13)

**Boat Model** — `boat_model_v1.png`

```
Boat Model. A painted model of the Lady Margaret on a little stand. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Cupboard Key** — `cupboard_key_v1.png`

```
Cupboard Key. A long iron key with a paper tag: 'TOOL CUPBD.' Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Diving Lamp** — `diving_lamp_v1.png`

```
Diving Lamp. A heavy brass diving lamp with a caged glass globe. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Hand Drill** — `hand_drill_v1.png`

```
Hand Drill. An old wheel brace with a long auger bit. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Torn Hull Plan** — `hull_plan_v1.png`

```
Torn Hull Plan. The Lady Margaret's hull plan, torn in four and put back together. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Job Book** — `job_book_v1.png`

```
Job Book. Greaves's job book, open at October 1988. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Letter Stencil** — `letter_stencil_v1.png`

```
Letter Stencil. A brass stencil plate cut with the letters S W A N. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Mallet** — `mallet_v1.png`

```
Mallet. A beech mallet with dented faces. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Oil Can** — `oil_can_v1.png`

```
Oil Can. A pump oil can with a long brass spout. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Paint Tin** — `paint_tin_v1.png`

```
Paint Tin. A tin of white boat paint with the lid off. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wood Plane** — `wood_plane_v1.png`

```
Wood Plane. A beech smoothing plane with a curl of shaving in its mouth. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wooden Bung** — `wooden_bung_v1.png`

```
Wooden Bung. A tapered oak plug, greased and dark with lake water. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wet Work Glove** — `work_glove_v1.png`

```
Wet Work Glove. A leather work glove, soaked through. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (6)

**bench_drawer** — `workshop_bench_drawer_closed_v1.png`, `workshop_bench_drawer_open_v1.png`

Closed:

```
The front of a paint-spattered workbench drawer, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer pulled out, pencils and a folding rule inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**bung_crate** — `workshop_bung_crate_closed_v1.png`, `workshop_bung_crate_open_v1.png`

Closed:

```
A small greasy wooden crate with a lid on. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid off beside it, almost empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**log_basket** — `workshop_log_basket_closed_v1.png`, `workshop_log_basket_open_v1.png`

Closed:

```
A wicker basket full of logs and kindling. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: logs pulled aside, basket half empty. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**stencil_box** — `workshop_stencil_box_closed_v1.png`, `workshop_stencil_box_open_v1.png`

Closed:

```
A flat wooden box with a sliding lid, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid slid open, rows of brass stencil plates inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**cash_box** — `workshop_cash_box_closed_v1.png`, `workshop_cash_box_open_v1.png`

Closed:

```
A small steel cash box with a four-wheel combination lock, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**tool_cupboard** — `workshop_tool_cupboard_closed_v1.png`, `workshop_tool_cupboard_open_v1.png`

Closed:

```
A tall wooden tool cupboard with a keyhole, doors closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: doors open, a diving mask and a coil of line hanging inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, weathered and damp-worn, with rust on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Sunken Boat

#### Objects (13)

**Cabin Key** — `cabin_key_v1.png`

```
Cabin Key. A brass key on a bone tag marked CABIN. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Drill Bit** — `drill_bit_v1.png`

```
Drill Bit. A long auger drill bit with a square shank. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Hair Comb** — `hair_comb_v1.png`

```
Hair Comb. A tortoiseshell hair comb with one tooth missing. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ice House Key** — `ice_house_key_v1.png`

```
Ice House Key. An old iron key on a ring, with a wooden tag burnt ICE HOUSE. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Iron Shackle** — `iron_shackle_v1.png`

```
Iron Shackle. An iron shackle on a short chain, the cuff cut through. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pearl Earring** — `pearl_earring_v1.png`

```
Pearl Earring. A single pearl drop earring on a gold hook. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Sextant** — `sextant_v1.png`

```
Sextant. A brass sextant for finding your way by the stars. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ship's Lantern** — `ship_lantern_v1.png`

```
Ship's Lantern. The Lady Margaret's brass lantern, its glass cracked. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ship's Log** — `ship_log_v1.png`

```
Ship's Log. Vane's leather-bound ship's log, swollen with lake water. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Silver Frame** — `silver_frame_v1.png`

```
Silver Frame. A tarnished silver photo frame. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Steel File** — `steel_file_v1.png`

```
Steel File. A small steel file with a wooden handle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**China Teacup** — `teacup_v1.png`

```
China Teacup. A china teacup painted with a little rose, still on its saucer. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wine Bottle** — `wine_bottle_v1.png`

```
Wine Bottle. A bottle of good red wine, still corked. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (7)

**chart_drawer** — `sunken_boat_chart_drawer_closed_v1.png`, `sunken_boat_chart_drawer_open_v1.png`

Closed:

```
The front of a swollen wooden chart drawer with a brass pull, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer pulled open, soggy rolled charts inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**cabin_door** — `sunken_boat_cabin_door_closed_v1.png`, `sunken_boat_cabin_door_open_v1.png`

Closed:

```
A narrow wooden ship's cabin door with a brass lock, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door swung open, a bare bunk and an open porthole beyond. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**key_box** — `sunken_boat_key_box_closed_v1.png`, `sunken_boat_key_box_open_v1.png`

Closed:

```
A small steel wall key box with a combination dial, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, rows of empty key hooks inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**skipper_locker** — `sunken_boat_skipper_locker_closed_v1.png`, `sunken_boat_skipper_locker_open_v1.png`

Closed:

```
A wooden skipper's locker, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, oilskins hanging inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**galley_cupboard** — `sunken_boat_galley_cupboard_closed_v1.png`, `sunken_boat_galley_cupboard_open_v1.png`

Closed:

```
A small two-door galley cupboard, doors closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: doors drifted open, broken plates inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**toolbox** — `sunken_boat_toolbox_closed_v1.png`, `sunken_boat_toolbox_open_v1.png`

Closed:

```
A rusty metal toolbox, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, spanners inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**ditty_box** — `sunken_boat_ditty_box_closed_v1.png`, `sunken_boat_ditty_box_open_v1.png`

Closed:

```
A small carved wooden keepsake box, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, a hair ribbon inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, waterlogged and silted, with heavy rust on any metal, as if long underwater. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Ice House

#### Objects (14)

**Frozen Brooch** — `frozen_brooch_v1.png`

```
Frozen Brooch. A little silver swallow brooch, caught in a disc of ice. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Frozen Pike** — `frozen_pike_v1.png`

```
Frozen Pike. A big lake pike, frozen stiff. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Horse Blanket** — `horse_blanket_v1.png`

```
Horse Blanket. A rough brown horse blanket with a red stripe. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ice Pick** — `ice_pick_v1.png`

```
Ice Pick. A long ice pick with a wooden handle and a sharp steel spike. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ice Saw** — `ice_saw_v1.png`

```
Ice Saw. A long two-handled saw with ragged teeth. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ice Tongs** — `ice_tongs_v1.png`

```
Ice Tongs. Heavy iron tongs for lifting blocks of ice. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Keeper's Note** — `keepers_note_v1.png`

```
Keeper's Note. A folded note on lined paper with a little lighthouse printed in the corner. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lighthouse Key** — `lighthouse_key_v1.png`

```
Lighthouse Key. A big iron key with a brass tag stamped with a lighthouse. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lost Mitten** — `lost_mitten_v1.png`

```
Lost Mitten. A red knitted mitten with a white snowflake. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Scratched Slate** — `scratched_slate_v1.png`

```
Scratched Slate. A small school slate in a wooden frame. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Signal Whistle** — `signal_whistle_v1.png`

```
Signal Whistle. A brass signal whistle on a tarred cord. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Snowshoe** — `snowshoe_v1.png`

```
Snowshoe. A wooden snowshoe strung with rawhide. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Soup Tin** — `soup_tin_v1.png`

```
Soup Tin. An empty tin of soup with a wire handle, still faintly warm-smelling. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Torn Sleeve** — `torn_sleeve_v1.png`

```
Torn Sleeve. The sleeve of a thin blue nightdress, torn off at the shoulder. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (6)

**agnes_basket** — `ice_house_agnes_basket_closed_v1.png`, `ice_house_agnes_basket_open_v1.png`

Closed:

```
A wicker food basket with a lid, a clean cloth tucked under it. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, a cloth and a spoon inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**sawdust_bin** — `ice_house_sawdust_bin_closed_v1.png`, `ice_house_sawdust_bin_open_v1.png`

Closed:

```
A wooden bin heaped with sawdust. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: sawdust dug out, a hollow in the middle. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**tool_locker** — `ice_house_tool_locker_closed_v1.png`, `ice_house_tool_locker_open_v1.png`

Closed:

```
An iron tool locker with a four-wheel combination lock, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, rusty hooks inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**pike_ice** — `ice_house_pike_ice_closed_v1.png`, `ice_house_pike_ice_open_v1.png`

Closed:

```
A large block of cloudy ice with the dark blurred shape of a fish frozen inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: the block split into broken chunks of clear ice, nothing inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**brooch_ice** — `ice_house_brooch_ice_closed_v1.png`, `ice_house_brooch_ice_open_v1.png`

Closed:

```
A small block of cloudy ice with a faint glint deep inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: the block broken into small chunks of ice, nothing inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**drain_ice** — `ice_house_drain_ice_closed_v1.png`, `ice_house_drain_ice_open_v1.png`

Closed:

```
A flat slab of ice frozen over a round iron floor drain, a dark blurred shape inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: the slab broken in two, the iron drain grate visible between the halves. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, lightly rimed with frost. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Lighthouse Steps

#### Objects (14)

**Bandage Roll** — `bandage_roll_v1.png`

```
Bandage Roll. A roll of white cotton bandage with a safety pin. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Barometer** — `barometer_v1.png`

```
Barometer. A banjo barometer in a wooden case, its needle swung right round to STORMY. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Gull Feather** — `gull_feather_v1.png`

```
Gull Feather. A long grey-and-white feather, blown in through a window. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Keeper's Logbook** — `keeper_logbook_v1.png`

```
Keeper's Logbook. A thick logbook bound in green leather, full of dated entries. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Keeper's Photo** — `keepers_photo_v1.png`

```
Keeper's Photo. A small framed photograph of two women by the lighthouse. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Knitting Needles** — `knitting_needles_v1.png`

```
Knitting Needles. Two wooden needles stuck through a ball of blue wool. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lamp Room Key** — `lamp_room_key_v1.png`

```
Lamp Room Key. A heavy iron key on a wooden tag marked LAMP. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lifesaving Medal** — `lifesaving_medal_v1.png`

```
Lifesaving Medal. A silver medal on a blue and white ribbon. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Oilskin Hat** — `oilskin_hat_v1.png`

```
Oilskin Hat. Agnes Hale's yellow sou'wester, still beaded with rain. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Paraffin Can** — `paraffin_can_v1.png`

```
Paraffin Can. A small red can of lamp oil with a bent spout. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ship in a Bottle** — `ship_in_bottle_v1.png`

```
Ship in a Bottle. A tiny sailing ship inside a green glass bottle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Telescope** — `telescope_v1.png`

```
Telescope. A brass spyglass with a worn leather grip. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Tide Table** — `tide_table_v1.png`

```
Tide Table. A printed tide table for 1988, with one night ringed in red. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wick Trimmer** — `wick_trimmer_v1.png`

```
Wick Trimmer. Long-bladed scissors with a little box to catch the burnt wick. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (6)

**oil_store** — `lighthouse_steps_oil_store_closed_v1.png`, `lighthouse_steps_oil_store_open_v1.png`

Closed:

```
A squat iron oil locker with a four-wheel combination lock, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, wicks and lamp mantles on a shelf inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**knitting_basket** — `lighthouse_steps_knitting_basket_closed_v1.png`, `lighthouse_steps_knitting_basket_open_v1.png`

Closed:

```
A wicker basket full of balls of wool. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: the wool pushed aside, basket half empty. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**twine_parcel** — `lighthouse_steps_twine_parcel_closed_v1.png`, `lighthouse_steps_twine_parcel_open_v1.png`

Closed:

```
A brown paper parcel tied tightly with twine. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: twine cut, the paper unfolded, a knitted scarf inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**medal_box** — `lighthouse_steps_medal_box_closed_v1.png`, `lighthouse_steps_medal_box_open_v1.png`

Closed:

```
A small hinged presentation case with a metal catch, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, faded red velvet lining, otherwise empty. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**key_box** — `lighthouse_steps_key_box_closed_v1.png`, `lighthouse_steps_key_box_open_v1.png`

Closed:

```
A small wall-mounted key box with a rusted hinge, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, a single empty hook inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**first_aid_tin** — `lighthouse_steps_first_aid_tin_closed_v1.png`, `lighthouse_steps_first_aid_tin_open_v1.png`

Closed:

```
A dented first-aid tin with a red cross, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, an iodine bottle, lint and scissors inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Lamp Room

#### Objects (15)

**Bell Hammer** — `bell_hammer_v1.png`

```
Bell Hammer. A round iron hammer on a worn wooden handle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Binoculars** — `binoculars_v1.png`

```
Binoculars. A pair of black marine binoculars with brass rims. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Chapel Key** — `chapel_key_v1.png`

```
Chapel Key. A big old iron key with a cross cut into its bow. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ferry Ticket** — `ferry_ticket_v1.png`

```
Ferry Ticket. A green card ticket for the island ferry. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lamp Mantle** — `lamp_mantle_v1.png`

```
Lamp Mantle. A spare gas mantle for the lamp, a little white woven sock. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lens Cloth** — `lens_cloth_v1.png`

```
Lens Cloth. A soft yellow chamois leather, black with soot at one corner. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Newspaper Page** — `newspaper_page_v1.png`

```
Newspaper Page. A yellowed page from the Blackwater Gazette. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Oil Funnel** — `oil_funnel_v1.png`

```
Oil Funnel. A small brass funnel for filling the lamp with paraffin. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pencil Sketch** — `pencil_sketch_v1.png`

```
Pencil Sketch. A pencil drawing of a young woman's face, with a name written underneath. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Postcard** — `postcard_v1.png`

```
Postcard. A picture postcard of a white chapel on a green island. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Radio Valve** — `radio_valve_v1.png`

```
Radio Valve. A glass radio valve with a black base and little pins. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Rosary** — `rosary_v1.png`

```
Rosary. A loop of wooden rosary beads with a small cross. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Telegram Form** — `telegram_form_v1.png`

```
Telegram Form. A yellow Post Office telegram with typed strips pasted on. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Tobacco Tin** — `tobacco_tin_v1.png`

```
Tobacco Tin. A flat red and gold tin of Navy Cut tobacco. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wind Gauge** — `wind_gauge_v1.png`

```
Wind Gauge. A hand-held wind gauge with three little cups. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (7)

**lens_cupboard** — `lamp_room_lens_cupboard_closed_v1.png`, `lamp_room_lens_cupboard_open_v1.png`

Closed:

```
A little iron cupboard, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, spare wicks and a tin of polish inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**desk_drawer** — `lamp_room_desk_drawer_closed_v1.png`, `lamp_room_desk_drawer_open_v1.png`

Closed:

```
The front of a lighthouse keeper's desk drawer, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer pulled out, pencils, string and a pipe inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**radio_cabinet** — `lamp_room_radio_cabinet_closed_v1.png`, `lamp_room_radio_cabinet_open_v1.png`

Closed:

```
A small wooden cabinet that sits under a radio set, doors closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: doors open, batteries and a coil of wire inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**rope_basket** — `lamp_room_rope_basket_closed_v1.png`, `lamp_room_rope_basket_open_v1.png`

Closed:

```
A lidded basket with rope coils showing under the lid. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, coils of rope inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**oil_locker** — `lamp_room_oil_locker_closed_v1.png`, `lamp_room_oil_locker_open_v1.png`

Closed:

```
An iron oil locker with a rusty jammed latch, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, cans of paraffin inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**writing_box** — `lamp_room_writing_box_closed_v1.png`, `lamp_room_writing_box_open_v1.png`

Closed:

```
A sloped wooden writing box with a four-wheel combination lock, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, a bundle of letters inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**sea_chest** — `lamp_room_sea_chest_closed_v1.png`, `lamp_room_sea_chest_open_v1.png`

Closed:

```
A painted wooden sea chest with a small brass lock, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, a folded Sunday coat inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, salt-worn, with oxidised brass on any metal. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Island Chapel

#### Objects (15)

**Candle Snuffer** — `candle_snuffer_v1.png`

```
Candle Snuffer. A long brass candle snuffer. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Collection Plate** — `collection_plate_v1.png`

```
Collection Plate. A brass plate lined with faded red felt. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Cottage Map** — `cottage_map_v1.png`

```
Cottage Map. A hand-drawn map of the lake. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Doctor's Letter** — `doctors_letter_v1.png`

```
Doctor's Letter. A letter on a doctor's headed paper. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Embroidery Hoop** — `embroidery_hoop_v1.png`

```
Embroidery Hoop. A wooden hoop with half-finished blue flowers. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Grey Veil** — `grey_veil_v1.png`

```
Grey Veil. A soft grey veil with a white band. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Hand Bell** — `hand_bell_v1.png`

```
Hand Bell. A brass hand bell with a wooden handle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Hymn Book** — `hymn_book_v1.png`

```
Hymn Book. A worn black hymn book with a gold cross on the cover. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Oarlock** — `oarlock_v1.png`

```
Oarlock. An iron oarlock with lake weed caught on it. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Parish Register** — `parish_register_v1.png`

```
Parish Register. A heavy leather-bound register of everyone who came to the chapel. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pewter Cup** — `pewter_cup_v1.png`

```
Pewter Cup. A plain pewter communion cup. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Prayer Card** — `prayer_card_v1.png`

```
Prayer Card. A small prayer card with a white lily on it. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Garden Trowel** — `trowel_v1.png`

```
Garden Trowel. A small garden trowel with dry earth on the blade. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Vestry Key** — `vestry_key_v1.png`

```
Vestry Key. A long iron key with a paper tag: VESTRY. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wooden Cross** — `wooden_cross_v1.png`

```
Wooden Cross. A small hand-carved wooden cross on a cord. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (9)

**alms_box** — `island_chapel_alms_box_closed_v1.png`, `island_chapel_alms_box_open_v1.png`

Closed:

```
An iron alms box with a coin slot and a four-wheel combination lock, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: iron lid swung up, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**vestry_door** — `island_chapel_vestry_door_closed_v1.png`, `island_chapel_vestry_door_open_v1.png`

Closed:

```
An arched oak vestry door with iron hinges, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, cassocks on hooks and a small desk beyond. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**sewing_basket** — `island_chapel_sewing_basket_closed_v1.png`, `island_chapel_sewing_basket_open_v1.png`

Closed:

```
A wicker sewing basket with its lid on. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, skeins of blue and red thread inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**pulpit_drawer** — `island_chapel_pulpit_drawer_closed_v1.png`, `island_chapel_pulpit_drawer_open_v1.png`

Closed:

```
A small drawer front set into carved pulpit woodwork, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer slid out, sermon notes and a pencil stub inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**parish_chest** — `island_chapel_parish_chest_closed_v1.png`, `island_chapel_parish_chest_open_v1.png`

Closed:

```
A long oak parish chest with iron straps, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, candle ends and a folded altar cloth inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**font_cover** — `island_chapel_font_cover_closed_v1.png`, `island_chapel_font_cover_open_v1.png`

Closed:

```
A stone baptismal font covered by a round wooden lid. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: the wooden lid lifted and set aside, the dry stone bowl empty. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**pew_box** — `island_chapel_pew_box_closed_v1.png`, `island_chapel_pew_box_open_v1.png`

Closed:

```
A small wooden pew box with a hinged lid, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**aumbry** — `island_chapel_aumbry_closed_v1.png`, `island_chapel_aumbry_open_v1.png`

Closed:

```
A small wall cupboard with two little wooden doors set in a stone surround, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: doors open, a folded linen cloth inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**candle_box** — `island_chapel_candle_box_closed_v1.png`, `island_chapel_candle_box_open_v1.png`

Closed:

```
A long tin candle box, lid closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, spare candles and a box of matches inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, old, worn and candle-smoked. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Vane Cottage

#### Objects (16)

**Carriage Clock** — `carriage_clock_v1.png`

```
Carriage Clock. A brass carriage clock, ready to travel. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Cellar Key** — `cellar_key_v1.png`

```
Cellar Key. A heavy iron key with a tag: 'CELLAR'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Cheque Book** — `cheque_book_v1.png`

```
Cheque Book. A cheque book, open at the stubs. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Vane's Confession** — `confession_v1.png`

```
Vane's Confession. Two pages in Vane's handwriting. Unsent, and unsigned. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Death Certificate** — `death_certificate_v1.png`

```
Death Certificate. A death certificate for Mara Ashworth, aged 16, dated 1987. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Decanter** — `decanter_v1.png`

```
Decanter. A cut-glass decanter of brandy, half empty. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Glass Syringe** — `glass_syringe_v1.png`

```
Glass Syringe. An old glass syringe with a drop of cloudy liquid left in it. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Grey Shawl** — `grey_shawl_v1.png`

```
Grey Shawl. A soft grey wool shawl. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Medical File** — `medical_file_v1.png`

```
Medical File. A buff folder: 'PATIENT M. - PRIVATE'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Name Bracelet** — `name_bracelet_v1.png`

```
Name Bracelet. A small silver bracelet engraved 'MARA'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Passport** — `passport_v1.png`

```
Passport. Vane's passport, with a ticket tucked inside. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pen Knife** — `pen_knife_v1.png`

```
Pen Knife. A small folding pen knife with a pearl handle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Police Whistle** — `police_whistle_v1.png`

```
Police Whistle. An old nickel police whistle on a chain. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Specimen Jar** — `specimen_jar_v1.png`

```
Specimen Jar. A stoppered glass jar with a label: 'M. 87'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Stethoscope** — `stethoscope_v1.png`

```
Stethoscope. Dr Vane's stethoscope, the rubber tubes cracked with age. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Train Timetable** — `timetable_v1.png`

```
Train Timetable. A railway timetable, the 23:50 ringed in pencil. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (8)

**desk_drawer** — `vane_cottage_desk_drawer_closed_v1.png`, `vane_cottage_desk_drawer_open_v1.png`

Closed:

```
The front of a tidy doctor's desk drawer, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer pulled open, old papers and a stick of sealing wax inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**medicine_cupboard** — `vane_cottage_medicine_cupboard_closed_v1.png`, `vane_cottage_medicine_cupboard_open_v1.png`

Closed:

```
A low wooden cupboard that sits beneath a glass cabinet, doors closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: doors open, rolls of bandage and brown bottles inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**fake_spines** — `vane_cottage_fake_spines_closed_v1.png`, `vane_cottage_fake_spines_open_v1.png`

Closed:

```
A row of medical book spines on a shelf, seen from the front. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: the whole row of spines swung out as one small hinged door, a dark recess behind. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**log_basket** — `vane_cottage_log_basket_closed_v1.png`, `vane_cottage_log_basket_open_v1.png`

Closed:

```
A wicker log basket full of logs. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: logs lifted out, basket nearly empty. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**parcel** — `vane_cottage_parcel_closed_v1.png`, `vane_cottage_parcel_open_v1.png`

Closed:

```
A brown paper parcel tied with string. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: string cut, the paper folded open, empty. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**desk_safe** — `vane_cottage_desk_safe_closed_v1.png`, `vane_cottage_desk_safe_open_v1.png`

Closed:

```
A small desk safe with a combination dial, door closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open, an empty shelf inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**doctors_bag** — `vane_cottage_doctors_bag_closed_v1.png`, `vane_cottage_doctors_bag_open_v1.png`

Closed:

```
A leather Gladstone doctor's bag with a combination clasp, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: clasp open, bottles and bandages inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**cellar_door** — `vane_cottage_cellar_door_closed_v1.png`, `vane_cottage_cellar_door_open_v1.png`

Closed:

```
A heavy plank cellar door with a padlock and hasp, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: padlock gone, door open onto dark stone steps going down. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, well kept but aged. Soft amber lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

## House Three: Hollowmere Sanatorium

### Gate Lodge

#### Objects (17)

**Admission Card** — `admission_card_v1.png`

```
Admission Card. A scorched admission card, pulled from the coal. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Brass Ward Tag** — `brass_ward_tag_v1.png`

```
Brass Ward Tag. A round brass tag stamped with a 7. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Duty Roster** — `duty_roster_v1.png`

```
Duty Roster. The lodge roster, a grid of names and nights. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Enamel Mug** — `enamel_mug_v1.png`

```
Enamel Mug. A chipped white mug of cold, stewed tea. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Hurricane Lamp** — `hurricane_lamp_v1.png`

```
Hurricane Lamp. A paraffin lamp with a wire handle, the glass still warm. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Night Round Card** — `night_round_card_v1.png`

```
Night Round Card. A printed card of the porter's nightly round. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Porter's Cap** — `porters_cap_v1.png`

```
Porter's Cap. A peaked cap with a brass badge: 'HOLLOWMERE'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Note Under the Door** — `pushed_note_v1.png`

```
Note Under the Door. A scrap of paper pushed under the inner door. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Smelling Salts** — `smelling_salts_v1.png`

```
Smelling Salts. A small green bottle with a glass stopper. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Snuff Box** — `snuff_box_v1.png`

```
Snuff Box. A dented pewter snuff box with a hinged lid. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Toy Soldier** — `toy_soldier_v1.png`

```
Toy Soldier. A painted lead soldier in a parcel that was never delivered. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Trunk Key** — `trunk_key_v1.png`

```
Trunk Key. A small flat key on a loop of red tape. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Unposted Letters** — `unposted_letters_v1.png`

```
Unposted Letters. A bundle of patients' letters tied with string, never sent. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Visitors' Book** — `visitors_book_v1.png`

```
Visitors' Book. A heavy bound book of signatures. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Visitor's Pass** — `visitors_pass_v1.png`

```
Visitor's Pass. A pink card pass: 'ADMIT ONE - R. VANE - ALL WARDS'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wage Packet** — `wage_packet_v1.png`

```
Wage Packet. A brown wage envelope, far too thick. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ward Door Key** — `ward_door_key_v1.png`

```
Ward Door Key. A long steel key with a numbered fob. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (9)

**desk_drawer** — `gate_lodge_desk_drawer_closed_v1.png`, `gate_lodge_desk_drawer_open_v1.png`

Closed:

```
A single wooden desk drawer front with a small brass pull, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer pulled out towards the viewer, dark inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**coal_scuttle** — `gate_lodge_coal_scuttle_closed_v1.png`, `gate_lodge_coal_scuttle_open_v1.png`

Closed:

```
A black iron coal scuttle heaped with coal. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: tipped over, coal spilled out, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**coat_locker** — `gate_lodge_coat_locker_closed_v1.png`, `gate_lodge_coat_locker_open_v1.png`

Closed:

```
A tall narrow green metal staff locker with two doors, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: both doors swung open, a wet greatcoat hanging inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**mail_sack** — `gate_lodge_mail_sack_closed_v1.png`, `gate_lodge_mail_sack_open_v1.png`

Closed:

```
A canvas mail sack, full and tied at the neck. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: neck untied and folded back, dark inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**first_aid_tin** — `gate_lodge_first_aid_tin_closed_v1.png`, `gate_lodge_first_aid_tin_open_v1.png`

Closed:

```
A cream enamel first aid tin with a hinged lid, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, lint and brown bottles inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**key_cabinet** — `gate_lodge_key_cabinet_closed_v1.png`, `gate_lodge_key_cabinet_open_v1.png`

Closed:

```
A wall-mounted wooden key cabinet with a four-number combination lock, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: doors open, rows of numbered brass hooks inside, nearly all empty. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**lost_property_trunk** — `gate_lodge_lost_property_trunk_closed_v1.png`, `gate_lodge_lost_property_trunk_open_v1.png`

Closed:

```
A battered travelling trunk with a small brass lock, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid tipped back, umbrellas and a single glove inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**strongbox** — `gate_lodge_strongbox_closed_v1.png`, `gate_lodge_strongbox_open_v1.png`

Closed:

```
A small iron strongbox with a numbered dial, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door swung open, old pay slips inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**inner_door** — `gate_lodge_inner_door_closed_v1.png`, `gate_lodge_inner_door_open_v1.png`

Closed:

```
A heavy iron-bound institutional door with no handle, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open onto a long dark corridor. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### X-Ray Room

#### Objects (18)

**Appointment Book** — `appointment_book_v1.png`

```
Appointment Book. The X-ray room's diary, a week to a page. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Bent Spoon** — `bent_spoon_v1.png`

```
Bent Spoon. A spoon worn to a point, plastered into the wall. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Key in the Heel** — `boot_heel_key_v1.png`

```
Key in the Heel. A tiny key hidden in the heel of a boot. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Chest X-ray** — `chest_xray_v1.png`

```
Chest X-ray. An X-ray plate of a child's ribs in a paper sleeve. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Darkroom Tongs** — `darkroom_tongs_v1.png`

```
Darkroom Tongs. Stained wooden tongs for lifting plates out of the bath. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lead Gloves** — `lead_gloves_v1.png`

```
Lead Gloves. A pair of heavy lead-lined gloves. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Matron's Memo** — `matrons_memo_v1.png`

```
Matron's Memo. A typed memo initialled E.C. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Name Tags** — `name_tags_v1.png`

```
Name Tags. A string of patients' wrist tags. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Nurse's Watch** — `nurses_watch_v1.png`

```
Nurse's Watch. A fob watch on a pin, the kind worn upside down. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Paper Boat** — `paper_boat_v1.png`

```
Paper Boat. A little boat folded from an X-ray sleeve. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pencil Stub** — `pencil_stub_v1.png`

```
Pencil Stub. A chewed stub of pencil, hidden in plaster. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Red Safelight** — `red_safelight_v1.png`

```
Red Safelight. A darkroom lamp with a ruby glass. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Rolled Note** — `rolled_note_v1.png`

```
Rolled Note. A slip of paper rolled tight inside a hollow crutch. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Sewn-in Photograph** — `sewn_photograph_v1.png`

```
Sewn-in Photograph. A photograph stitched into a suitcase lining. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Torn Label** — `torn_label_v1.png`

```
Torn Label. A luggage label torn in half. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ward Map** — `ward_map_v1.png`

```
Ward Map. A map of the wards, drawn on a pillowcase. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ward Seven Key** — `ward_seven_key_v1.png`

```
Ward Seven Key. A black key with a white enamel 7. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**X-ray Tube** — `xray_tube_v1.png`

```
X-ray Tube. A spare glass X-ray tube in a padded cradle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (10)

**film_cabinet** — `xray_room_film_cabinet_closed_v1.png`, `xray_room_film_cabinet_open_v1.png`

Closed:

```
A low grey steel film cabinet with two doors, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: doors open, rows of X-ray plates in paper sleeves inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**developer_tank** — `xray_room_developer_tank_closed_v1.png`, `xray_room_developer_tank_open_v1.png`

Closed:

```
A grey steel darkroom developer tank with a flat lid, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid lifted, dark liquid inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**laundry_hamper** — `xray_room_laundry_hamper_closed_v1.png`, `xray_room_laundry_hamper_open_v1.png`

Closed:

```
A wicker laundry hamper with a lid, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, grey smocks inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**desk_drawer** — `xray_room_desk_drawer_closed_v1.png`, `xray_room_desk_drawer_open_v1.png`

Closed:

```
A single wooden desk drawer front with a small brass pull, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: drawer pulled out towards the viewer, dark inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**waste_bin** — `xray_room_waste_bin_closed_v1.png`, `xray_room_waste_bin_open_v1.png`

Closed:

```
A wire mesh waste bin full of crumpled paper. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: tipped out, empty inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**light_box** — `xray_room_light_box_closed_v1.png`, `xray_room_light_box_open_v1.png`

Closed:

```
A wall-mounted X-ray viewing light box with a milky glass front, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: glass front hinged down, empty inside where the bulbs should be. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**instrument_case** — `xray_room_instrument_case_closed_v1.png`, `xray_room_instrument_case_open_v1.png`

Closed:

```
A flat black leather instrument case with a tiny lock, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: lid open, papers inside instead of instruments. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**control_cabinet** — `xray_room_control_cabinet_closed_v1.png`, `xray_room_control_cabinet_open_v1.png`

Closed:

```
A grey steel X-ray control cabinet with a four-number combination lock, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: doors open, rows of dials and fuses inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**drug_safe** — `xray_room_drug_safe_closed_v1.png`, `xray_room_drug_safe_open_v1.png`

Closed:

```
A small green drug safe with a numbered dial, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door swung open, sealed envelopes inside. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**steel_door** — `xray_room_steel_door_closed_v1.png`, `xray_room_steel_door_open_v1.png`

Closed:

```
A grey riveted steel ward door with a painted number, closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: door open onto a long unlit ward. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Laundry

#### Objects (19)

**Blue Bag** — `blue_bag_v1.png`

```
Blue Bag. A little muslin bag of laundry blue. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Boiler Room Key** — `boiler_room_key_v1.png`

```
Boiler Room Key. A warm iron key on a wire hook. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Carbolic Soap** — `carbolic_soap_v1.png`

```
Carbolic Soap. A red bar of carbolic soap, worn to a sliver. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Child's Spectacles** — `childs_spectacles_v1.png`

```
Child's Spectacles. A pair of small round spectacles, one arm mended with thread. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Darning Egg** — `darning_egg_v1.png`

```
Darning Egg. A smooth wooden darning egg on a handle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Peg Doll** — `dolly_peg_v1.png`

```
Peg Doll. A clothes peg with a face inked on and a scrap of smock for a dress. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Flat Iron** — `flat_iron_v1.png`

```
Flat Iron. A heavy black flat iron, still faintly warm. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Marked Pillowcase** — `initialled_pillowcase_v1.png`

```
Marked Pillowcase. A pillowcase with initials picked out in red thread. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Laundry Scissors** — `laundry_scissors_v1.png`

```
Laundry Scissors. Long, black-handled scissors on a loop of tape. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Laundry Ticket** — `laundry_ticket_v1.png`

```
Laundry Ticket. A numbered pink ticket pinned to the board. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Linen Tally** — `linen_tally_v1.png`

```
Linen Tally. A tally book of sheets, ward by ward. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Locker Key** — `locker_key_v1.png`

```
Locker Key. A small steel key on a safety pin. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Note from the Mangle** — `mangle_note_v1.png`

```
Note from the Mangle. A slip of paper pressed as thin as a leaf. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Nell's Diary** — `nells_diary_v1.png`

```
Nell's Diary. A cheap pocket diary with a pencil in the spine. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pressed Letter** — `pressed_letter_v1.png`

```
Pressed Letter. A letter ironed dry and flat. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Scorched Page** — `scorched_page_v1.png`

```
Scorched Page. A page of a register, brown at the edges. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Numbered Smock** — `smock_seven_v1.png`

```
Numbered Smock. A small grey smock with a 7 stitched on the collar. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ward Seven Chit** — `ward_seven_chit_v1.png`

```
Ward Seven Chit. A signed chit on stiff blue paper. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Washboard** — `washboard_v1.png`

```
Washboard. A ribbed zinc washboard in a wooden frame. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (10)

**linen_press** — `laundry_linen_press_closed_v1.png`, `laundry_linen_press_open_v1.png`

Closed:

```
A linen press in an old sanatorium (cupboard or door, about 96 wide by 150 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**wash_copper** — `laundry_wash_copper_closed_v1.png`, `laundry_wash_copper_open_v1.png`

Closed:

```
A wash copper in an old sanatorium (box with a lid, about 90 wide by 70 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**sorting_basket** — `laundry_sorting_basket_closed_v1.png`, `laundry_sorting_basket_open_v1.png`

Closed:

```
A sorting basket in an old sanatorium (basket or tub, about 84 wide by 62 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**mangle_drawer** — `laundry_mangle_drawer_closed_v1.png`, `laundry_mangle_drawer_open_v1.png`

Closed:

```
A mangle drawer in an old sanatorium (drawer front, about 70 wide by 22 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**ironing_drawer** — `laundry_ironing_drawer_closed_v1.png`, `laundry_ironing_drawer_open_v1.png`

Closed:

```
A ironing drawer in an old sanatorium (drawer front, about 80 wide by 24 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**soap_crate** — `laundry_soap_crate_closed_v1.png`, `laundry_soap_crate_open_v1.png`

Closed:

```
A soap crate in an old sanatorium (box with a lid, about 80 wide by 46 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**nells_locker** — `laundry_nells_locker_closed_v1.png`, `laundry_nells_locker_open_v1.png`

Closed:

```
A nells locker in an old sanatorium (cupboard or door, about 64 wide by 150 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**cash_tin** — `laundry_cash_tin_closed_v1.png`, `laundry_cash_tin_open_v1.png`

Closed:

```
A cash tin in an old sanatorium (box with a lid, about 56 wide by 34 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**drying_cabinet** — `laundry_drying_cabinet_closed_v1.png`, `laundry_drying_cabinet_open_v1.png`

Closed:

```
A drying cabinet in an old sanatorium (cupboard or door, about 84 wide by 160 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**boiler_room_door** — `laundry_boiler_room_door_closed_v1.png`, `laundry_boiler_room_door_open_v1.png`

Closed:

```
A boiler room door in an old sanatorium (cupboard or door, about 100 wide by 210 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Boiler Room

#### Objects (20)

**Billy Can** — `billy_can_v1.png`

```
Billy Can. A dented tin tea can with a wire handle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Buried Satchel** — `buried_satchel_v1.png`

```
Buried Satchel. A child's school satchel, black with coal. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Burn Order** — `burn_order_v1.png`

```
Burn Order. A sheet of headed paper, scorched at one corner. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Clinker Rake** — `clinker_rake_v1.png`

```
Clinker Rake. A long iron rake for dragging ash out of the fire. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Coal Shovel** — `coal_shovel_v1.png`

```
Coal Shovel. A stoker's shovel, the blade worn bright. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Cracked Gauge** — `cracked_gauge_v1.png`

```
Cracked Gauge. A brass pressure gauge with a cracked glass. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Dose Cup** — `dose_cup_v1.png`

```
Dose Cup. A small glass medicine cup, sticky at the bottom. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Half-burnt Ledger** — `half_burnt_ledger_v1.png`

```
Half-burnt Ledger. A ledger pulled from the ash, half its pages gone. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lift Crank** — `lift_crank_v1.png`

```
Lift Crank. A cranked iron handle with a wooden grip. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Lift Key** — `lift_key_v1.png`

```
Lift Key. A flat key stamped 'SERVICE LIFT'. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Maker's Plate** — `makers_plate_v1.png`

```
Maker's Plate. A brass plate riveted to the boiler. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Boiler Log** — `night_log_v1.png`

```
Boiler Log. The boiler's night log, a page to a night. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Oily Rag** — `oil_rag_v1.png`

```
Oily Rag. A rag stiff with oil and soot. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pencilled Plan** — `pencilled_plan_v1.png`

```
Pencilled Plan. A sketch of the pipe runs on a greasy sheet. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Scorched Buckle** — `scorched_buckle_v1.png`

```
Scorched Buckle. The brass buckle of a small shoe. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Spanner** — `spanner_v1.png`

```
Spanner. A long adjustable spanner. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Stoker's Cap** — `stokers_cap_v1.png`

```
Stoker's Cap. A greasy flat cap, black with coal dust. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pay Slip** — `stokers_pay_slip_v1.png`

```
Pay Slip. A pay slip with a second sum written under the first. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Tin Whistle** — `tin_whistle_v1.png`

```
Tin Whistle. A penny whistle, pushed into a pipe duct. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Unburnt File** — `unburnt_file_v1.png`

```
Unburnt File. A buff file that fell behind the grate. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (11)

**coal_bunker** — `boiler_room_coal_bunker_closed_v1.png`, `boiler_room_coal_bunker_open_v1.png`

Closed:

```
A coal bunker in an old sanatorium (box with a lid, about 110 wide by 80 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**ash_pan** — `boiler_room_ash_pan_closed_v1.png`, `boiler_room_ash_pan_open_v1.png`

Closed:

```
A ash pan in an old sanatorium (drawer front, about 90 wide by 22 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**stokers_locker** — `boiler_room_stokers_locker_closed_v1.png`, `boiler_room_stokers_locker_open_v1.png`

Closed:

```
A stokers locker in an old sanatorium (cupboard or door, about 66 wide by 150 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**tool_box** — `boiler_room_tool_box_closed_v1.png`, `boiler_room_tool_box_open_v1.png`

Closed:

```
A tool box in an old sanatorium (box with a lid, about 84 wide by 44 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**fire_door** — `boiler_room_fire_door_closed_v1.png`, `boiler_room_fire_door_open_v1.png`

Closed:

```
A fire door in an old sanatorium (cupboard or door, about 84 wide by 70 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**bench_drawer** — `boiler_room_bench_drawer_closed_v1.png`, `boiler_room_bench_drawer_open_v1.png`

Closed:

```
A bench drawer in an old sanatorium (drawer front, about 80 wide by 24 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**gauge_case** — `boiler_room_gauge_case_closed_v1.png`, `boiler_room_gauge_case_open_v1.png`

Closed:

```
A gauge case in an old sanatorium (box with a lid, about 70 wide by 50 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**lunch_tin** — `boiler_room_lunch_tin_closed_v1.png`, `boiler_room_lunch_tin_open_v1.png`

Closed:

```
A lunch tin in an old sanatorium (box with a lid, about 56 wide by 34 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**pipe_hatch** — `boiler_room_pipe_hatch_closed_v1.png`, `boiler_room_pipe_hatch_open_v1.png`

Closed:

```
A pipe hatch in an old sanatorium (cupboard or door, about 60 wide by 56 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**meter_box** — `boiler_room_meter_box_closed_v1.png`, `boiler_room_meter_box_open_v1.png`

Closed:

```
A meter box in an old sanatorium (iron safe, about 62 wide by 60 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**service_lift** — `boiler_room_service_lift_closed_v1.png`, `boiler_room_service_lift_open_v1.png`

Closed:

```
A service lift in an old sanatorium (cupboard or door, about 96 wide by 150 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Dispensary

#### Objects (21)

**Apothecary Scales** — `apothecary_scales_v1.png`

```
Apothecary Scales. A brass hand balance with two small pans. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Blank Certificates** — `blank_death_forms_v1.png`

```
Blank Certificates. A pad of death certificates, already signed. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Blue Poison Bottle** — `blue_bottle_v1.png`

```
Blue Poison Bottle. A ribbed cobalt-blue bottle, the kind made for poisons. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Brass Weight** — `brass_weight_v1.png`

```
Brass Weight. A small brass scale weight with a knob on top. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Bureau Key** — `bureau_key_v1.png`

```
Bureau Key. A small brass key, slimy to the touch. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Chloral Bottle** — `chloral_bottle_v1.png`

```
Chloral Bottle. A brown stoppered bottle marked with a skull. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Telegram** — `crane_telegram_v1.png`

```
Telegram. A telegram form, opened and read. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Dose Book** — `dose_book_v1.png`

```
Dose Book. A narrow book ruled in columns. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Roll of Labels** — `label_roll_v1.png`

```
Roll of Labels. A roll of gummed labels, printed with numbers only. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Matron's Office Key** — `matrons_office_key_v1.png`

```
Matron's Office Key. A long key on a black ribbon. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Measuring Glass** — `measuring_glass_v1.png`

```
Measuring Glass. A conical glass measure with a pouring lip. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Medicine Spoon** — `medicine_spoon_v1.png`

```
Medicine Spoon. A silver spoon with a deep covered bowl, for dosing the unwilling. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ointment Jar** — `ointment_jar_v1.png`

```
Ointment Jar. A white pot of ointment with a paper label. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pestle** — `pestle_v1.png`

```
Pestle. A heavy white stone pestle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Pill Box** — `pill_box_v1.png`

```
Pill Box. A round card pill box with a red lid. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Prescription Spike** — `prescription_spike_v1.png`

```
Prescription Spike. A steel spike on a base, stacked with paper slips. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Resignation Draft** — `resignation_draft_v1.png`

```
Resignation Draft. A letter begun three times and never finished. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Sealed Ampoules** — `sealed_ampoules_v1.png`

```
Sealed Ampoules. A card of glass ampoules, one missing. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Standing Orders** — `standing_orders_v1.png`

```
Standing Orders. Two closely written pages in Vane's hand. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Sugar Pills** — `sugar_pills_v1.png`

```
Sugar Pills. A tray of plain white pills, freshly rolled. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ward Chart** — `ward_chart_v1.png`

```
Ward Chart. A folded chart of seven beds. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (11)

**poison_cupboard** — `dispensary_poison_cupboard_closed_v1.png`, `dispensary_poison_cupboard_open_v1.png`

Closed:

```
A poison cupboard in an old sanatorium (cupboard or door, about 84 wide by 100 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**powder_drawer** — `dispensary_powder_drawer_closed_v1.png`, `dispensary_powder_drawer_open_v1.png`

Closed:

```
A powder drawer in an old sanatorium (drawer front, about 80 wide by 24 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**label_drawer** — `dispensary_label_drawer_closed_v1.png`, `dispensary_label_drawer_open_v1.png`

Closed:

```
A label drawer in an old sanatorium (drawer front, about 80 wide by 24 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**ice_chest** — `dispensary_ice_chest_closed_v1.png`, `dispensary_ice_chest_open_v1.png`

Closed:

```
A ice chest in an old sanatorium (box with a lid, about 86 wide by 50 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**bureau** — `dispensary_bureau_closed_v1.png`, `dispensary_bureau_open_v1.png`

Closed:

```
A bureau in an old sanatorium (drawer front, about 90 wide by 30 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**leech_jar** — `dispensary_leech_jar_closed_v1.png`, `dispensary_leech_jar_open_v1.png`

Closed:

```
A leech jar in an old sanatorium (basket or tub, about 46 wide by 60 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**pill_machine** — `dispensary_pill_machine_closed_v1.png`, `dispensary_pill_machine_open_v1.png`

Closed:

```
A pill machine in an old sanatorium (box with a lid, about 80 wide by 40 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**white_coat** — `dispensary_white_coat_closed_v1.png`, `dispensary_white_coat_open_v1.png`

Closed:

```
A white coat in an old sanatorium (cupboard or door, about 60 wide by 150 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**scales_case** — `dispensary_scales_case_closed_v1.png`, `dispensary_scales_case_open_v1.png`

Closed:

```
A scales case in an old sanatorium (box with a lid, about 70 wide by 36 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**controlled_safe** — `dispensary_controlled_safe_closed_v1.png`, `dispensary_controlled_safe_open_v1.png`

Closed:

```
A controlled safe in an old sanatorium (iron safe, about 64 wide by 60 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**office_door** — `dispensary_office_door_closed_v1.png`, `dispensary_office_door_open_v1.png`

Closed:

```
A office door in an old sanatorium (cupboard or door, about 100 wide by 210 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Matron's Office

#### Objects (22)

**Bank Book** — `bank_book_v1.png`

```
Bank Book. A savings bank book in a cloth cover. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Desk Bell** — `brass_desk_bell_v1.png`

```
Desk Bell. A brass bell you strike with your palm. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Caddy Key** — `caddy_key_v1.png`

```
Caddy Key. A tiny silver key on top of the wardrobe. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Charred Photographs** — `charred_photographs_v1.png`

```
Charred Photographs. A handful of small photographs, burnt at the edges. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Old Photograph** — `crane_photograph_v1.png`

```
Old Photograph. A studio photograph of a boy and a girl. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Eight Tickets** — `eight_tickets_v1.png`

```
Eight Tickets. Eight railway tickets, torn in two and thrown away. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Hat Pin** — `hat_pin_v1.png`

```
Hat Pin. A long steel hat pin with a jet head. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Master Key** — `master_key_v1.png`

```
Master Key. A heavy key with a ring of seven notches. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Muddy Galoshes** — `muddy_galoshes_v1.png`

```
Muddy Galoshes. A pair of rubber overshoes, wet with mud. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Reel of Name Tapes** — `name_tape_reel_v1.png`

```
Reel of Name Tapes. A reel of woven tapes for marking clothes. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Night Count Slate** — `night_count_slate_v1.png`

```
Night Count Slate. A school slate with chalked tallies. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Packed Valise** — `packed_valise_v1.png`

```
Packed Valise. A leather valise, strapped and labelled. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Payment Ledger** — `payment_ledger_v1.png`

```
Payment Ledger. A slim private ledger bound in green. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Key on the Picture Rail** — `picture_rail_key_v1.png`

```
Key on the Picture Rail. A small key lying along the top of the picture rail. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ringed Calendar** — `ringed_calendar_v1.png`

```
Ringed Calendar. A wall calendar with tonight's date ringed twice. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Seven Certificates** — `seven_death_certs_v1.png`

```
Seven Certificates. Seven death certificates held with a pin. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Silver Inkstand** — `silver_inkstand_v1.png`

```
Silver Inkstand. A silver inkstand with two cut-glass wells. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Sleeping Draught** — `sleeping_draught_v1.png`

```
Sleeping Draught. A corked medicine bottle, freshly made up. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Telephone Receiver** — `telephone_receiver_v1.png`

```
Telephone Receiver. A black receiver, left off its hook. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Travelling Cloak** — `travelling_cloak_v1.png`

```
Travelling Cloak. A grey nurse's cloak with a red lining, on the door peg. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**True Register** — `true_register_v1.png`

```
True Register. A black register with a lock strap. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Family Ring** — `vane_family_ring_v1.png`

```
Family Ring. A gold signet ring with a worn crest. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (12)

**desk_drawer_left** — `matrons_office_desk_drawer_left_closed_v1.png`, `matrons_office_desk_drawer_left_open_v1.png`

Closed:

```
A desk drawer left in an old sanatorium (drawer front, about 76 wide by 24 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**desk_drawer_right** — `matrons_office_desk_drawer_right_closed_v1.png`, `matrons_office_desk_drawer_right_open_v1.png`

Closed:

```
A desk drawer right in an old sanatorium (drawer front, about 76 wide by 24 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**filing_cabinet** — `matrons_office_filing_cabinet_closed_v1.png`, `matrons_office_filing_cabinet_open_v1.png`

Closed:

```
A filing cabinet in an old sanatorium (cupboard or door, about 72 wide by 150 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**waste_basket** — `matrons_office_waste_basket_closed_v1.png`, `matrons_office_waste_basket_open_v1.png`

Closed:

```
A waste basket in an old sanatorium (basket or tub, about 50 wide by 56 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**carpet_bag** — `matrons_office_carpet_bag_closed_v1.png`, `matrons_office_carpet_bag_open_v1.png`

Closed:

```
A carpet bag in an old sanatorium (box with a lid, about 80 wide by 50 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**tea_caddy** — `matrons_office_tea_caddy_closed_v1.png`, `matrons_office_tea_caddy_open_v1.png`

Closed:

```
A tea caddy in an old sanatorium (box with a lid, about 56 wide by 38 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**wall_safe** — `matrons_office_wall_safe_closed_v1.png`, `matrons_office_wall_safe_open_v1.png`

Closed:

```
A wall safe in an old sanatorium (iron safe, about 66 wide by 62 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**bible_box** — `matrons_office_bible_box_closed_v1.png`, `matrons_office_bible_box_open_v1.png`

Closed:

```
A bible box in an old sanatorium (box with a lid, about 70 wide by 40 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**sewing_drawer** — `matrons_office_sewing_drawer_closed_v1.png`, `matrons_office_sewing_drawer_open_v1.png`

Closed:

```
A sewing drawer in an old sanatorium (drawer front, about 70 wide by 22 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**fire_grate** — `matrons_office_fire_grate_closed_v1.png`, `matrons_office_fire_grate_open_v1.png`

Closed:

```
A fire grate in an old sanatorium (basket or tub, about 84 wide by 50 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**jewel_case** — `matrons_office_jewel_case_closed_v1.png`, `matrons_office_jewel_case_open_v1.png`

Closed:

```
A jewel case in an old sanatorium (jewel case, about 60 wide by 40 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**ward_stair_door** — `matrons_office_ward_stair_door_closed_v1.png`, `matrons_office_ward_stair_door_open_v1.png`

Closed:

```
A ward stair door in an old sanatorium (cupboard or door, about 100 wide by 210 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

### Ward Seven

#### Objects (23)

**Fire Bell Handle** — `alarm_handle_v1.png`

```
Fire Bell Handle. The brass pull of the sanatorium fire bell. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Bed Chart** — `bed_chart_v1.png`

```
Bed Chart. A clipboard chart from the foot of a bed. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Spoon Key** — `bed_frame_key_v1.png`

```
Spoon Key. A key filed out of a spoon handle. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Cloth Rabbit** — `cloth_rabbit_v1.png`

```
Cloth Rabbit. A rabbit sewn from a grey smock, with button eyes. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Dose Tray** — `dose_tray_v1.png`

```
Dose Tray. A tin tray of seven small cups, numbered. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Fire Bell Key** — `fire_bell_key_v1.png`

```
Fire Bell Key. A red-painted key on a loop of string. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Fire Bucket** — `fire_bucket_v1.png`

```
Fire Bucket. A red bucket of sand on a hook. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Hair Slide** — `hair_slide_v1.png`

```
Hair Slide. A tortoiseshell hair slide. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Harmonica** — `harmonica_v1.png`

```
Harmonica. A small dented mouth organ. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Hidden File** — `hidden_file_v1.png`

```
Hidden File. A thin steel file, wrapped in rag. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Locker Token** — `ivys_token_v1.png`

```
Locker Token. A numbered brass token on a bootlace. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Night Lamp** — `night_lamp_v1.png`

```
Night Lamp. A shaded oil lamp, turned very low. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Prayer Book** — `prayer_book_v1.png`

```
Prayer Book. A small black prayer book with a ribbon. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Reading Glasses** — `reading_glasses_v1.png`

```
Reading Glasses. Wire-framed reading glasses in a worn case. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Restraint Strap** — `restraint_strap_v1.png`

```
Restraint Strap. A buckled leather strap, lined with felt. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ruth's Sampler** — `ruths_sampler_v1.png`

```
Ruth's Sampler. A square of sheet stitched with seven names in red thread. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Scratched Calendar** — `scratched_calendar_v1.png`

```
Scratched Calendar. A piece of slate scratched with rows of marks. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Seven Envelopes** — `seven_envelopes_v1.png`

```
Seven Envelopes. Seven sealed envelopes tied with tape. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Palmed Key** — `strongbox_key_v1.png`

```
Palmed Key. A flat steel key, warm from being held. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Thimble Case** — `thimble_case_v1.png`

```
Thimble Case. A little bone case holding a silver thimble. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Ward Slippers** — `ward_slippers_v1.png`

```
Ward Slippers. A pair of felt slippers, worn through. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Window Bar** — `window_bar_v1.png`

```
Window Bar. An iron bar, filed nearly through at one end. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**Wooden Yo-yo** — `wooden_yoyo_v1.png`

```
Wooden Yo-yo. A red wooden yo-yo with a knotted string. Hand-painted gothic realism, collectible prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

#### Containers (12)

**tobys_locker** — `ward_seven_tobys_locker_closed_v1.png`, `ward_seven_tobys_locker_open_v1.png`

Closed:

```
A tobys locker in an old sanatorium (cupboard or door, about 56 wide by 70 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**ruths_locker** — `ward_seven_ruths_locker_closed_v1.png`, `ward_seven_ruths_locker_open_v1.png`

Closed:

```
A ruths locker in an old sanatorium (cupboard or door, about 56 wide by 70 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**alberts_locker** — `ward_seven_alberts_locker_closed_v1.png`, `ward_seven_alberts_locker_open_v1.png`

Closed:

```
A alberts locker in an old sanatorium (cupboard or door, about 56 wide by 70 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**linen_chest** — `ward_seven_linen_chest_closed_v1.png`, `ward_seven_linen_chest_open_v1.png`

Closed:

```
A linen chest in an old sanatorium (trunk, about 120 wide by 70 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**nurses_desk_drawer** — `ward_seven_nurses_desk_drawer_closed_v1.png`, `ward_seven_nurses_desk_drawer_open_v1.png`

Closed:

```
A nurses desk drawer in an old sanatorium (drawer front, about 80 wide by 24 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**medicine_trolley** — `ward_seven_medicine_trolley_closed_v1.png`, `ward_seven_medicine_trolley_open_v1.png`

Closed:

```
A medicine trolley in an old sanatorium (cupboard or door, about 80 wide by 90 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**nurses_locker** — `ward_seven_nurses_locker_closed_v1.png`, `ward_seven_nurses_locker_open_v1.png`

Closed:

```
A nurses locker in an old sanatorium (cupboard or door, about 64 wide by 150 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**confiscation_box** — `ward_seven_confiscation_box_closed_v1.png`, `ward_seven_confiscation_box_open_v1.png`

Closed:

```
A confiscation box in an old sanatorium (box with a lid, about 70 wide by 40 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**barred_shutter** — `ward_seven_barred_shutter_closed_v1.png`, `ward_seven_barred_shutter_open_v1.png`

Closed:

```
A barred shutter in an old sanatorium (cupboard or door, about 90 wide by 120 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**restraint_cupboard** — `ward_seven_restraint_cupboard_closed_v1.png`, `ward_seven_restraint_cupboard_open_v1.png`

Closed:

```
A restraint cupboard in an old sanatorium (cupboard or door, about 70 wide by 100 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**ward_strongbox** — `ward_seven_ward_strongbox_closed_v1.png`, `ward_seven_ward_strongbox_open_v1.png`

Closed:

```
A ward strongbox in an old sanatorium (iron safe, about 66 wide by 60 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

**fire_bell_box** — `ward_seven_fire_bell_box_closed_v1.png`, `ward_seven_fire_bell_box_open_v1.png`

Closed:

```
A fire bell box in an old sanatorium (box with a lid, about 60 wide by 70 tall), closed. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```

Open (attach the closed image):

```
The same object as the attached image, same camera angle, same size and framing, now changed: open, with a dark empty space inside where something small could lie. Hand-painted gothic realism, container prop for a 2D hidden-object mystery game. Single object, centered, whole object in frame, clear readable silhouette, institutional and worn with age. Cold lamp light from the upper left, subtle soft shadow beneath. Transparent background (or a plain flat light-grey background if transparency is unavailable). Any writing is small, faded and illegible. No readable text, no labels, no watermark, no hands, no other objects.
```
