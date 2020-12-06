'''
    Advent of Code 2020
    Day 6, Part 1
    Character counts
'''

# Import data
with open('Day 06/day06_input.txt') as file:
    data = [line.strip() for line in file]
# Add a final blank line for the last group
data.append('')

# Now process each group
group_sum = 0
group = {}
for line in data:
    # If we hit a line break, then we ended a group
    if line == '':
        group_sum += len(group.keys())
        group = {}
    else:
        for c in line:
            if c in group:
                group[c] += 1
            else:
                group[c] = 1

print ("Group sum: {}".format(group_sum))