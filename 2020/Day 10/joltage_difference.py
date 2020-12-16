'''
    Advent of Code 2020
    Day 10, Part 1
    Joltage differences
'''

# Import data
with open('Day 10/day10_input.txt') as file:
    data = [int(line.strip()) for line in file]

# Part 1, we're using every cable we have
# So sort them in order, and track the differences as we work up the chain
data.sort()
previous_joltage = 0
# Since we're going to jump from the biggest voltage to the adaptor, just count that one automatically
differences = [0, 0, 1]
for d in data:
    difference = d - previous_joltage
    differences[difference - 1] += 1
    previous_joltage = d

print("Part 1: {}".format(differences[0] * differences[2]))

# Part two: calculate possible ways to create the whole chain
# Possible combinations to reach step X = sum of possible combinations to reach three previous steps (if those steps exist)
# Because all jumps have to be 1, 2, or 3 jolts
possibles = {}
possibles[0] = 1
data.append(data[-1] + 3)
for d in data:
    possibles[d] = 0
    if d - 1 in possibles:
        possibles[d] += possibles[d-1]
    if d - 2 in possibles:
        possibles[d] += possibles[d-2]
    if d - 3 in possibles:
        possibles[d] += possibles[d-3]

print("Part 2: {}".format(possibles[data[-1]]))