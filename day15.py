from sys import argv
# Day 15 of Advent Of Code
# Note: pypy3 is much better than python3 at this in terms of performance.

class Disc:
    num = -1
    pos_count = 1
    pos_at_t0 = -1

    def __init__(self, input_str):
        i_toks = input_str.split()
        if len(i_toks) < 5:
            return
        self.pos_count = int(i_toks[3])
        self.pos_at_t0 = int(i_toks[-1][:-1])
        self.num = int(i_toks[1][1:])

    def pos_at_time(self, time):
        return (time + self.pos_at_t0 + self.num) % self.pos_count

with open('data/15.txt') as fil:
    INPUT = fil.readlines()

discs = []
for i in INPUT:
    if i == "\n":
        continue
    discs.append(Disc(i.strip()))
if "part2" in argv:
    disc = Disc('')
    disc.num = len(discs) + 1
    disc.pos_count = 11
    disc.pos_at_t0 = 0
    discs.append(disc)

i = 0
while True:
    if len(set([x.pos_at_time(i) for x in discs])) == 1:
        print("Start at time {}".format(i))
        break
    i += 1
