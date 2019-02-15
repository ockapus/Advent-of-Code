# Advent of Code 2018, Day 7
# Part 1: Instruction Order

prerequisites = {}
File.open("day07_input.txt").each do |line|
    order = line.chomp
    tokens = /^Step (\w) must be finished before step (\w) can begin\.$/.match(order)
    # See if we need to initialize for the new step(s)
    if !prerequisites.key?(tokens[1])
        prerequisites[tokens[1]] = []
    end
    if !prerequisites.key?(tokens[2])
        prerequisites[tokens[2]] = []
    end
    # Now add the new prereq to the relevant list
    prerequisites[tokens[2]] << tokens[1]
end

correct_order = []
while prerequisites.keys.length > 0
    next_instruction = nil
    # look through all our remaining steps, and look at the ones
    # with no more prerequisites for the earliest one alphabetically
    prerequisites.each do |step, prereqs|
        if prereqs.length == 0
            if next_instruction == nil || step < next_instruction
                next_instruction = step
            end
        end
    end

    # Once we have our next instruction, add it to the list, then
    # remove it from all the remaining prereq lists, as well as the
    # primary remaining step list
    correct_order << next_instruction
    prerequisites.delete(next_instruction)
    prerequisites.each do |step, prereqs|
        prereqs.delete_at(prereqs.index(next_instruction)) if prereqs.index(next_instruction)
    end
end

puts "Final instruction order: " + correct_order.join('')