# Hand-finishing steps for sprites

`tools/cut_sprites.py` cuts almost every sprite straight from its sheet. A few need one more
step. Run these from the project folder, after `cut_sprites.py`, whenever you re-cut or move
the sprites they name. Then re-import in Godot.

| Script | Run it when | What it does |
|---|---|---|
| `xray_room_cut_touching.py` | after re-cutting the X-Ray Room | Cuts `ward_map`, `sewn_photograph`, `name_tags` and `matrons_memo`, which touch a neighbour on their sheet and are not in the cut list. |
| `boiler_room_finish.py` | once, straight after re-cutting `clinker_rake` or `boiler_room_service_lift` | Leans the rake upright and stretches the lift to fit the tall painted doorway. Running it twice on the same files does it twice. |
| `laundry_bake_behind.py` | after re-cutting or MOVING the linen press, drying cabinet, Nell's locker or boiler room door | Erases the shape of the painted mangle and ironing table from those sprites, so they stand behind them. Reads their place from `scenes/laundry.tscn`. |
| `dispensary_make_fix_sheet.py` | before re-cutting the Dispensary, if the closed container sheet changes | Rebuilds `dispensary_containers_closed_fix_sheet_v1.png` (grey metal tops tinted so they are not taken for background). |
| `matrons_office_make_fix_sheets.py` | before re-cutting the Matron's Office, if its sheets change | Rebuilds the two `matrons_office_*_fix_sheet_v1.png` sheets (crowded pictures re-tiled with wide gaps). |
| `matrons_office_mask_door.py` | after re-cutting or MOVING the ward stair door | Cuts the painted telephone's outline out of the closed door, so the telephone stays in front of it. |

## House One and House Two

Their sheets have a magenta background and many pictures stand very close together. Run a
room's scripts in the order listed, around `cut_sprites.py tools/sprite_cuts/<room>.json`.

| Script | Run it | What it does |
|---|---|---|
| `attic_spectacles_glass.py` | after cutting | Makes the cracked spectacles' lenses clear glass. |
| `staircase_finish.py` | after cutting | Clears the glass of the open clock door; removes the banister post painted behind the hair ribbon. |
| `living_room_cut_touching.py` | after cutting | Cuts `spare_keys` (not in the cut list). |
| `study_make_fix_sheet.py` | before cutting, if the containers sheet changes | Rebuilds `study_containers_fix_sheet_v1.png` (pictures moved apart). |
| `study_finish.py` | after cutting | Clears the magnifying glass lens; lays the forged signatures and calendar page flat. |
| `jetty_cut_touching.py` | after cutting | Cuts `registration`, `prescription`, the bait bucket and the tackle box (not in the cut list). |
| `jetty_float_in_water.py` | after cutting | Makes the three drifting clues sit in the water. |
| `boat_shed_make_fix_sheets.py` | before cutting, if a sheet changes | Rebuilds the two `boat_shed_*_fix_sheet_v1.png` sheets. |
| `boat_shed_clean_net.py` | after cutting | Takes the pink fringe out of the open net basket. |
| `workshop_cut_touching.py` | after cutting | Cuts the boat model, hull plan, job book, bung, log basket and cash box (not in the cut list). |
| `workshop_crate_slats.py` | after the script above | Darkens the gaps between the bung crate's slats. |
| `house_two_refit_drawers.py` | after cutting the Boat Shed or Workshop drawers | Writes the `_v2` workbench and bench drawer sprites: recoloured to the table wood, set into the table, and opening without the sides showing above the table top. |
| `sunken_boat_finish.py` | after cutting | Cuts the skipper locker, galley cupboard and ditty box; builds the cabin door. |
| `ice_house_cut_touching.py` | after cutting | Cuts the horse blanket and the snowshoe (not in the cut list). |
| `ice_house_clean_ice.py` | after cutting | Takes lavender specks out of the ice. |
| `ice_house_stand_pick.py` | after cutting | Turns the ice pick upright. |
| `lighthouse_steps_cut_touching.py` | after cutting | Cuts four objects and five containers (not in the cut list); cleans the bandage roll. |
| `lamp_room_make_fix_sheets.py` | before cutting, if a sheet changes | Rebuilds the two `lamp_room_*_fix_sheet_v1.png` sheets (pictures moved apart, pink removed). |
| `lamp_room_window_mask.py` | if the Lamp Room BACKGROUND changes | Rebuilds `assets/backgrounds/lamp_room_window_mask_v1.png`: where the painting is sky and sea, so the lightning only shows through the glass. |
| `vane_cottage_finish.py` | instead of cutting by hand | Runs the cutter and `vane_cottage_cut_touching.py`, then finishes the sprites (pink, flat-lying objects, cupboard, fake spines, cellar door). |

Kitchen, Washroom, Loft and Island Chapel need no extra step.
