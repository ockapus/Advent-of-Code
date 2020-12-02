'''
    Advent of Code 2020
    Day 1, Part 1
'''

# Import data, and sort list
with open('Day 01/day01_input.txt') as file:
    data = [int(line.strip()) for line in file]
data.sort(reverse=True)

# Set up two index pointers, and start comparing high/low values until we find 2020
top_index = 0
bottom_index = len(data) - 1
total = 2020
found = False
while not found:
    target = total - data[top_index]
    if data[bottom_index] == target:
        print("Found values: {} and {}, multiply to {}".format(data[top_index], data[bottom_index], data[top_index] * data[bottom_index]))
        found = True
    elif data[bottom_index] < target:
        bottom_index -= 1
    else:
        top_index += 1
    if bottom_index == top_index:
        print("No pair equaling total found")
        found = True