#!/usr/bin/env python3
"""Rebuilds the two Matron's Office fix sheets and points the cut list at them.

    python3 tools/sprite_fixes/matrons_office_make_fix_sheets.py     (from the project folder)

The pictures on the objects b sheet, and the bible box and door on the container sheets,
stand too close together for cut_sprites.py to separate. This copies each one, pixels
unchanged, onto a new grey sheet with wide gaps:
  assets/objects/matrons_office_objects_fix_sheet_v1.png     (4 x 3, the twelve b-sheet objects)
  assets/objects/matrons_office_containers_fix_sheet_v1.png  (4 x 1: bible box and door, open then closed)
and makes tools/sprite_cuts/matrons_office.json take those sprites from the new sheets.
"""
import json

from PIL import Image

# --- objects ---
V="matrons_office_objects_b_sheet_v2.png"
tiles=[("payment_ledger",(0,0,353,358)),("seven_death_certs",(353,0,722,349)),("true_register",(722,0,1078,361)),("eight_tickets",(1078,0,1448,325)),
("bank_book",(0,358,370,722)),("sleeping_draught",(370,349,717,703)),("master_key",(717,361,1104,730)),("crane_photograph",(1104,325,1448,706)),
("name_tape_reel",(0,722,359,1086)),("charred_photographs",(359,703,726,1086)),("vane_family_ring",(726,730,1062,1086)),("night_count_slate",(1062,706,1448,1086))]
T=(560,560)
n=Image.new("RGB",(T[0]*4,T[1]*3),(105,106,107))
p="tools/sprite_cuts/matrons_office.json"; d=json.load(open(p))
im=Image.open("assets/objects/"+V).convert("RGB")
for i,(oid,box) in enumerate(tiles):
    c=im.crop(box)
    n.paste(c,((i%4)*T[0]+(T[0]-c.width)//2,(i//4)*T[1]+(T[1]-c.height)//2))
    for o in d["objects"]:
        if o["id"]==oid:
            o.pop("box",None); o["sheet"]="matrons_office_objects_fix_sheet_v1.png"; o["grid"]=[4,3]; o["cell"]=[i%4,i//4]; o["grow"]=0
n.save("assets/objects/matrons_office_objects_fix_sheet_v1.png")
json.dump(d,open(p,"w"),indent=1)

# --- containers ---
O="matrons_office_containers_open_sheet_v1.png"; C="matrons_office_containers_closed_sheet_v1.png"
tiles=[("bible_box","open",O,(1088,358,1448,675)),("ward_stair_door","open",O,(1100,675,1448,1086)),
       ("bible_box","closed",C,(1075,400,1448,675)),("ward_stair_door","closed",C,(1100,675,1448,1086))]
T=(560,560)
n=Image.new("RGB",(T[0]*4,T[1]*1),(105,106,107))
p="tools/sprite_cuts/matrons_office.json"; d=json.load(open(p))
for i,(cid,st,sh,box) in enumerate(tiles):
    c=Image.open("assets/objects/"+sh).convert("RGB").crop(box)
    n.paste(c,((i%4)*T[0]+(T[0]-c.width)//2,(i//4)*T[1]+(T[1]-c.height)//2))
    for o in d["containers"]:
        if o["id"]=="matrons_office_"+cid:
            o[st]={"sheet":"matrons_office_containers_fix_sheet_v1.png","grid":[4,1],"cell":[i%4,i//4],"grow":0}
n.save("assets/objects/matrons_office_containers_fix_sheet_v1.png")
json.dump(d,open(p,"w"),indent=1)
print("saved both fix sheets")
