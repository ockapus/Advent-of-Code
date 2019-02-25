# Advent of Code 2018, Day 14
# Part 1: Chocolate Charts

scoreboard = "37"
current = [0, 1]
# From my puzzle input
recipe_seed = 513401

while scoreboard.length < recipe_seed + 10
    # First: create new recipes
    scoreboard += (scoreboard[current[0]].to_i + scoreboard[current[1]].to_i).to_s
    # Then: update current recipe
    current[0] = (current[0] + scoreboard[current[0]].to_i + 1) % scoreboard.length
    current[1] = (current[1] + scoreboard[current[1]].to_i + 1) % scoreboard.length
end

# If we're done, print out the ten scores after our seed
puts scoreboard[recipe_seed, 10]
