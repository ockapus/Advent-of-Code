'''
    Advent of Code 2020
    Day 4, Part 1
    Passport Validation (required field check)
'''

# Import data
with open('Day 04/day04_input.txt') as file:
    data = [line.strip() for line in file]
# Add a final blank line for the last passport
data.append('')

# Process through data to find valid passports
valid_passports = 0
required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
optional_fields = ['cid']
passport = {}
for row in data:
    if row == '':
        # Validate passport, and increment count as needed
        valid = True
        for req in required_fields:
            if req not in passport.keys():
                valid = False
                break
        if valid:
            valid_passports += 1
        # Either way, clear for new passport
        passport = {}
    else:
        # Add data to current passport for eventual validation
        pairs = row.split(' ')
        for p in pairs:
            (key, value) = p.split(':')
            passport[key] = value

print("Valid passports: {}".format(valid_passports))