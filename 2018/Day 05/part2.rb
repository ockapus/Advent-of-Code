# Advent of Code 2018, Day 5
# Part 2: Shortest stable polymer

polymer = nil
File.open("day05_input.txt").each do |line|
    # We should just have a single line of input, for this problem
    polymer = line.chomp
end

# First, convert the polymer to an array of bytes so it's easier to collapse as we process
poly_array = polymer.bytes

# This time, we're going to arbitrarily remove a unit (letter), then see which is the shortest
# So: set up an array to keep track of our lengths
polymer_length = []

# And now loop for each letter of the alphabet, and make a deep copy of our original array with
# that letter (both lower and upper case) removed
(0..25).each do |char|
    clone = Marshal.load(Marshal.dump(poly_array))
    filtered = clone.reject { |a| a == char + 65 || a == char + 97}
    reaction = false
    index = 0

    # Now loop until we don't have a reaction (we have compressed the polymer as much as possible)
    while true
        # If we reach the end, and we had no reaction, we're done
        # Otherwise, reset to the beginning and start checking again
        if index >= filtered.length - 1
            if !reaction
                break
            else
                index = 0
                reaction = false
            end
        end

        if (filtered[index] - filtered[index + 1]).abs == 32
            filtered.delete_at(index)
            filtered.delete_at(index)
            reaction = true
        else
            index += 1
        end
    end

    polymer_length[char] = filtered.length
end

puts "Length of shortest stable polymer: " + polymer_length.min.to_s