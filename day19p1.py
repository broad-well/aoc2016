# Day 19 of Advent of Code
from math import floor

elves = list(range(1, 3012211))

while len(elves) > 1:
    print(len(elves))
    indexes = []
    indexes += list(range(1, floor(len(elves)/2+1)))
    if len(elves) % 2 == 1:
        indexes.append(0)
    for i in indexes:
        elves.pop(i)

print(elves[0])
