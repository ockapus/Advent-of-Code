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
(1..last_marble).each do |next_marble|
    if next_marble % 23 == 0
        if !scores.key?(current_player)
            scores[current_player] = 0
        end
        scores[current_player] += next_marble
        board.rotate!(-7)
        scores[current_player] += board.pop
        board.rotate!
    else
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