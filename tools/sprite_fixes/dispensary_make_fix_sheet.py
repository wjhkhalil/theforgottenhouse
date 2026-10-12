#!/usr/bin/env python3
"""Rebuilds assets/objects/dispensary_containers_closed_fix_sheet_v1.png.

    python3 tools/sprite_fixes/dispensary_make_fix_sheet.py

It is the closed container sheet with the grey metal tops of the ice chest and the safe
tinted a hair warmer, so cut_sprites.py does not take them for background. The Dispensary
cut list takes the closed ice chest and safe from this sheet.
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import cut_sprites as c
from PIL import Image, ImageDraw, ImageFilter, ImageChops
src="dispensary_containers_closed_sheet_v1.png"
rgb=Image.open(c.OBJECTS_DIR/src).convert("RGB")
alpha=c.sheet(src).getchannel("A")
mask=Image.new("L",rgb.size,0)
for box,ymax in (((1095,85,1448,325),200),((470,695,765,1010),770)):
    a=alpha.crop(box).point(lambda v:255 if v>200 else 0); px=a.load(); pts=[]
    for y in range(a.height):
        xs=[x for x in range(a.width) if px[x,y]]
        if xs: pts+= [(xs[0],y),(xs[-1],y)]
    pts=sorted(set(pts))
    def cross(o,p,q): return (p[0]-o[0])*(q[1]-o[1])-(p[1]-o[1])*(q[0]-o[0])
    lo=[]; 
    for p in pts:
        while len(lo)>=2 and cross(lo[-2],lo[-1],p)<=0: lo.pop()
        lo.append(p)
    up=[]
    for p in reversed(pts):
        while len(up)>=2 and cross(up[-2],up[-1],p)<=0: up.pop()
        up.append(p)
    hull=[(x+box[0],y+box[1]) for x,y in lo[:-1]+up[:-1]]
    m=Image.new("L",rgb.size,0); d=ImageDraw.Draw(m); d.polygon(hull,fill=255)
    d.rectangle([0,ymax,rgb.width,rgb.height],fill=0)
    mask=ImageChops.lighter(mask,m.filter(ImageFilter.MinFilter(5)))
r,g,b=rgb.split()
tint=Image.merge("RGB",(r.point(lambda v:min(255,v+11)),g,b.point(lambda v:max(0,v-11))))
out=Image.composite(tint,rgb,mask)
out.save(c.OBJECTS_DIR/"dispensary_containers_closed_fix_sheet_v1.png")
print("saved dispensary_containers_closed_fix_sheet_v1.png")
