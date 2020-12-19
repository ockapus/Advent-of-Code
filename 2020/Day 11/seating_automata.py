'''
    Advent of Code 2020
    Day 10, Part 1
    Seating Automata
'''

# Import data
# Doing cellular automata, we want a buffer the same size to swap between
data = []
with open('Day 11/day11_input.txt') as file:
    data.append([[char for char in line.strip()] for line in file])

rows = len(data[0])
columns = len(data[0][0])
data.append([['' for x in range(columns)] for y in range(rows)])

# Also: make a copy of the original, so we can reset to run the second pass
original = [[data[0][y][x] for x in range(columns)] for y in range(rows)]

# Define function to determine what should happen in a given cell
def iterate_cell(cell_y, cell_x, toggle):
    change = False
    if data[toggle][cell_y][cell_x] == '.':
        data[(toggle + 1) % 2][cell_y][cell_x] = '.'
    neighbors = 0
    for y in range (-1,2):
        for x in range (-1,2):
            if cell_y + y < 0 or cell_y + y >= rows:
                continue
            if cell_x + x < 0 or cell_x + x >= columns:
                continue
            if x == 0 and y == 0:
                continue
            if data[toggle][cell_y + y][cell_x + x] == '#':
                neighbors += 1
    if data[toggle][cell_y][cell_x] == '#':
        if neighbors > 3:
            change = True
            data[(toggle + 1) % 2][cell_y][cell_x] = 'L'
        else:
            data[(toggle + 1) % 2][cell_y][cell_x] = '#'
    if data[toggle][cell_y][cell_x] == 'L':
        if neighbors > 0:
            data[(toggle + 1) % 2][cell_y][cell_x] = 'L'
        else:
            change = True
            data[(toggle + 1) % 2][cell_y][cell_x] = '#'
    return change

# Ideally: should refactor so updated function could handle both steps
def updated_iterate_cell(cell_y, cell_x, toggle):
    change = False
    if data[toggle][cell_y][cell_x] == '.':
        data[(toggle + 1) % 2][cell_y][cell_x] = '.'
    neighbors = 0
    # We're not looking at adjacent seats, but who we can first see in each direction
    directions = [(-1, -1), (-1, 0), (-1, 1), (0, 1), (1, 1), (1, 0), (1, -1), (0, -1)]
    for direction in directions:
        mod_y = cell_y
        mod_x = cell_x
        done = False
        while not done:
            mod_y += direction[0]
            mod_x += direction[1]
            if mod_y < 0 or mod_y >= rows:
                done = True
            elif mod_x < 0 or mod_x >= columns:
                done = True
            elif data[toggle][mod_y][mod_x] == '#':
                neighbors += 1
                done = True
            elif data[toggle][mod_y][mod_x] == 'L':
                done = True

    if data[toggle][cell_y][cell_x] == '#':
        if neighbors > 4:
            change = True
            data[(toggle + 1) % 2][cell_y][cell_x] = 'L'
        else:
            data[(toggle + 1) % 2][cell_y][cell_x] = '#'
    if data[toggle][cell_y][cell_x] == 'L':
        if neighbors > 0:
            data[(toggle + 1) % 2][cell_y][cell_x] = 'L'
        else:
            change = True
            data[(toggle + 1) % 2][cell_y][cell_x] = '#'
    return change

def print_iteration(toggle):
    for j in range(0, rows):
        for i in range(0, columns):
            print(data[toggle][j][i], end='')
        print('\n', end='')
    print("\n")


def count_seats(toggle):
    seated = 0
    for j in range(0, rows):
        for i in range(0, columns):
            if data[toggle][j][i] == '#':
                seated += 1
    return seated


# Now: count how many iterations we have to go through until we stop making changes
iterations = 0
change_made = True
while change_made:
    change_made = False
    for j in range(0,rows):
        for i in range(0, columns):
            if iterate_cell(j, i, iterations % 2):
                change_made = True
    iterations += 1

# Count occupied seats in our final iteration:
seated = count_seats(iterations % 2)
print("part 1: {} seated at stability after {} iterations".format(seated, iterations - 1))

# Part 2: try this all again with our original data, but an updated set of rules
for j in range(0, rows):
    for i in range(0, columns):
        data[0][j][i] = original[j][i]
iterations = 0
change_made = True
while change_made:
    change_made = False
    for j in range(0, rows):
        for i in range(0, columns):
            if updated_iterate_cell(j, i, iterations % 2):
                change_made = True
    iterations += 1

# Count occupied seats in our final iteration:
seated = count_seats(iterations % 2)
print("part 2: {} seated at stability after {} iterations".format(seated, iterations - 1))
