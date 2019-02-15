# Advent of Code 2018, Day 6
# Part 2: Centralized Patch

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

safe_limit = 10000
patch_size = 0
# Now run through the entire grid, and for each space, determine distance from each point
# Add up those distances, and if it's less than the safe limit, that square is in the 
# region we want to know the size of
grid.each_with_index do |column, x|
    column.each_index do |y|
        total = 0
        points.each_with_index do |point, p|
            distance = (x - point[:x]).abs + (y - point[:y]).abs
            total += distance
        end
        if total < safe_limit
            patch_size += 1
        end
    end
end

puts "Safe patch: " + patch_size.to_s