# Day 19 of Advent of Code

i = 0
for o in range(1, 3012211):
    i = (i+2)%o
print(i+1)
