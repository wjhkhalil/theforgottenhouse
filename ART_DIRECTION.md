# The Forgotten House — Production Art Direction

## Visual target

Hand-painted gothic realism for a 2D hidden-object mystery. Rooms are painted
as believable, readable spaces rather than dark photographs: the player must
be able to distinguish an item silhouette at maximum zoom and on a phone.

## Lighting language

* Moonlit exterior rooms use desaturated navy and blue-grey shadows, with
  restrained tarnished-brass accents.
* Fire, desk lamps, lanterns and candles use soft amber pools of light. Their
  warm highlights must be the strongest contrast in a dark room.
* Do not bake dynamic gameplay light, steam, frost, water, lighthouse beams,
  or darkness into a background. Those remain live Godot effects.

## Room artwork

* Target source size: 2560 x 1440 or larger, 16:9. Godot displays it at the
  1280 x 720 design resolution.
* Each room uses `assets/backgrounds/<room>_background_vN.png`. A separate
  transparent `assets/foregrounds/<room>_foreground_vN.png` is reserved for
  furniture that should occlude hidden objects.
* Keep surfaces and silhouette gaps around existing object positions readable.
  Never bake required collectible objects, story clues, UI, logos, or text into
  the room background.
* Use worn materials appropriate to the location: dust and peeling wallpaper
  in the manor, wet timber and rust at Blackwater, ice/frost at the ice house,
  salt and oxidised brass at the lighthouse.

## Object sprites and icons

* Every `HiddenObjectData` resource gets a transparent room sprite and a
  separate high-contrast inventory icon.
* Sprite source art should be 2–4x its intended on-screen size, with 4–8 px of
  transparent padding at final size. Match the room perspective, cast shadow,
  light direction and wear.
* Icons must use a clean, centered silhouette against transparency; never rely
  on tiny written labels to identify an object.

## UI and clue readability

* Use a licensed, readable serif for headings and a highly legible companion
  face for object lists. All interactive text requires high contrast.
* UI panels are aged parchment, dark wood, oxidised brass, or blackened iron;
  they must not compete with collectible objects.
* Give clue documents a full-screen or near-full-screen inspection view when
  their lettering carries puzzle information. Do not embed key text below
  comfortable phone readability.

## Asset quality checks

Before assigning an asset: inspect it at 100%, at the maximum 2.5x game zoom,
and at the phone layout. Confirm transparent sprites preserve alpha, have no
watermark/text artifacts, and do not obscure the click target.
