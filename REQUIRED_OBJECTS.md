# Required Objects and Containers

All 332 hidden objects in the game are required: every file in `resources/objects/` has
`is_required = true`, and no scene overrides it. A room is completed only when every object
in it is found.

There are 156 containers. Containers have no "required" flag of their own, but each holds one
of the required objects, so every one must be opened. 44 need another object found first,
26 need a keypad code, and the 3 ice blocks need several clicks.

Painted art so far: 151 objects (the Bedroom's 5, the Basement's 6 and all 140 of House Three)
and 76 containers (the Basement's old trunk and all 75 of House Three). The other 181 objects
and 80 containers, in the rest of House One and all of House Two, still use placeholder art.

## Required objects

### House One: Ashworth Manor (59)

| Room | # | Required objects |
|---|---|---|
| Bedroom | 5 | missing_letter, old_diary, old_photograph, rusty_key, teddy_bear |
| Basement | 6 | film_negatives, hospital_wristband, muddy_boots, music_box, newspaper_clipping, pocket_watch |
| Attic | 7 | account_ledger, brass_key, childs_drawing, cracked_spectacles, last_will, silver_locket, telegram |
| Staircase | 7 | boathouse_map, empty_key_ring, hair_ribbon, iron_key, leather_glove, portrait_nameplate, telephone_cord |
| Washroom | 8 | hairbrush, perfume_bottle, rubber_duck, sleeping_pills, soap_imprint, straight_razor, tiny_cabinet_key, wet_photograph |
| Living Room | 8 | crossword, desk_key, gramophone_record, insurance_policy, knitted_scarf, matchbox, spare_keys, tobacco_pipe |
| Kitchen | 9 | burnt_letter, egg_timer, lake_pebble, rat_poison_tin, recipe_card, servants_key, sugar_mouse, tin_opener, wooden_spoon |
| Study | 9 | boathouse_key, calendar_page, forged_signatures, fountain_pen, letter_opener, magnifying_glass, mara_portrait, real_will, signet_ring |

### House Two: Blackwater Boathouse (133)

| Room | # | Required objects |
|---|---|---|
| Jetty | 10 | brass_compass, cigarette_case, fishing_float, log_page, message_bottle, name_board, police_seal, prescription, registration, tackle_key |
| Boat Shed | 11 | bank_receipt, bench_key, coat_button, diving_goggles, dropped_torch, ether_bottle, handkerchief, loft_key, maras_purse, ship_bell, train_ticket |
| Loft | 12 | bedsheet_rope, candle_stub, hairpin, padlock_key, pocket_mirror, pressed_violet, rag_doll, sedative_vial, tin_cup, unsent_letter, visiting_card, workshop_key |
| Workshop | 13 | boat_model, cupboard_key, diving_lamp, hand_drill, hull_plan, job_book, letter_stencil, mallet, oil_can, paint_tin, wooden_bung, wood_plane, work_glove |
| Sunken Boat | 13 | cabin_key, drill_bit, hair_comb, ice_house_key, iron_shackle, pearl_earring, sextant, ship_lantern, ship_log, silver_frame, steel_file, teacup, wine_bottle |
| Ice House | 14 | frozen_brooch, frozen_pike, horse_blanket, ice_pick, ice_saw, ice_tongs, keepers_note, lighthouse_key, lost_mitten, scratched_slate, signal_whistle, snowshoe, soup_tin, torn_sleeve |
| Lighthouse Steps | 14 | bandage_roll, barometer, gull_feather, keeper_logbook, keepers_photo, knitting_needles, lamp_room_key, lifesaving_medal, oilskin_hat, paraffin_can, ship_in_bottle, telescope, tide_table, wick_trimmer |
| Lamp Room | 15 | bell_hammer, binoculars, chapel_key, ferry_ticket, lamp_mantle, lens_cloth, newspaper_page, oil_funnel, pencil_sketch, postcard, radio_valve, rosary, telegram_form, tobacco_tin, wind_gauge |
| Island Chapel | 15 | candle_snuffer, collection_plate, cottage_map, doctors_letter, embroidery_hoop, grey_veil, hand_bell, hymn_book, oarlock, parish_register, pewter_cup, prayer_card, trowel, vestry_key, wooden_cross |
| Vane Cottage | 16 | carriage_clock, cellar_key, cheque_book, confession, death_certificate, decanter, glass_syringe, grey_shawl, medical_file, name_bracelet, passport, pen_knife, police_whistle, specimen_jar, stethoscope, timetable |

### House Three: Hollowmere Sanatorium (140)

| Room | # | Required objects |
|---|---|---|
| Gate Lodge | 17 | admission_card, brass_ward_tag, duty_roster, enamel_mug, hurricane_lamp, night_round_card, porters_cap, pushed_note, smelling_salts, snuff_box, toy_soldier, trunk_key, unposted_letters, visitors_book, visitors_pass, wage_packet, ward_door_key |
| X-Ray Room | 18 | appointment_book, bent_spoon, boot_heel_key, chest_xray, darkroom_tongs, lead_gloves, matrons_memo, name_tags, nurses_watch, paper_boat, pencil_stub, red_safelight, rolled_note, sewn_photograph, torn_label, ward_map, ward_seven_key, xray_tube |
| Laundry | 19 | blue_bag, boiler_room_key, carbolic_soap, childs_spectacles, darning_egg, dolly_peg, flat_iron, initialled_pillowcase, laundry_scissors, laundry_ticket, linen_tally, locker_key, mangle_note, nells_diary, pressed_letter, scorched_page, smock_seven, ward_seven_chit, washboard |
| Boiler Room | 20 | billy_can, buried_satchel, burn_order, clinker_rake, coal_shovel, cracked_gauge, dose_cup, half_burnt_ledger, lift_crank, lift_key, makers_plate, night_log, oil_rag, pencilled_plan, scorched_buckle, spanner, stokers_cap, stokers_pay_slip, tin_whistle, unburnt_file |
| Dispensary | 21 | apothecary_scales, blank_death_forms, blue_bottle, brass_weight, bureau_key, chloral_bottle, crane_telegram, dose_book, label_roll, matrons_office_key, measuring_glass, medicine_spoon, ointment_jar, pestle, pill_box, prescription_spike, resignation_draft, sealed_ampoules, standing_orders, sugar_pills, ward_chart |
| Matron's Office | 22 | bank_book, brass_desk_bell, caddy_key, charred_photographs, crane_photograph, eight_tickets, hat_pin, master_key, muddy_galoshes, name_tape_reel, night_count_slate, packed_valise, payment_ledger, picture_rail_key, ringed_calendar, seven_death_certs, silver_inkstand, sleeping_draught, telephone_receiver, travelling_cloak, true_register, vane_family_ring |
| Ward Seven | 23 | alarm_handle, bed_chart, bed_frame_key, cloth_rabbit, dose_tray, fire_bell_key, fire_bucket, hair_slide, harmonica, hidden_file, ivys_token, night_lamp, prayer_book, reading_glasses, restraint_strap, ruths_sampler, scratched_calendar, seven_envelopes, strongbox_key, thimble_case, ward_slippers, window_bar, wooden_yoyo |

## Containers

The Bedroom has no containers. Names are each container's `container_id`.

### House One: Ashworth Manor (17)

| Room | Container | Holds | Lock |
|---|---|---|---|
| Basement | old_trunk | newspaper_clipping | none |
| Attic | jewellery_box | silver_locket | needs brass_key |
| | hat_box | telegram | none |
| Staircase | grandfather_clock | iron_key | none |
| | hall_table_drawer | boathouse_map | needs iron_key |
| Washroom | medicine_cabinet | sleeping_pills | needs tiny_cabinet_key |
| | laundry_basket | wet_photograph | none |
| Living Room | piano_bench | insurance_policy | none |
| | cigar_box | desk_key | none |
| | desk_drawer | spare_keys | needs desk_key |
| Kitchen | bread_bin | servants_key | none |
| | oven | burnt_letter | none |
| | biscuit_tin | sugar_mouse | needs tin_opener |
| Study | humidor | letter_opener | none |
| | desk_drawer | boathouse_key | needs letter_opener |
| | wall_safe | real_will | code 1704 |
| | bookcase_compartment | mara_portrait | none |

### House Two: Blackwater Boathouse (64)

| Room | Container | Holds | Lock |
|---|---|---|---|
| Jetty | bait_bucket | log_page | none |
| | tackle_box | tackle_key | none |
| | fish_crate | registration | needs tackle_key |
| | dock_locker | prescription | code 2209 |
| Boat Shed | first_aid_box | ether_bottle | none |
| | strongbox | bench_key | none |
| | workbench_drawer | bank_receipt | needs bench_key |
| | net_basket | diving_goggles | none |
| | tool_chest | loft_key | code 2350 |
| Loft | sewing_basket | padlock_key | none |
| | hatbox | rag_doll | none |
| | biscuit_tin | pressed_violet | none |
| | loose_floorboard | unsent_letter | none |
| | doctors_case | sedative_vial | needs padlock_key |
| | sea_chest | workshop_key | code 1405 |
| Workshop | bench_drawer | job_book | none |
| | bung_crate | wooden_bung | none |
| | log_basket | mallet | none |
| | stencil_box | letter_stencil | none |
| | cash_box | cupboard_key | code 0110 |
| | tool_cupboard | diving_lamp | needs cupboard_key |
| Sunken Boat | chart_drawer | cabin_key | none |
| | cabin_door | iron_shackle | needs cabin_key |
| | key_box | ice_house_key | code 2140 |
| | skipper_locker | ship_log | none |
| | galley_cupboard | teacup | none |
| | toolbox | drill_bit | none |
| | ditty_box | silver_frame | none |
| Ice House | agnes_basket | soup_tin | none |
| | sawdust_bin | signal_whistle | none |
| | tool_locker | ice_saw | code 1896 |
| | pike_ice | frozen_pike | needs ice_pick, 3 clicks |
| | brooch_ice | frozen_brooch | 4 clicks |
| | drain_ice | lighthouse_key | needs ice_saw, 5 clicks |
| Lighthouse Steps | oil_store | paraffin_can | code 0310 |
| | knitting_basket | knitting_needles | none |
| | twine_parcel | keepers_photo | needs wick_trimmer |
| | medal_box | lifesaving_medal | needs knitting_needles |
| | key_box | lamp_room_key | needs paraffin_can |
| | first_aid_tin | bandage_roll | none |
| Lamp Room | lens_cupboard | lens_cloth | none |
| | desk_drawer | tobacco_tin | none |
| | radio_cabinet | radio_valve | none |
| | rope_basket | bell_hammer | none |
| | oil_locker | oil_funnel | needs bell_hammer |
| | writing_box | rosary | code 0640 |
| | sea_chest | chapel_key | needs rosary |
| Island Chapel | alms_box | vestry_key | code 1989 |
| | vestry_door | cottage_map | needs vestry_key |
| | sewing_basket | embroidery_hoop | none |
| | pulpit_drawer | doctors_letter | none |
| | parish_chest | parish_register | none |
| | font_cover | wooden_cross | none |
| | pew_box | prayer_card | none |
| | aumbry | pewter_cup | none |
| | candle_box | candle_snuffer | none |
| Vane Cottage | desk_drawer | death_certificate | none |
| | medicine_cupboard | glass_syringe | none |
| | fake_spines | medical_file | none |
| | log_basket | grey_shawl | none |
| | parcel | passport | needs pen_knife |
| | desk_safe | confession | code 0810 |
| | doctors_bag | cellar_key | code 1987 |
| | cellar_door | name_bracelet | needs cellar_key |

### House Three: Hollowmere Sanatorium (75)

| Room | Container | Holds | Lock |
|---|---|---|---|
| Gate Lodge | desk_drawer | duty_roster | none |
| | coal_scuttle | admission_card | none |
| | coat_locker | wage_packet | none |
| | mail_sack | toy_soldier | none |
| | first_aid_tin | smelling_salts | none |
| | key_cabinet | trunk_key | code 1403 |
| | lost_property_trunk | visitors_book | needs trunk_key |
| | strongbox | ward_door_key | code 1985 |
| | inner_door | pushed_note | needs ward_door_key |
| X-Ray Room | film_cabinet | chest_xray | none |
| | developer_tank | darkroom_tongs | none |
| | laundry_hamper | lead_gloves | none |
| | desk_drawer | appointment_book | none |
| | waste_bin | torn_label | none |
| | light_box | name_tags | none |
| | instrument_case | matrons_memo | needs boot_heel_key |
| | control_cabinet | xray_tube | code 0791 |
| | drug_safe | ward_seven_key | code 1285 |
| | steel_door | paper_boat | needs ward_seven_key |
| Laundry | linen_press | linen_tally | needs laundry_scissors |
| | wash_copper | locker_key | none |
| | sorting_basket | initialled_pillowcase | none |
| | mangle_drawer | mangle_note | none |
| | ironing_drawer | pressed_letter | none |
| | soap_crate | childs_spectacles | none |
| | nells_locker | nells_diary | needs locker_key |
| | cash_tin | ward_seven_chit | code 2616 |
| | drying_cabinet | boiler_room_key | code 0540 |
| | boiler_room_door | scorched_page | needs boiler_room_key |
| Boiler Room | coal_bunker | buried_satchel | none |
| | ash_pan | scorched_buckle | none |
| | stokers_locker | burn_order | needs spanner |
| | tool_box | lift_crank | none |
| | fire_door | unburnt_file | needs clinker_rake |
| | bench_drawer | stokers_pay_slip | none |
| | gauge_case | night_log | code 1911 |
| | lunch_tin | pencilled_plan | none |
| | pipe_hatch | tin_whistle | none |
| | meter_box | lift_key | code 2311 |
| | service_lift | dose_cup | needs lift_key |
| Dispensary | poison_cupboard | chloral_bottle | code 2130 |
| | powder_drawer | dose_book | none |
| | label_drawer | blank_death_forms | none |
| | ice_chest | sealed_ampoules | none |
| | bureau | standing_orders | needs bureau_key |
| | leech_jar | bureau_key | needs prescription_spike |
| | pill_machine | sugar_pills | none |
| | white_coat | resignation_draft | none |
| | scales_case | ward_chart | needs brass_weight |
| | controlled_safe | matrons_office_key | code 1962 |
| | office_door | crane_telegram | needs matrons_office_key |
| Matron's Office | desk_drawer_left | payment_ledger | none |
| | desk_drawer_right | seven_death_certs | needs picture_rail_key |
| | filing_cabinet | true_register | code 1979 |
| | waste_basket | eight_tickets | none |
| | carpet_bag | bank_book | none |
| | tea_caddy | sleeping_draught | needs caddy_key |
| | wall_safe | master_key | code 0125 |
| | bible_box | crane_photograph | none |
| | sewing_drawer | name_tape_reel | none |
| | fire_grate | charred_photographs | none |
| | jewel_case | vane_family_ring | needs hat_pin |
| | ward_stair_door | night_count_slate | needs master_key |
| Ward Seven | tobys_locker | reading_glasses | none |
| | ruths_locker | wooden_yoyo | none |
| | alberts_locker | hair_slide | none |
| | linen_chest | cloth_rabbit | none |
| | nurses_desk_drawer | prayer_book | none |
| | medicine_trolley | dose_tray | needs bed_frame_key |
| | nurses_locker | harmonica | needs ivys_token |
| | confiscation_box | thimble_case | code 0510 |
| | barred_shutter | window_bar | needs hidden_file |
| | restraint_cupboard | restraint_strap | code 1923 |
| | ward_strongbox | seven_envelopes | needs strongbox_key |
| | fire_bell_box | alarm_handle | needs fire_bell_key |
