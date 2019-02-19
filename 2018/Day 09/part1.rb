# Advent of Code 2018, Day 9
# Part 1: Marble Game

players = nil
last_marble = nil
File.open("day09_input.txt").each do |line|
    tokens = /^(\d+) players; last marble is worth (\d+) points$/.match(line.chomp)
    players = tokens[1].to_i
    last_marble = tokens[2].to_i
end

board = [0]
scores = {}
current_player = 1

# We're going to take advantage of the rotate function, and treat our array as a big loop
(1..last_marble).each do |next_marble|
    if next_marble % 23 == 0
        # Initialize if this is the first time this player has scored
        if !scores.key?(current_player)
            scores[current_player] = 0
        end
        # Add this marble to score rather than to the board
        scores[current_player] += next_marble
        # Rotate backwards so we can take the last marble for scoring as well
        board.rotate!(-7)
        scores[current_player] += board.pop
        # Then shift to properly line up our new 'current' marble, per the rules
        board.rotate!
    else
        # Handling things this way, our 'current marble' is always the end of the array
        board.rotate!
        board << next_marble
    end
    current_player += 1
    current_player = 1 if current_player > players
end

high_score = 0
winner = nil
scores.each do |player, score|
    if score > high_score
        winner = player
        high_score = score
    end
end

puts "Elf " + winner.to_s + ' won with a score of ' + high_score.to_s