# Advent of Code 2018, Day 2
# Part 1: Simple Checksum

inventory = []
File.open("day02_input.txt").each do |line|
    inventory << line.chomp
end

doubles = 0
triples = 0

# Now that we have our inventory list, process through each label doing character counts
inventory.each do |box|
    letters = {}
    box.split('').each do |char|
        if letters.key?(char)
            letters[char] += 1
        else
            letters[char] = 1
        end
    end
    
    # now that we have processed the string, look to see if we found any characters
    # exactly two or three times. Use bool flags so we only add one per box.
    found_double = false
    found_triple = false
    letters.each do |char, count|
        if count == 2
            found_double = true
        elsif count == 3
            found_triple = true
        end
    end
    if found_double
        doubles += 1
    end
    if found_triple
        triples += 1
    end
end

# After processing everything, calculate and display checksum
puts "Checksum value: " + (doubles * triples).to_s
