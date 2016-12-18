# Day 18 of Advent of Code, part 1

INPUT = '.^^^^^.^^^..^^^^^...^.^..^^^.^^....^.^...^^^...^^^^..^...^...^^.^.^.......^..^^...^.^.^^..^^^^^...^.'
floorspace = [list(INPUT)]

def is_trap(cx, cy):
    # eg cx = 2, cy = 1
    prevrow_set = [None] * 3
    prevrow_set[1] = floorspace[cy - 1][cx]
    prevrow_set[0] = '.' if cx == 0 else floorspace[cy - 1][cx - 1]
    prevrow_set[2] = '.' if cx == len(INPUT) - 1 else floorspace[cy - 1][cx + 1]
    return ''.join(prevrow_set) in ['^^.', '.^^', '^..', '..^']

for i in range(1, 40):
    if len(floorspace) <= i:
        floorspace.append([None] * len(INPUT))
    for i2 in range(len(INPUT)):
        floorspace[i][i2] = ['.', '^'][is_trap(i2, i)]

stc = 0
for row in floorspace:
    stc += ''.join(row).count('.')
print(stc)