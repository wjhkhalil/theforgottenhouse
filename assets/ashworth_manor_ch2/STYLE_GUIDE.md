# Ashworth Manor — Chapter 2 Visual Style Guide

## Visual language

**Hand-painted gothic realism**: readable painted forms, believable materials,
and controlled contrast rather than photographic darkness. A collectible must
be identifiable by silhouette on a phone before it is identifiable by detail.

| Element | Direction |
| --- | --- |
| Base shadows | blue-black `#101923`, never pure black |
| Cold light | fog blue `#8BA9B5` and ice blue `#B9D7DD` |
| Warm practicals | tarnished amber `#C78A45` |
| Age and dirt | umber `#58483A`, moss `#45564C`, salt grey `#899193` |
| Metals | oxidised brass, rusted iron, dull silver — no chrome |
| Paint treatment | medium-detail brushwork; hard readable silhouette edges; fine grit only inside larger forms |

## Layer recipe

Every room is built as: far architecture → midground furniture/surfaces →
atmosphere → occluding foreground. Keep fog, motes, light shafts, frost,
reflections, dirt, and large foreground items as independent transparent
layers wherever they need to animate, scroll, or respond to gameplay.

Background plates must not contain required hidden objects, UI, or puzzle text.
Their object-safe regions should have a value contrast of at least 35% from
the collectible silhouette. Documents that carry information require a
dedicated close-up texture at 1400 px or more on its shortest side; never use
tiny fallback-font marks baked into a room plate.

## Room notes

- **Basement:** wet limestone, pipes, dust, shallow reflection; moon-blue with
  a single weak amber practical.
- **Sunken boat:** teal caustics, suspended silt, salt corrosion and soaked
  timber; foreground ropes/timbers should scroll independently.
- **Ice house:** ice bounce, frost bloom, condensation and snow motes; retain
  warm accents only for navigational light.
- **Lighthouse:** salt spray, rotating light shaft and wet stone; brass is
  green-oxidised, not polished.
- **Chapel:** candle amber against desaturated slate and faded devotional
  colour; maintain clear pew/altar placement zones.

## UI kit specification (assets only, not wired)

Use a licensed family such as **Lora** (SIL Open Font License) for headings
and **Source Serif 4** (SIL Open Font License) for body/object lists. Object
lists are 20–24 px at the 1280×720 base resolution, semibold, high contrast,
and never all caps. Panels use parchment or blackened-iron surfaces with a
simple 2 px oxidised-brass edge. Buttons require idle, hover/focus, pressed,
disabled states plus a 44 px minimum touch height. Icons are centered painted
silhouettes with no text-dependent meaning.
