'''
    Advent of Code 2020
    Day 2, Part 2
    Validate Passwords
'''

# Import data
with open('Day 02/day02_input.txt') as file:
    data = [line.strip() for line in file]

# Now process each password and determine whether or not it is valid based on included rules
# For Part 2: Character must be found in only one of two listed positions
valid = 0
for entry in data:
    tokens = entry.split(' ')
    minmax = tokens[0].split('-')
    min = int(minmax[0]) - 1
    max = int(minmax[1]) - 1
    character = tokens[1].split(':')[0]
    password = tokens[2]
    count = 0
    if password[min] == character:
        count += 1
    if password[max] == character:
        count += 1
    if count == 1:
        valid += 1

print("Found {} valid passwords".format(valid))