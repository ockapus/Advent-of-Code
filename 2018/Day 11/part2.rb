# Advent of Code 2018, Day 11
# Part 2: Best Subgrid, flexible size (summed area table)

serial_number = 7139

# First, calculate the full power grid
grid = Array.new(300){ Array.new(300) }
(0..299).each do |y|
    (0..299).each do |x|
        # Rack ID = X + 10 (and +1, because we're offset by starting at 0)
        rack_id = x + 11
        # Power level initialized at rack ID * Y
        power = rack_id * (y + 1)
        # Add the grid serial number (the puzzle input)
        power += serial_number
        # Multiply by the rack ID
        power *= rack_id
        # Now keep the hundreds digit
        power = (power / 100) % 10
        # Then subtract 5
        power -= 5
        grid[y][x] = power
    end
end

# Next, generate the summed table
summed = Array.new(300){ Array.new(300) }
(0..299).each do |y|
    (0..299).each do |x|
        summed[y][x] = grid[y][x]
        if y > 0
            summed[y][x] += summed[y-1][x]
        end
        if x > 0
            summed[y][x] += summed[y][x-1]
        end
        if y > 0 && x > 0
            summed[y][x] -= summed[y-1][x-1]
        end
    end
end

# Now go through and figure out the best subsection
best_total = 0
best_size = 0
best_x = 0
best_y = 0
(0..299).each do |size|
    (0..299-size).each do |y|
        (0..299-size).each do |x|
            total = summed[y + size][x + size]
            # Make sure what we're adding or subtracting from our total is still inside bounds
            # (so if we're along an edge, we're not doing math we don't need)
            if x > 0 && y > 0
                total += summed[y - 1][x - 1]
            end
            if x > 0
                total -= summed[y + size][x - 1]
            end
            if y > 0
                total -= summed[y - 1][x + size]
            end
            if total > best_total
                best_total = total
                best_size = size
                best_x = x
                best_y = y
            end
        end
    end
end

puts "Best power total: " + best_total.to_s
puts "X, Y, size: " + (best_x + 1).to_s + ', ' + (best_y + 1).to_s + ', ' + (best_size + 1).to_s 