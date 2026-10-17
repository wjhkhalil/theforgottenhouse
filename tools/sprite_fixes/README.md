# Hand-finishing steps for sprites

`tools/cut_sprites.py` cuts almost every sprite straight from its sheet. A few need one more
step. Run these from the project folder, after `cut_sprites.py`, whenever you re-cut or move
the sprites they name. Then re-import in Godot.

| Script | Run it when | What it does |
|---|---|---|
| `xray_room_cut_touching.py` | after re-cutting the X-Ray Room | Cuts `ward_map`, `sewn_photograph`, `name_tags` and `matrons_memo`, which touch a neighbour on their sheet and are not in the cut list. |
| `xray_room_finish.py` | after re-cutting the X-Ray Room desk drawer or developer tank | Writes the steel desk drawer set into the control cabinet's plinth (`_closed_v2`, `_open_v3`), the closed developer tank with its lid holes filled (`_closed_v2`), and an open tank built from the closed one (`_open_v2`). |
| `boiler_room_finish.py` | once, straight after re-cutting `clinker_rake` or `boiler_room_service_lift` | Leans the rake upright and stretches the lift to fit the tall painted doorway. Running it twice on the same files does it twice. |
| `laundry_bake_behind.py` | after re-cutting or MOVING the linen press, drying cabinet, Nell's locker or boiler room door | Erases the shape of the painted mangle and ironing table from those sprites, so they stand behind them. Reads their place from `scenes/laundry.tscn`. |
| `laundry_copper_open.py` | after re-cutting the wash copper | Writes `laundry_wash_copper_open_v2.png` from the CLOSED copper: same pot, water in its mouth, the same full-size lid pushed aside. |
| `boiler_room_fit_drawer.py` | after re-cutting the Boiler Room bench drawer | Writes the bench drawer (`_closed_v2`, `_open_v3`) as a flat front the size of the slot painted in the workbench. Run `match_drawer_colours.py --apply` after it. |
| `dispensary_fit_drawers.py` | after re-cutting the Dispensary drawers | Writes the powder and label drawers (`_closed_v2`, `_open_v3`) as flat fronts the size of the slots painted in the counter. Run `match_drawer_colours.py --apply` after it. |
| `dispensary_white_coat.py` | after re-cutting the white coat | Writes the coat (`_closed_v2`, `_open_v2`) without its own brass hook and with a soft shadow on the wall, to hang on the painted coat rail. |
| `dispensary_door_perspective.py` | after re-cutting the office door, or if the Dispensary BACKGROUND changes | Warps the office door (`_closed_v2`, `_open_v2`) into the painted doorway's perspective, so it lines up with the frame and the MATRON - PRIVATE plate. |
| `dispensary_bureau_fit.py` | after re-cutting the bureau | Warps the bureau (`_closed_v2`, `_open_v2`) square-on into the recess painted in the counter (the v1 slant-top front looked tilted). |
| `ward_seven_fit_wall.py` | after re-cutting the Ward Seven shutter or restraint cupboard | Writes the iron shutter (`_v2`) square to fit the painted barred hatch (open: the moonlit window in the opening and the plate swung out on its hinges), the restraint cupboard (`_v2`) with a shadow on the wall, and `ward_seven_floor_shadow_v1.png` (under the fire bucket). |
| `ward_seven_nurses_locker.py` | after re-cutting the nurses' locker | Writes the locker (`_v2`) standing against the wall between beds 5 and 6, with a side and top in the painting's perspective and shadows on the wall and floor. |
| `match_drawer_colours.py` | after moving a drawer, giving it new art, or changing a background | Tints every drawer (`self_modulate`) to the painted furniture it sits in. Run without `--apply` to see the numbers, `--sheet out.png` for a before/after sheet. New drawers need a reference box in `REFERENCE`. |
| `laundry_drying_line.py` | if the Laundry BACKGROUND changes | Writes the drying line's painted sheet, peg, rail and hanger rod (`laundry_sheet_v1`, `laundry_peg_v1`, `laundry_rail_v1`, `laundry_rail_hanger_v1`), taken from the ironing-table cloth, the shelf wood and the wall pipe in the background. |
| `dispensary_make_fix_sheet.py` | before re-cutting the Dispensary, if the closed container sheet changes | Rebuilds `dispensary_containers_closed_fix_sheet_v1.png` (grey metal tops tinted so they are not taken for background). |
| `matrons_office_make_fix_sheets.py` | before re-cutting the Matron's Office, if its sheets change | Rebuilds the two `matrons_office_*_fix_sheet_v1.png` sheets (crowded pictures re-tiled with wide gaps). |
| `gate_lodge_finish.py` | after re-cutting the Gate Lodge desk drawer or inner door | Writes the desk drawer (`_closed_v2`, `_open_v3`), long and low to fill the desk's top rail and recoloured to the desk wood, and the inner door (`_open_v2`), the same size as the closed door with the leaf swung inward. |
| `gate_lodge_bell_board.py` | if `hand_bell_v1`, the Gate Lodge desk drawer v1 or the Gate Lodge background changes | Writes the bell board's painted bell, roller shutter and five number plates (`gate_lodge_bell_*_v1.png`), built from the hand bell, the desk drawer wood and the TO THE WARDS sign's enamel. |
| `matrons_office_fit_drawers.py` | after re-cutting the Matron's Office desk drawers, sewing drawer or filing cabinet | Writes the two desk drawers and the sewing drawer (`_closed_v2`, `_open_v3`) as flat fronts the size of their painted slots (the right-hand one as the desk's centre drawer), and the filing cabinet (`_v2`) standing in the wall cabinet's niche with the sewing table and pincushion cut out in front. Run `match_drawer_colours.py --apply` after it. |
| `matrons_office_mirror_reflection.py` | if the Matron's Office BACKGROUND changes, or a mirror object moves | Writes `assets/backgrounds/matrons_office_mirror_reflection_v1.png`, the painted reflection in the swing mirror (up, level and down tilts in one tall strip), cut from the room's wallpaper, picture rail, wainscot, landscape print, wood and carpet. |
| `matrons_office_mask_door.py` | after re-cutting or MOVING the ward stair door | Cuts the painted telephone's and desk lamp's outlines out of the closed and open door, so they stay in front of it. |

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
| `lighthouse_steps_medal_box_front.py` | after the script above | Writes the `_v2` medal box sprites, turned to face the player instead of seen from above. |
| `island_chapel_finish.py` | after cutting the Island Chapel | Writes the pulpit drawer (`_closed_v2`, `_open_v3`) recoloured to the pulpit wood, and the font lid (`_v2`) flattened to the eye-level font, opening as a lid only. |
| `lamp_room_make_fix_sheets.py` | before cutting, if a sheet changes | Rebuilds the two `lamp_room_*_fix_sheet_v1.png` sheets (pictures moved apart, pink removed). |
| `lamp_room_window_mask.py` | if the Lamp Room BACKGROUND changes | Rebuilds `assets/backgrounds/lamp_room_window_mask_v1.png`: where the painting is sky and sea, so the lightning only shows through the glass. |
| `vane_cottage_finish.py` | instead of cutting by hand | Runs the cutter and `vane_cottage_cut_touching.py`, then finishes the sprites (pink, flat-lying objects, cupboard, fake spines, cellar door). |

Kitchen, Washroom, Loft and Island Chapel need no extra step.
