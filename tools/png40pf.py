#!/usr/bin/env python3
# Based on m/tools/png2logo.py

# This script converts a Black and White 40x40 picture from png format
# to dasm format; to be used for Atari VCS 2600 demos.

import os
import sys
import argparse

from PIL import Image

import asmlib
from imglib import *

def sanitize(s):
    return ''.join([c if c.isalnum() else '_' for c in s])

def sanity_check(im):
    """Checks that the image has the appropriate format:
    * width is a multiple of 8

    """
    w,h = im.size
    msg = None
    if w%8 != 0:
        msg = "Image width is not a multiple of 8: {}".format(w)
    if msg:
        raise BadImageException(msg)

def playfields(l):
    pfs = []
    pfs.append(list(reversed(l[0:4])) + 4*[False])
    pfs.append(l[4:12])
    pfs.append(list(reversed(l[12:20])))
    pfs.append(list(reversed(l[20:24])) + 4*[False])
    pfs.append(l[24:32])
    pfs.append(list(reversed(l[32:40])))
    return flatten(pfs)

def dump_picture(fname, img_name, revert):
    # Convert to 1 byte in {0,255} per pixel
    im   = Image.open(fname)

    # Beware im.convert('1') seems to introduce bugs !
    # To be troubleshooted and fixed upstream !
    # In the mean time using im.convert('L') instead
    grey = im.convert('L')
    sanity_check(grey)
    arr   = bool_array(grey)

    lines = [arr[i:i+40] for i in range(0, len(arr), 40)]
    pfs   = [playfields(l) for l in lines]
    pack  = pack_bytes(flatten(pfs))

    if revert:
        pack = [~v & 0xff for v in pack]

    for i in range(6): # 6 platfield registers
        pack_pfs = reversed(pack[i::6]) # 40 lines
        # Beware: reversing the lines to display them from end to start in Atari code
        # There's a little gain of doing that.
        print(f"pf{i}_{img_name}:")
        print(asmlib.lst2asm(pack_pfs, 8))


def dump_structures(img_name):
    # Print pointers
    print(f"ptr_{img_name}:")
    for i in range(6):
        print(f"\tdc.w pf{i}_{img_name}")

    print(f"clip_{img_name}:")
    print( "\tdc.b $01\t; type vertical scroller")
    print(f"\tdc.w ptr_{img_name}")


def main():
    parser = argparse.ArgumentParser(description="Converts a black and white png image to dasm data usable by an Atari 2600 program.")
    parser.add_argument("fname", type=str, help="Path to png image file")
    parser.add_argument("-r", "--revert", action="store_true", help="Reverts the black and white")
    parser.add_argument("-p", "--picture", action="store_true", help="Dump picture data rather than structure")
    args = parser.parse_args()

    img_name = sanitize(os.path.splitext(os.path.basename(args.fname))[0])
    if args.picture:
        dump_picture(args.fname, img_name, args.revert)
    else:
        dump_structures(img_name)

if __name__ == "__main__":
    main()
