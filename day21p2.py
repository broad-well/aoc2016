# Day 21 of Advent of Code, 2016
from itertools import permutations
# Utility functions

def swap_pos(_str, x, y):
    strlist = list(_str)
    strlist[x], strlist[y] = strlist[y], strlist[x]
    return ''.join(strlist)

def swap_letter(_str, x, y):
    return _str.replace(x, '&').replace(y, x).replace('&', y)

def rotate(_str, dirstr, count):
    strl = list(_str)
    for i in range(count % len(_str)):
        if dirstr == 'left':
            strl.append(strl.pop(0))
        else:
            assert dirstr == 'right'
            strl.insert(0, strl.pop())
    return ''.join(strl)

def rotate_index(_str, letter):
    _str = rotate(_str, 'right', _str.index(letter) + 1 + int(_str.index(letter) >= 4))
    return _str

def reverse(_str, istart, iend):
    strl = list(_str)
    subl = []
    for i in range(iend - istart + 1):
        subl.append(strl.pop(istart))
    for i in subl:
        strl.insert(istart, i)
    return ''.join(strl)

def move(_str, ia, ib):
    strl = list(_str)
    strl.insert(ib, strl.pop(ia))
    return ''.join(strl)

STARTWITH = ['swap position', 'swap letter', 'rotate based', 'reverse', 'move']
pwd = 'abcdefgh'

def parse_line(line, inp):
    toks = line.split(' ')
    if line.startswith('swap position'):
        return swap_pos(inp, int(toks[2]), int(toks[5]))
    elif line.startswith('swap letter'):
        return swap_letter(inp, toks[2], toks[5])
    elif line.startswith('rotate based'):
        return rotate_index(inp, toks[6])
    elif line.startswith('rotate'):
        return rotate(inp, toks[1], int(toks[2]))
    elif line.startswith('reverse'):
        return reverse(inp, int(toks[2]), int(toks[4]))
    elif line.startswith('move'):
        return move(inp, int(toks[2]), int(toks[5]))
    else:
        print("!! {}".format(line))

with open('data/21.txt') as e:
    lns = e.readlines()

for poss in permutations(pwd):
    pwd = ''.join(poss)
    orig = ''.join(poss)
    for l in lns:
        pwd = parse_line(l.strip(), pwd)
    if pwd == 'fbgdceah':
        print(orig)
        break