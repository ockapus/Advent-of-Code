'''
    Advent of Code 2020
    Day 5, Part 1
    Binary Conversion
'''

def row_binary(row):
    total = 0
    invert = row[::-1]
    for x in range(7):
        if invert[x] == 'B':
            total += 2 ** x
    return total

def seat_binary(seat):
    total = 0
    invert = seat[::-1]
    for x in range(3):
        if invert[x] == 'R':
            total += 2 ** x
    return total

# Import data
with open('Day 05/day05_input.txt') as file:
    data = [line.strip() for line in file]

# Process each boarding pass
highest_id = 0
for line in data:
    row_data = line[0:7]
    seat_data = line[7:]
    row = row_binary(row_data)
    seat = seat_binary(seat_data)
    this_id = (row * 8) + seat
    highest_id = max(highest_id, this_id)

print("Highest seat ID: {}".format(highest_id))


