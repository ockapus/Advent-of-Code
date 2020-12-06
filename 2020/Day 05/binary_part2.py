'''
    Advent of Code 2020
    Day 5, Part 2
    Binary Conversion, find missing seat
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
lowest_id = 9999
taken_seats = {}
for line in data:
    row_data = line[0:7]
    seat_data = line[7:]
    row = row_binary(row_data)
    seat = seat_binary(seat_data)
    this_id = (row * 8) + seat
    highest_id = max(highest_id, this_id)
    lowest_id = min(lowest_id, this_id)
    taken_seats[this_id] = True

# Now we go through the range between lowest and highest ids, and look for what's still not taken
for x in range(lowest_id + 1, highest_id):
    if x not in taken_seats.keys():
        print("Empty seat: {}".format(x))
        break

