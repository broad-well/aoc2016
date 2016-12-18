# Day 18 of Advent of Code, part 2

INPUT = '.^^^^^.^^^..^^^^^...^.^..^^^.^^....^.^...^^^...^^^^..^...^...^^.^.^.......^..^^...^.^.^^..^^^^^...^.'
prev_row = INPUT

def is_trap(cx, cy):
    # eg cx = 2, cy = 1
    prevrow_set = [None] * 3
    prevrow_set[1] = prev_row[cx]
    prevrow_set[0] = '.' if cx == 0 else prev_row[cx - 1]
    prevrow_set[2] = '.' if cx == len(INPUT) - 1 else prev_row[cx + 1]
    return ''.join(prevrow_set) in ['^^.', '.^^', '^..', '..^']

stc = 0
for i in range(1, 400000):
    stc += prev_row.count('.')
    thisrow = ''
    for i2 in range(len(INPUT)):
        thisrow += ['.', '^'][is_trap(i2, i)]
    prev_row = thisrow
    if i % 20000 == 0:
        print(i, end='\r') 
stc += prev_row.count('.')

print(stc)
