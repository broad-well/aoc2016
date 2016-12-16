# Day 16 of Advent of Code, 2016
from sys import argv

def inverse(string):
    return string.replace('1', '!').replace('0', '1').replace('!', '0')

def dragon_curve(string):
    return string[:] + '0' + inverse(string[::-1])

def checksum(string):
    csum = ''
    for i in range(0, len(string), 2):
        if string[i] == string[i+1]:
            csum += '1'
        else:
            csum += '0'
    while len(csum) % 2 == 0:
        csum = checksum(csum)
    return csum

disksize = 35651584 if 'part2' in argv else 272
INPUT = '10111011111001111'
diskdata = INPUT[:]

while len(diskdata) < disksize:
    diskdata = dragon_curve(diskdata)
    print("diskdata len: {}\r".format(len(diskdata)), end='')
diskdata = diskdata[:disksize]

print("Checksum is {}".format(checksum(diskdata)))
