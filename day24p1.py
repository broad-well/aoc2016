# Day 24 of Advent of Code, 2016
import itertools
import random
from copy import copy

grid = []
locs = {}

with open('data/24.txt') as input_:
    y = 0
    for line in input_.readlines():
        grid.append(list(line.strip()))
        for i in '01234567':
            if i in line:
                locs[int(i)] = (y, line.index(i))
        y += 1

def cellat(tup):
    y, x = tup
    if (y >= len(grid)) or (x >= len(grid[0])) or (y < 0) or (x < 0):
        return '#'
    else:
        return grid[tup[0]][tup[1]]

def pathlento(begin, end):
    # begin is a tuple containing (y, x), end is a number
    # returns steps required
    seen = set()
    queue = [(locs[begin], 0)]

    while queue:
        coord, step = queue.pop(0)
        if coord in seen:
            continue
        else:
            seen.add(coord)
        for xa, ya in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
            newc = (coord[0] + ya, coord[1] + xa)
            if newc == locs[end]: return step + 1
            if newc in seen: continue
            newe = cellat(newc)
            if newe == '#': continue
            #if newe == str(end): return (newc, step + 1)
            queue.append((newc, step + 1))

dists = {}
for start, end in itertools.permutations(range(8), 2):
    dists[str(start) + str(end)] = pathlento(start, end)

lowroute = 100000
for route in itertools.permutations(range(8)):
    if route[0] != 0: continue
    cost = 0
    for i in range(7):
        cost += dists[''.join([str(x) for x in route[i:i+2]])]
    if cost < lowroute:
        print(cost, route)
        lowroute = cost

print(lowroute)