# Advent of Code 2018, Day 4
# Part 1: Sorting the Schedule

entries = []
File.open("day04_input.txt").each do |line|
    entries << line.chomp
end

# Sort by the timestamps before processing
entries.sort_by! { |line| line.scan(/\d{4}-\d{2}-\d{2} \d{2}:\d{2}/)[0] }

# Now process entries in order. We don't care about the actual days
# except as a marker that we've got a new set of entries, so we're just
# going to mark up total times each guard is asleep for a minute during
# the midnight hour
guards = {}
awake = true
last_change = 0
current_guard = 0
entries.each do |entry|
    tokens = /^\[\d{4}-\d{2}-\d{2} \d{2}:(\d{2})\] (.*)$/.match(entry)
    minute = tokens[1].to_i
    event = tokens[2]

    if event == 'falls asleep'
        awake = false
        last_change = minute
    elsif event == 'wakes up'
        awake = true
        (last_change..minute-1).each do |m|
            guards[current_guard][m] += 1
        end
    else
        current_guard = /^Guard #(\d+) begins shift/.match(event)[1]
        if !guards.key?(current_guard)
            guards[current_guard] = Array.new(60, 0)
        end
    end
end

worst_guard = nil
worst_minute = nil
worst_time = -1
guards.each do |guard, minutes|
    if minutes.reduce(0, :+) > worst_time
        worst_guard = guard
        worst_time = minutes.reduce(0, :+)
        worst_minute = minutes.index(minutes.max)
    end
end

puts "Guard ID times worst minute: " + worst_guard + 'x' + worst_minute.to_s + ' = ' + (worst_guard.to_i * worst_minute).to_s