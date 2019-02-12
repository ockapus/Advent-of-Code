# Advent of Code 2018, Day 2
# Part 2: String Compares

inventory = []
File.open("day02_input.txt").each do |line|
    inventory << line.chomp
end

# Nested loops: compare each box in order to every other box
main_box = 0
test_box = 1
found = false
while !found
    delta = 0
    difference = -1
    main_array = inventory[main_box].split('')
    test_array = inventory[test_box].split('')
    main_array.each_with_index do |char, index|
        if char != test_array[index]
            delta += 1
            difference = index 
            break if delta > 2
        end
    end

    # If we're here, then we found the two boxes that are off by one character
    if delta == 1
        found = true
        common = main_array.slice(0, difference).join('') + main_array.slice(difference + 1, main_array.length).join('')
        puts "Common characters: " + common

    # Otherwise, we need to compare the next pair of boxes. Also make sure we skip
    # comparisons we've already done, and fail clean if we run out of boxes to compare
    else
        test_box += 1
        if test_box == inventory.length
            main_box += 1
            test_box = main_box + 1
            if main_box == inventory.length
                puts "Error: no similar boxes found"
                break
            end
        end
    end
end
