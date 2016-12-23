# Day 23 of Advent of Code, 2016
with open('data/23.txt') as assemfil:
    INPUT = assemfil.readlines()

if False:
    INPUT = 'cpy 2 a,tgl a,tgl a,tgl a,cpy 1 a,dec a,dec a'.split(',')

registers = {
    'a': 7,
    'b': 0,
    'c': 0,
    'd': 0
}

def val(expr):
    if expr in registers.keys():
        return registers[expr]
    return int(expr)

def cpy(args):
    if args[1] not in registers.keys():
        # bad instruction
        return False
    registers[args[1]] = val(args[0])
    return True

def inc(args):
    if args[0] not in registers.keys():
        # bad instruction
        return False
    registers[args[0]] += 1
    return True

def dec(args):
    if args[0] not in registers.keys():
        # bad instruction
        return False
    registers[args[0]] -= 1
    return True

CMDMAP = {
    'cpy': cpy,
    'inc': inc,
    'dec': dec
}

def invert(linenum):
    if linenum >= len(INPUT) or linenum < 0: return
    tokens = INPUT[linenum].split(' ')
    if len(tokens) == 2:
        tokens[0] = 'dec' if tokens[0] == 'inc' else 'inc'
    else:
        tokens[0] = 'cpy' if tokens[0] == 'jnz' else 'jnz'
    INPUT[linenum] = ' '.join(tokens)

pc = 0
try:
    while pc < len(INPUT):
        toks = INPUT[pc].strip().split(' ')
        for cmd in CMDMAP:
            if cmd == toks[0]:
                CMDMAP[cmd](toks[1:])
        if toks[0] == 'jnz' and len(toks) > 1 and val(toks[1]) != 0:
            pc += val(toks[2]) - 1
        if toks[0] == 'tgl':
            invert(val(toks[1]) + pc)
        pc += 1
except Exception as e:
    print(e, toks)
print(registers)
