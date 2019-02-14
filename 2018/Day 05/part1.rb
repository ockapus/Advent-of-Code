# Advent of Code 2018, Day 5
# Part 1: Stable polymer

polymer = nil
File.open("day05_input.txt").each do |line|
    # We should just have a single line of input, for this problem
    polymer = line.chomp
end

# First, convert the polymer to an array of bytes so it's easier to collapse as we process
poly_array = polymer.bytes
reaction = false
index = 0

# Now loop until we don't have a reaction (we have compressed the polymer as much as possible)
while true
    # If we reach the end, and we had no reaction, we're done
    # Otherwise, reset to the beginning and start checking again
    if index >= poly_array.length - 1
        if !reaction
            break
        else
            index = 0
            reaction = false
        end
    end

    if (poly_array[index] - poly_array[index + 1]).abs == 32
        poly_array.delete_at(index)
        poly_array.delete_at(index)
        reaction = true
    else
        index += 1
    end
end

puts "Length of stable polymer: " + poly_array.length.to_s