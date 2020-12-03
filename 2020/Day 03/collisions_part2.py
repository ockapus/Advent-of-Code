'''
    Advent of Code 2020
    Day 3, Part 2
    Toboggan Run Collision check, multiple routes
'''

# Import data
with open('Day 03/day03_input.txt') as file:
    data = [line.strip() for line in file]

# Now initialize our toboggan possibilites
slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
collisions = [0] * len(slopes)
width = len(data[0])

# Do a run for every slope option we have
for run in range(0, len(slopes)):
    right = column = slopes[run][0]
    down = row = slopes[run][1]
    while row < len(data):
        if data[row][column] == '#':
            collisions[run] += 1
        row += down
        column = (column + right) % width

# Calculate the product for all the runs:
product = 1
for x in collisions:
    product = product * x

print("Total collisions: {}".format(collisions))
print("Product of all collisions: {}".format(product))