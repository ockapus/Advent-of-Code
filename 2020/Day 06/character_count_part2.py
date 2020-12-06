'''
    Advent of Code 2020
    Day 6, Part 2
    Character counts, everyone answered
'''

# Import data
with open('Day 06/day06_input.txt') as file:
    data = [line.strip() for line in file]
# Add a final blank line for the last group
data.append('')

# Now process each group
group_sum = 0
group = {}
group_count = 0
for line in data:
    # If we hit a line break, then we ended a group
    if line == '':
        this_sum = 0
        for value in group.values():
            if value == group_count:
                this_sum += 1
        group_sum += this_sum
        group = {}
        group_count = 0
    else:
        group_count += 1
        for c in line:
            if c in group:
                group[c] += 1
            else:
                group[c] = 1

print ("Group sum: {}".format(group_sum))