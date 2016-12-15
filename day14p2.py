# Day 15 of Advent of Code

import hashlib
salt = 'zpqevtbw'
#salt = 'abc'

padkeys = []

def repeat(charlen, _str):
    o = 0
    while o <= len(_str) - charlen:
        if len(set(_str[o:o+charlen])) == 1: return _str[o]
        o += 1
    return None

i = 0
# repeat_criteria: hash index in which the 1000 hashes end, character, pending padkey
repeat_criteria = []

while len(padkeys) < 64:
    digest = hashlib.md5("{}{}".format(salt, i).encode()).hexdigest()
    for p in range(2016):
        digest = hashlib.md5(digest.encode()).hexdigest()
    rep5 = repeat(5, digest)
    rep3 = repeat(3, digest)
    rc_del = []

    for rc in repeat_criteria:
        if rc[1] == rep5 and rc[0] >= i:
            padkeys.append((rc[2], rc[0] - 1000))
            rc_del.append(rc)
        if rc[0] < i:
            rc_del.append(rc)
    for rd in rc_del:
        repeat_criteria.remove(rd)

    if rep3 != None:
        repeat_criteria.append((i + 1000, rep3, digest))

    if i % 100 == 0:
        print(i, end="\r")
    i += 1

print("Answer: {}".format(padkeys[63]))
