# Ashworth Manor Chapter 2 Asset Manifest

This folder is deliberately standalone: no `.tscn`, `.tres`, script, or UI
theme was changed.

## Finished background plates

| File | Use | Native plate |
| --- | --- | --- |
| `backgrounds/basement_room_v1.png` | flooded manor basement | 1672×941 |
| `backgrounds/sunken_boat_room_v1.png` | wrecked launch cabin | 1672×941 |
| `backgrounds/ice_house_room_v1.png` | abandoned ice house | 1672×941 |

The plates are source-quality composition proofs created for the 16:9 game
view. Before shipping, re-render/export each at **2560×1440 minimum** rather
than upscaling; this workspace has no raster upscaler installed. Their
generated compositions intentionally reserve readable, empty placement zones
and omit required objects and clue lettering.

## Deliverable conventions for the remaining pack

| Folder | Required files | Technical requirement |
| --- | --- | --- |
| `backgrounds/` | lighthouse, chapel, boat shed, manor rooms | 2560×1440+ PNG/WebP |
| `foregrounds/` | ropes, beams, icicles, pew edges, foliage | alpha PNG/WebP, parallax-safe |
| `objects/` | one room sprite + one list icon per HiddenObjectData resource | alpha PNG/WebP, 2–4× display size, 4–8 px padding |
| `clues/` | one close-up per legible document/mark | no vital text under mobile-readable scale |
| `ui/` | parchment/iron panels, four button states, map/hint/journal icons | alpha PNG/WebP; 44 px min touch target |

## Object-sprite brief

All replacement collectibles share: painted material texture, a restrained
ground/contact shadow, one dominant silhouette, directional light matching
their room, transparent surround, and no lettering unless that lettering is
the clue itself. For documents, create a separate inspection asset rather than
asking the room sprite to hold readable puzzle text.
