# Advent of Code 2018, Day 10
# Part 1 & 2: Points in motion, and the time

points = []
File.open("day10_input.txt").each do |line|
    tokens = /^position=<(.+), (.+)> velocity=<(.+), (.+)>$/.match(line.chomp)
    point = {
        initial: {
            x: tokens[1].to_i,
            y: tokens[2].to_i
        },
        velocity: {
            x: tokens[3].to_i,
            y: tokens[4].to_i
        }
    }
    points << point
end

smallest_box = nil
best_time = nil
# Run through a chunk of time, and see if we can figure out when all the points
# are in the tightest configuration, and thus most likely to be spelling something out
(0..20000).each do |time|
    min_x = points.map { |p| p[:initial][:x] + p[:velocity][:x] * time }.min
    max_x = points.map { |p| p[:initial][:x] + p[:velocity][:x] * time }.max
    min_y = points.map { |p| p[:initial][:y] + p[:velocity][:y] * time }.min
    max_y = points.map { |p| p[:initial][:y] + p[:velocity][:y] * time }.max
    box_size = (max_x-min_x).abs * (max_y - min_y).abs
    if smallest_box == nil || box_size < smallest_box
        smallest_box = box_size
        best_time = time
    end
end

# Print out the position of points at that best time
min_x = points.map { |p| p[:initial][:x] + p[:velocity][:x] * best_time }.min
max_x = points.map { |p| p[:initial][:x] + p[:velocity][:x] * best_time }.max
min_y = points.map { |p| p[:initial][:y] + p[:velocity][:y] * best_time }.min
max_y = points.map { |p| p[:initial][:y] + p[:velocity][:y] * best_time }.max
width = (max_x - min_x).abs + 1
height = (max_y - min_y).abs + 1
display = Array.new(height){Array.new(width, '.')}
points.each do |p|
    x = (p[:initial][:x] + p[:velocity][:x] * best_time) - min_x
    y = (p[:initial][:y] + p[:velocity][:y] * best_time) - min_y
    display[y][x] = '#'
end
display.each do |row|
    row.each do |column|
        print column
    end
    puts ''
end

puts "Smallest box: " + smallest_box.to_s + " | Best time: " + best_time.to_s

