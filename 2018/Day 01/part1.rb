# Advent of Code 2018, Day 1
# Part 1: Calculate Frequency Drift

frequency = 0

File.open("day01_input.txt").each do |line|
    drift = line.chomp.to_i
    frequency += drift
end

puts "Final frequency: " + frequency.to_s