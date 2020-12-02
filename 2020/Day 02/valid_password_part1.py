'''
    Advent of Code 2020
    Day 2, Part 1
    Validate Passwords
'''

# Import data
with open('Day 02/day02_input.txt') as file:
    data = [line.strip() for line in file]

# Now process each password and determine whether or not it is valid based on included rules
# For Part 1: character count must be between min and max
valid = 0
for entry in data:
    tokens = entry.split(' ')
    minmax = tokens[0].split('-')
    min = int(minmax[0])
    max = int(minmax[1])
    character = tokens[1].split(':')[0]
    password = tokens[2]
    count = 0
    for char in password:
        if char == character:
            count += 1
    if count >= min and count <= max:
        valid += 1

print("Found {} valid passwords".format(valid))