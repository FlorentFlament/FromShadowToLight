#!/usr/bin/env python3
import os
import sys
import yaml
import click
from pflib import picture_playfields
from imglib import flatten
from asmlib import *

PIC_LINES = 40 # 40 lines per picture

def sanitize(s):
    return ''.join([c if c.isalnum() else '_' for c in s])

def dump_pictures(config, name, directory):
    # One big array per picture
    pics_pfs = [(sanitize(os.path.splitext(pic)[0]),
                 flatten(picture_playfields(f"{directory}/{pic}")))
                for pic in config["pictures"]]
    for name,pfs in pics_pfs:
        print(f"pic_{name}:")
        print(lst2asm(pfs))

def dump_structures(config, anim_name):
    pic_names = [sanitize(os.path.splitext(p)[0]) for p in config["pictures"]]
    for name in pic_names:
        print(f"pfs_{name}:")
        for i in range(6):
            print(f"\tdc.w pic_{name} + {i*PIC_LINES}")

    print(f"ptr_{anim_name}:")
    for name in pic_names:
        print(f"\tdc.w pfs_{name}")

    print(f"seq_{anim_name}:")
    print(lst2asm(config["sequence"]+[0xff]))

    print(f"clip_{anim_name}:")
    print( "\tdc.b $00\t; type animation")
    print(f"\tdc.w ptr_{anim_name}")
    print(f"\tdc.w seq_{anim_name}")

@click.command()
@click.option("--config", required=True, help="Required configuration file")
@click.option("--pics-data/--no-pics-data", help="Dump pictures data instead of structures", show_default=True)
def main(config, pics_data):
    with open(config) as fd:
        cfg=yaml.full_load(fd)
    anim_name = sanitize(os.path.splitext(os.path.basename(config))[0])
    anim_dir  = os.path.dirname(config)
    if pics_data:
        dump_pictures(cfg, anim_name, anim_dir)
    else:
        dump_structures(cfg, anim_name)

main()
