#!/usr/bin/env python3
import os
import sys
import yaml
from pflib import picture_playfields
from imglib import flatten
from asmlib import *

def sanitize(s):
    return ''.join([c if c.isalnum() else '_' for c in s])

def main():
    file_path = sys.argv[1]
    directory = os.path.dirname(file_path)
    with open(file_path) as fd:
        config=yaml.full_load(fd)

    # One big array per picture
    pics_pfs = [(sanitize(os.path.splitext(pic)[0]), flatten(picture_playfields(f"{directory}/{pic}")))
                for pic in config["pictures"]]
    pic_names = [p[0] for p in pics_pfs]
    pic_lines = len(pics_pfs[0][1]) // 6 # Lines count for a picture
    
    for name,pfs in pics_pfs:
        print(f"pic_{name}:")
        print(lst2asm(pfs))

    for name in pic_names:
        print(f"pfs_{name}:")
        for i in range(6):
            print(f"\tdc.w pic_{name} + {i*pic_lines}")

    anim_name = sanitize(os.path.splitext(os.path.basename(file_path))[0])
    print(f"ptr_{anim_name}:")
    for name in pic_names:
        print(f"\tdc.w pfs_{name}")

    print(f"seq_{anim_name}:")
    print(lst2asm(config["sequence"]))

main()
