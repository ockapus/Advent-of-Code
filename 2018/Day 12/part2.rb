# Advent of Code 2018, Day 12
# Part 2: Life, of a sort, with pattern hunting

def state_to_pattern(state)
    start = state.min
    finish = state.max
    pattern = ''
    (start..finish).each do |i|
        if state.include?(i)
            pattern += '#'
        else
            pattern += '.'
        end
    end
    return pattern
end

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

# Keep running until we find a duplicated pattern of pots; 
# This should mean we've hit a stable point of growth and can calculate from there
total_generations = 50000000000
previous_generations = [state_to_pattern(state)]
previous_score = [state.reduce(:+)]
stable = false
generation = 1
match_at = nil

while !stable
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
    pattern = state_to_pattern(state)
    if previous_generations.include?(pattern)
        stable = true
        match_at = previous_generations.index(pattern)
    else
        previous_generations << pattern
        previous_score << state.reduce(:+)
        generation += 1
    end
end

remaining = total_generations - generation
diff = state.reduce(:+) - previous_score[match_at]
mult = generation - match_at
# This isn't perfect, since we should make sure there's no
# remainder here -- but in our case, testing proved the multiplier was 1
final = (remaining / mult) * diff + state.reduce(:+)

puts "Final score: " + final.to_s