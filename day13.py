# Day 13 of Advent of Code, in Python
import copy
FAVNUM = 1352
DEST = (31, 39)

def is_wall(x, y):
    yet_to_bin = x*x + 3*x + 2*x*y + y + y*y + FAVNUM
    binary = list(bin(yet_to_bin))[2:]
    return binary.count('1') % 2 == 1

current_coord = [1, 1]
steps_req = 0
prev_move = 10
# move direction: 2 up, -2 down, -1 left, 1 right

def desired_dirs():
    right, down = (DEST[0] > current_coord[0],
                   DEST[1] > current_coord[1])
    output = [2, -1]
    if right: output[1] *= -1
    if down: output[0] *= -1
    return output

def move(direction):
    instructions = [(1, 1), (0, -1), None, (0, 1), (1, -1)]
    current_ins = instructions[direction + 2]
    current_coord[current_ins[0]] += current_ins[1]
    if is_wall(*current_coord):
        current_coord[current_ins[0]] -= current_ins[1]
        return False
    return True

def future_coord(coord_now, direction):
    now_c = copy.copy(coord_now)
    instructions = [(1, 1), (0, -1), None, (0, 1), (1, -1)]
    current_ins = instructions[direction + 2]
    now_c[current_ins[0]] += current_ins[1]
    if now_c[0] < 0 or now_c[1] < 0: return coord_now
    return now_c

def serialize_coords(coords):
    return ",".join([str(x) for x in coords])

def deserialize_coords(cstr):
    return [int(x) for x in cstr.split(',')]

def bfs():
    # init
    vertex_values = {serialize_coords(current_coord): [0, None]}
    queue = [current_coord]

    while serialize_coords(DEST) not in vertex_values:
        work_v = queue.pop(0)
        for direct in [-2, -1, 1, 2]:
            fc = future_coord(work_v, direct)
            if not is_wall(*fc) and not serialize_coords(fc) in vertex_values:
                queue.append(fc)
                vertex_values[serialize_coords(fc)] = [vertex_values[serialize_coords(work_v)][0] + 1, work_v]
    return vertex_values

bfs_result = bfs()
print("part1: Distance to target: {}".format(bfs_result[serialize_coords(DEST)][0]))
count = 0
for coord in bfs_result:
    if bfs_result[coord][0] <= 50: count += 1
print("part2: Amount of nodes with <=50 steps: {}".format(count))
