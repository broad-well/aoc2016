# (THEORECTICALLY SOLVABLE, TAKES A LONG TIME)
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
        node_data.append((used, avail, ny, nx, used+avail))

print("File read complete - {} nodes".format(len(node_data)))

def isviable(na, nb):
    if na[0] == 0:
        return False
    if na[2:] == nb[2:]:
        return False
    return na[0] <= nb[1]

def regen_pairs(nd):
    pairs = []
    for pr in permutations(nd, 2):
        # adjacency needs to be checked
        totlen = 0
        for i in [3, 2]:
            totlen += abs(pr[1][i] - pr[0][i])
        if isviable(*pr) and totlen == 1:
            pairs.append(pr)
    return pairs

dfs_o = (0, 36)
def dfs(objective = dfs_o):
    stack = [(node_data, 0)]
    infoloc = objective
    while stack and infoloc != (0, 0):
        nd, steps = stack.pop()
        prs = regen_pairs(nd)
        for pr in prs:
            new_nd = nd[:]
            ixa, ixb = [new_nd.index(b) for b in pr]
            new_nd[ixa] = list(new_nd[ixa])
            new_nd[ixb] = list(new_nd[ixb])
            mds = new_nd[ixa][0]
            new_nd[ixa][0] = 0
            new_nd[ixa][1] = new_nd[ixa][4]
            new_nd[ixb][0] += mds
            new_nd[ixb][1] -= mds
            if new_nd[ixa][2:4] == infoloc:
                infoloc = new_nd[ixb][2:4]
                print(infoloc)
                if infoloc == (0, 0):
                    return steps + 1
            stack.append((new_nd, steps+1))

print(dfs())