# Advent of Code 2018, Day 3
# Part 2: Overlap Check Redux - find the patch that's intact

claims = []
File.open("day03_input.txt").each do |line|
    claims << line.chomp
end

fabric = []
patch = []
claims.each do |claim|
    tokens = /^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/.match(claim)
    claim = tokens[1]
    x_offset = tokens[2].to_i
    y_offset = tokens[3].to_i
    width = tokens[4].to_i
    height = tokens[5].to_i
    # Track whether we end up overlapping an existing patch
    clean = true

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
                # If we hit a row we've filled in before, then take that patch
                # off the clean list, and make sure we don't add this one.
                clean = false
                to_remove = patch.index(fabric[column][row])
                if to_remove
                    patch.delete_at(to_remove)
                end
                fabric[column][row] = 'x'
            end
        end
    end
    if clean
        patch << claim
    end
end

# At this point, we should have a single value in patch, so print it out
puts "Clean patch: " + patch[0]
