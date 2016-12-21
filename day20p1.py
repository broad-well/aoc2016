# Day 20 of Advent of Code, 2016

# Load the file
with open('data/20.txt') as fil:
    flines = fil.readlines()

INT_CEILING = 4294967295

i = 0
discovered = False
while i < INT_CEILING:
    discovered = False
    for line in flines:
        low, high = [int(x) for x in line.split('-')]
        if low <= i <= high:
            i = high
            discovered = True
            break
    if not discovered:
        print('Lowest number is {}'.format(i))
        exit()
    i += 1