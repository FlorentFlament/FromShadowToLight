from PIL import Image
from imglib import *

def line_playfields(line):
    pfs = []
    pfs.append(list(reversed(line[0:4])) + 4*[False])
    pfs.append(line[4:12])
    pfs.append(list(reversed(line[12:20])))
    pfs.append(list(reversed(line[20:24])) + 4*[False])
    pfs.append(line[24:32])
    pfs.append(list(reversed(line[32:40])))
    return flatten(pfs)

def picture_playfields(filename):
    # Convert to 1 byte in {0,255} per pixel
    im   = Image.open(filename)
    # Beware im.convert('1') seems to introduce bugs !
    # To be troubleshooted and fixed upstream !
    # In the mean time using im.convert('L') instead
    grey = im.convert('L')
    arr  = bool_array(grey)

    lines    = [arr[i:i+40] for i in range(0, len(arr), 40)]
    pfs      = [line_playfields(l) for l in lines]
    pack     = pack_bytes(flatten(pfs))
    pack_pfs = [list(reversed(pack[i::6])) for i in range(6)]
    return pack_pfs
