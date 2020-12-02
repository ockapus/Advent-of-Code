'''
    Advent of Code 2020
    Day 1, Part 2
'''
import itertools

# Import data, and sort list
with open('Day 01/day01_input.txt') as file:
    data = [int(line.strip()) for line in file]
data.sort(reverse=True)

# Look for three numbers that add up to our target total
# Once we find it, give us our product of the three numbers
target = 2020
for x, y, z in itertools.combinations(data, 3):
    sum = x + y + z
    if sum == target:
        product = x * y * z
        print("{} + {} + {} = 2020; Product: {}".format(x, y, z, product))
        break