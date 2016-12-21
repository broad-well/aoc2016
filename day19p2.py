# Day 19 of Advent of Code

i = 0
lc = 1
for o in range(4, 3012211):
    if i + 1 == o:
        lc += 1
        i = 1
    elif i < 3**lc:
        i += 1
    else:
        i += 2
print(i)
