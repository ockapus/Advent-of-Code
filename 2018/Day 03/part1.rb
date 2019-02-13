# Advent of Code 2018, Day 3
# Part 1: Overlap Check

claims = []
File.open("day03_input.txt").each do |line|
    claims << line.chomp
end

fabric = []
claims.each do |claim|
    tokens = /^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/.match(claim)
    claim = tokens[1]
    x_offset = tokens[2].to_i
    y_offset = tokens[3].to_i
    width = tokens[4].to_i
    height = tokens[5].to_i

    # First loop across columns, and see if we need to add new subarrays
    (x_offset..x_offset+width-1).each do |column|
        if fabric[column] == nil
            fabric[column] = []
        end
        # Then loop across each row in that column, and set the proper value
        (y_offset..y_offset+height-1).each do |row|
            if fabric[column][row] == nil
                fabric[column][row] = claim
            else
                fabric[column][row] = 'x'
            end
        end
    end
end

# Now that we've worked out where all overlaps are, 
# loop through everything and count up our x values
overlap = 0
fabric.each do |column|
    column.each do |row|
        if row == 'x'
            overlap += 1
        end
    end
end

puts "Total overlap: " + overlap.to_s
