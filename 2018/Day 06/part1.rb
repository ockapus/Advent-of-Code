# Advent of Code 2018, Day 6
# Part 1: Largest patch

points = []
max_x = 0
max_y = 0
File.open("day06_input.txt").each do |line|
    raw = line.chomp.split(', ')
    points << { x: raw[0].to_i, y: raw[1].to_i }
    max_x = raw[0].to_i if raw[0].to_i > max_x
    max_y = raw[1].to_i if raw[1].to_i > max_y
end

# First, initialize our grid based on the max x and y values we got for points
grid = Array.new(max_x + 1) { Array.new(max_y + 1) }

# Now run through the entire grid, and for each space, determine distance from each point
# If it's closer to that point than any other, list that point and the distance
# If we find an identical distance, then set to a dummy value
grid.each_with_index do |column, x|
    column.each_index do |y|
        space = { distance: -1, closest: nil }
        points.each_with_index do |point, p|
            distance = (x - point[:x]).abs + (y - point[:y]).abs
            if space[:distance] == distance
                space[:closest] = -1
            elsif space[:distance] > distance || space[:distance] == -1
                space[:distance] = distance
                space[:closest] = p
            end
        end
        grid[x][y] = space
    end
end

# Now run through the whole grid again, and count up the size of each patch
# while also keeping a list of patches that touch the border, and thus are 
# disqualified for being infinite
patches = Array.new(points.length, 0)
infinite = Array.new(points.length, false)
grid.each_with_index do |column, x|
    column.each_with_index do |space, y|
        patches[space[:closest]] += 1
        if x == 0 || y == 0 || x == max_x || y == max_y
            infinite[space[:closest]] = true
        end
    end
end

largest = 0
patches.each_with_index do |patch, i|
    if patch > largest && infinite[i] == false
        largest = patch
    end
end

puts "Largest non-infinite patch: " + largest.to_s