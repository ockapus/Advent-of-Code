'''
    Advent of Code 2020
    Day 3, Part 1
    Toboggan Run Collision check
'''

# Import data
with open('Day 03/day03_input.txt') as file:
    data = [line.strip() for line in file]

# Now initialize our toboggan run
right = 3
down = 1
collisions = 0
column = right
row = down
width = len(data[0])
while row < len(data):
    if data[row][column] == '#':
        collisions += 1
    row += down
    column = (column + right) % width

print("Total collisions: {}".format(collisions))