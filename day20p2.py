# Day 20 of Advent of Code, 2016

# Load the file
with open('data/20.txt') as fil:
    flines = fil.readlines()

INT_CEILING = 4294967295

allowed_count = 0
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
    allowed_count += int(not discovered)
    i += 1

print("Number of IPs allowed = {}".format(allowed_count))