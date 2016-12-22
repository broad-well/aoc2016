# Day 22 of Advent of Code, 2016
from itertools import permutations

node_data = []
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
        node_data.append((used, avail, ny, nx))

print("File read complete - {} nodes".format(len(node_data)))

def isviable(na, nb):
    if na[0] == 0: return False
    if na[2:] == nb[2:]: return False
    return na[0] <= nb[1]

ct = 0
for pr in permutations(node_data, 2):
    if isviable(*pr): ct += 1

print("Answer is {}".format(ct))