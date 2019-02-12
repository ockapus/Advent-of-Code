# Advent of Code 2018, Day 1
# Part 2: Find repeated frequency

frequency = 0

# First, store all the input values, since we may need to use them multiple times
input = []
File.open("day01_input.txt").each do |line|
    input << line.chomp.to_i
end

frequencies = {}
index = 0
found = false
duplicate = 0

# While we haven't found duplicate, run through input values, and tick each value we
# find in a hash. When we find a value we've already ticked, we have our duplicate.
while !found
    frequency += input[index]
    if frequencies.key?(frequency)
        found = true
        duplicate = frequency
    else
        frequencies[frequency] = 1
        index += 1
        if index == input.size
            index = 0
        end
    end
end

puts "First frequency found twice: " + duplicate.to_s