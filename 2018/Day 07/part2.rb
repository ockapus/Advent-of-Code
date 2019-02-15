# Advent of Code 2018, Day 7
# Part 2: Instruction Order, multiple workers and time

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

# Set up our five workers, our time constant, and our count for how long assembly takes
base_time = 60
step_adjust = "A".ord - 1  # This way, if we subtract step_adjust from the step label.ord, we get 1-26
time_passed = -1
workers = []
(0..4).each do |w|
    worker = { current_step: nil, time_left: 0 }
    workers << worker
end

# Now, while we are not finished:
# * Tick our time forward by one
# * Loop through all workers
#   * If that worker is holding a step, decrement our time by 1
#   * If time_left == 0, we've finished:
#     * Add this step to the correct order
#     * Go through remaining prereqs, and remove it
#     * Reset this worker so they can work again
#   * If worker is not holding a step, look to see if there is a
#     new step to pick up that has no prereqs
#     * If yes, add to worker and remove from queue
#   * Once all five workers end a loop idle, we much be finished 
correct_order = []
finished = false

while !finished
    time_passed += 1
    working = 0
    workers.each do |w|
        if w[:current_step] != nil
            w[:time_left] -= 1
            if w[:time_left] == 0
                correct_order << w[:current_step]
                prerequisites.each do |step, prereqs|
                    prereqs.delete_at(prereqs.index(w[:current_step])) if prereqs.index(w[:current_step])
                end
                w[:current_step] = nil
            else
                working += 1
            end
        end
    end

    # We need to do two separate loops here; otherwise, if worker 5 finishes a step
    # that frees up multiple other steps, all but one will be delayed an unnecessary second
    workers.each do |w|
        if w[:current_step] == nil
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
            if next_instruction != nil
                w[:current_step] = next_instruction
                prerequisites.delete(next_instruction)
                w[:time_left] = base_time + next_instruction.ord - step_adjust
                working += 1
            end
        end
    end
    if working == 0
        finished = true
    end
end

puts "Final instruction order: " + correct_order.join('')
puts "Final assembly time: " + time_passed.to_s