'''
    Advent of Code 2020
    Day 8, Part 1
    Instruction parsing
'''

import re

# Import data
with open('Day 08/day08_input.txt') as file:
    data = [line.strip() for line in file]

# Initialize things, and start keeping track of what instructions we've been to
executed = []
pointer = 0
accumulator = 0
infinite = False
while not infinite:
    if pointer in executed:
        infinite = True
        break
    executed.append(pointer)
    m = re.match(r'^(\w{3}) ([+|-]\d+)$', data[pointer])
    operation = m.group(1)
    value = int(m.group(2))
    print(operation, value)
    if operation == 'nop':
        pointer += 1
    elif operation == 'acc':
        accumulator += value
        pointer += 1
    elif operation == 'jmp':
        pointer += value

print("Final accumulator value before infinite: {}".format(accumulator))
