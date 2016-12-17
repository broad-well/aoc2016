# Day 17 of Advent of Code
from hashlib import md5
from sys import argv, setrecursionlimit
import collections

INPUT = 'udskfozm'
OPEN_CHARS = list('bcdef')
MOVE_CHARS = 'UDLR' # order matters
POS_ADDITIVE = [
    [0, -1],
    [0, 1],
    [-1, 0],
    [1, 0]
]

def added_pos(orig_pos, move):
    pos_copy = orig_pos[:]
    additive = POS_ADDITIVE[MOVE_CHARS.index(move)]
    pos_copy[0] += additive[0]
    pos_copy[1] += additive[1]
    return pos_copy

def move_valid(position, lastpath, move):
    move_int = MOVE_CHARS.index(move)
    md5_open = md5((INPUT + lastpath).encode()).hexdigest()[:4]
    if md5_open[move_int] not in OPEN_CHARS:
        return False
    new_pos = added_pos(position, move)
    return new_pos[0] in range(4) and new_pos[1] in range(4)

def bfs():
    queue = [([0, 0], '')]
    highway = None
    while queue:
        curpos, curpath = queue.pop(0)
        for move in MOVE_CHARS:
            if move_valid(curpos, curpath, move):
                if added_pos(curpos, move) == [3, 3]:
                    if highway == None:
                        print("Shortest path: {}".format(curpath + move))
                    highway = curpath + move
                    continue
                queue.append((added_pos(curpos, move), curpath + move))
    return highway

print(len(bfs()))
