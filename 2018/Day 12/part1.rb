# Advent of Code 2018, Day 12
# Part 1: Life, of a sort

state = []
recipes = []
File.open("day12_input.txt").each do |line|
    if line.chomp =~ /^initial state/
        raw_state = /^initial state: (.+)$/.match(line.chomp)[1]
        raw_state.split('').each_with_index do |pot, i|
            if pot == '#'
                state << i
            end
        end
    elsif line.chomp =~ /^([\.\#]+) => ([\.\#])$/
        tokens = /^([\.\#]+) => ([\.\#])$/.match(line.chomp)
        # We really only care if we're going to generate a planted pot,
        # so store just the 'positive' recipes
        if tokens[2] == '#'
            recipes << tokens[1]
        end
    end
end

(1..20).each do |generation|
    new_state = []
    start = state.min - 2
    finish = state.max + 2
    (start..finish).each do |index|
        check = ''
        (index-2..index+2).each do |i|
            if state.include?(i)
                check << '#'
            else
                check << '.'
            end
        end
        if recipes.include?(check)
            new_state << index
        end
    end
    state = new_state
end

puts "Total after 20 generations: " + state.reduce(:+).to_s