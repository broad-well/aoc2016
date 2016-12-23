# (THEORECTICALLY SOLVABLE, TAKES A LONG TIME)
# Day 22 of Advent of Code, 2016
from itertools import permutations

node_data = [['!'[:] for a in range(37)] for b in range(28)]

with open('data/22.txt') as fil:
    INPUT = fil.readlines()

# Fill the data
for line in INPUT:
    li = line.strip()
    toks = li.split(' ')
    while '' in toks: toks.remove('')
    if li[0] == '/':
        # get x and y values
        nx, ny = [int(d[1:]) for d in toks[0][14:].split('-')[1:]]
        used, avail = [int(d[:-1]) for d in toks[2:4]]
        node_data[ny][nx] = (used, avail)
        if used == 0:
            print("Empty node x={} y={}".format(nx, ny))

def charize(use, avai):
    return 'E' if use == 0 else ('.' if use + avai < 200 else '!')

for row in node_data:
    print(''.join([charize(*r) for r in row])) 
