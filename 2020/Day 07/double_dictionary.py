'''
    Advent of Code 2020
    Day 7, Part 1 and 2
    Double Dictionary (rules parsing)
'''

import re

def total_bags(outer_bag):
    if outer_bag in contains:
        total = 1
        for inner_bag, count in contains[outer_bag].items():
            total += count * total_bags(inner_bag)
        return total
    else:
        # If there are no bag rules for inside our bag, just return the bag itself
        return 1

# Import data
with open('Day 07/day07_input.txt') as file:
    data = [line.strip() for line in file]

# Create two related dictionaries, to parse our rules into
contained_by = {}
contains = {}
for rule in data:
    this_contains = {}
    (new_bag, definition) = rule.split(' bags contain ')
    if definition != 'no other bags.':
        tokens = definition.split(', ')
        for t in tokens:
            m = re.match(r'^(\d+) (.+) bag', t)
            bag_count = int(m.group(1))
            bag_type = m.group(2)
            this_contains[bag_type] = bag_count
            if bag_type in contained_by:
                contained_by[bag_type].append(new_bag)
            else:
                contained_by[bag_type] = [new_bag]
        contains[new_bag] = this_contains

# After parsing all the rules, see who can contain 'shiny gold'
target_bag = 'shiny gold'
count = 0
bag_options = []
bag_options.extend(contained_by[target_bag])
seen = {}
while len(bag_options) > 0:
    current_bag = bag_options.pop(0)
    if current_bag in seen:
        continue
    count += 1
    seen[current_bag] = 1
    if current_bag in contained_by:
        bag_options.extend(contained_by[current_bag])

# Now see how many bags are inside your shiny gold
# Our function counts the bag that holds the other bags, but in this case, we don't WANT to include the shiny bag
total_inside = total_bags(target_bag) - 1

print("Part 1: bags that can hold a {} = {}".format(target_bag, count))

print("Part 2: total bags inside {} = {}".format(target_bag, total_inside))