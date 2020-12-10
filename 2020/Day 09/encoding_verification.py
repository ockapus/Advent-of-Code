'''
    Advent of Code 2020
    Day 9, Part 1 + 2
    Encoding Verification + Exploit
'''

import itertools

# Import data
with open('Day 09/day09_input.txt') as file:
    data = [int(line.strip()) for line in file]

# Now go through our data set and look for the first number that fails encoding verification
# (ie it does not add up to the sum of any two numbers in the previous 25 values)
index = 25
error = False
while not error:
    error = True
    for x, y in itertools.combinations(data[index-25:index], 2):
        if data[index] == x + y:
            error = False
            index += 1
            break

print("Value not properly encoded: {} at index {}".format(data[index], index))

# Now that we know our invalid number, find contiguous set that adds up to this number
invalid_target = data[index]
start = 0
found_set = False
while not found_set:
    end = start
    for total in itertools.accumulate(data[start:]):
        if total < invalid_target:
            end += 1
        elif total > invalid_target:
            start += 1
            break
        else:
            found_set = True
            break
 
minimum = min(data[start:end + 1])
maximum = max(data[start:end + 1])
print("Sum of Min and Max values ({} and {}) found in range [{}:{}] is {}".format(minimum, maximum, start, end + 1, minimum + maximum))