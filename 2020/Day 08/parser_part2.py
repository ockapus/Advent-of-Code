'''
    Advent of Code 2020
    Day 8, Part 2
    Instruction parsing + debugging
'''

import re

# Import data
with open('Day 08/day08_input.txt') as file:
    data = [line.strip() for line in file]

# We're going to try swapping nop/jmp instructions one by one until we find a run that finishes
correct_ending = len(data)
line_swap = 0
fixed = False
# Initialize this run, and start keeping track of what instructions we've been to
while not fixed:
    executed = []
    pointer = 0
    accumulator = 0
    while True:
        if pointer in executed:
            line_swap += 1
            break
        if pointer == correct_ending:
            fixed = True
            break
        executed.append(pointer)
        m = re.match(r'^(\w{3}) ([+|-]\d+)$', data[pointer])
        operation = m.group(1)
        value = int(m.group(2))
        # Swap nop/jmp if we are testing a fix for this line
        if pointer == line_swap:
            if operation == 'nop':
                operation = 'jmp'
            elif operation == 'jmp':
                operation = 'nop'
        if operation == 'nop':
            pointer += 1
        elif operation == 'acc':
            accumulator += value
            pointer += 1
        elif operation == 'jmp':
            pointer += value

print("Final accumulator value after completion: {}".format(accumulator))
