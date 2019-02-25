# Advent of Code 2018, Day 14
# Part 2: Chocolate Charts, redux

scoreboard = [3, 7]
current = [0, 1]
# From my puzzle input
recipe_target = [5, 1, 3, 4, 0, 1]

# There is probably cleaner logic, but this works
# Also: if language optimized right for the right data structure, 
# even simpler to just check the whole end of the array against the target
# (Python supposedly can do this fast); attempting in ruby turns into an 
# O(n^2) problem which is just painful, hence this more complicated implementation
start = nil
len = 0
loop do
    # First: create new recipes
    # Keep track of length for our testing step
    new_recipe = scoreboard[current[0]] + scoreboard[current[1]]
    (scoreboard << new_recipe / 10) if new_recipe > 9
    scoreboard << new_recipe % 10

    # Then: update current recipe
    current[0] = (current[0] + scoreboard[current[0]] + 1) % scoreboard.length
    current[1] = (current[1] + scoreboard[current[1]] + 1) % scoreboard.length
    
    # See if we've found our target; we may need to check last two numbers
    if new_recipe < 10
        if scoreboard.last == recipe_target[len]
            len += 1
            start = scoreboard.size - 1 if start.nil?
            break if len == recipe_target.size
        else
            len = 0
            start = nil
        end
    else
        to_check = scoreboard.last(2)
        # Either way, start by checking digit #1 against our current 'not confirmed' target
        if to_check[0] == recipe_target[len]
            len += 1
            start = scoreboard.size - 1 if start.nil?
            break if len == recipe_target.size
            # If we got a match for digit #1, but haven't found the whole number,
            # then we need to confirm digit #2 was a match as well
            if to_check[1] == recipe_target[len]
                len += 1
                start = scoreboard.size - 1 if start.nil?
                break if len == recipe_target.size
            else
                len = 0
                start = nil
            end
            
        # If digit #1 didn't match, but we haven't see a match yet? Then check digit 2
        elsif start.nil? && to_check[1] == recipe_target[len]
            len += 1
            start = scoreboard.size - 1 if start.nil?
            break if len == recipe_target.size
        else
            len = 0
            start = nil
        end
    end
end

# If we're done, print out how many recipes we tried to find the target
puts "Recipes to find target: " + start.to_s