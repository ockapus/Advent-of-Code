'''
    Advent of Code 2020
    Day 4, Part 2
    Passport Validation (required field check, with field validation)
'''
import re

# Import data
with open('Day 04/day04_input.txt') as file:
    data = [line.strip() for line in file]
# Add a final blank line for the last passport
data.append('')

# Process through data to find valid passports
valid_passports = 0
required_fields = [
    { 'field': 'byr', 'regex': r'^\d{4}$', 'minmax': (1920, 2002) },
    { 'field': 'iyr', 'regex': r'^\d{4}$', 'minmax': (2010, 2020) },
    { 'field': 'eyr', 'regex': r'^\d{4}$', 'minmax': (2020, 2030) },
    { 'field': 'hgt', 'regex': r'^(\d+)(in|cm)$', 'hgtcheck': True },
    { 'field': 'hcl', 'regex': r'^#[a-f0-9]{6}$' },
    { 'field': 'ecl', 'regex': r'^(amb|blu|brn|gry|grn|hzl|oth)$'},
    { 'field': 'pid', 'regex': r'^\d{9}$' }
]
optional_fields = ['cid']
passport = {}
for row in data:
    if row == '':
        # Validate passport, and increment count as needed
        valid = True
        for req in required_fields:
            # We can always check the field name and for a regex
            if req['field'] not in passport.keys():
                valid = False
                break
            if not re.match(req['regex'], passport[req['field']]):
                valid = False
                break
            # Other checks are optional; see if we need to do them for this field
            if 'minmax' in req:
                value = int(passport[req['field']])
                if value < req['minmax'][0] or value > req['minmax'][1]:
                    valid = False
                    break
            if 'hgtcheck' in req:
                m = re.match(req['regex'], passport[req['field']])
                height = int(m.group(1))
                unit = m.group(2)
                if unit == 'in':
                    if height < 59 or height > 76:
                        valid = False
                        break
                else:
                    if height < 150 or height > 193:
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