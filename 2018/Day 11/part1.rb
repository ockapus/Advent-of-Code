# Advent of Code 2018, Day 11
# Part 1: Best Subgrid

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

# Now go through and figure out the best 3x3 subsection
best_total = 0
best_x = 0
best_y = 0
# We're never going to get closer than two away from the far edge
(0..297).each do |y|
    (0..297).each do |x|
        total = 0
        (0..2).each do |w|
            (0..2).each do |h|
                total += grid[y+w][x+h]
            end
        end
        if total > best_total
            best_total = total
            best_x = x
            best_y = y
        end
    end
end

puts "Best power total: " + best_total.to_s
puts "X, Y: " + (best_x + 1).to_s + ', ' + (best_y + 1).to_s