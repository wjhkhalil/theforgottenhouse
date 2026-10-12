# Hand-finishing steps for House Three sprites

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
