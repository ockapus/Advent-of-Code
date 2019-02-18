# Advent of Code 2018, Day 9
# Part 2: Marble Game, x100

players = nil
last_marble = nil
File.open("day09_input.txt").each do |line|
    tokens = /^(\d+) players; last marble is worth (\d+) points$/.match(line.chomp)
    players = tokens[1].to_i
    last_marble = tokens[2].to_i
end

# Everything's the same, but with a lot more marbles
last_marble = last_marble * 100
scores = {}
current_player = 1

# As we go extra big, though, we run into slowdown issues; array functions are
# O(n), which means the bigger the array gets, the longer everything (insert, rotating)
# takes to do. Ideally, we want something a lot faster, so instead of setting the board
# up as an array, let's try instead to set up a circular linked list.
class Node
    attr_accessor :next, :prev
    attr_reader   :value

    def initialize(value)
        @value = value
        @next = nil
        @prev = nil
    end

    def to_s
        "Node with value: #{@value}"
    end
end

class CircularList
    def initialize
        @current = nil
    end

    def insert(value)
        if @head
            new_node = Node.new(value)
            new_node.prev = @head
            new_node.next = @head.next
            @head.next.prev = new_node
            @head.next = new_node
            @head = new_node
        else
            @head = Node.new(value)
            @head.next = @head
            @head.prev = @head
        end
    end

    def remove
        node = @head
        @head.prev.next = @head.next
        @head.next.prev = @head.prev
        # Node after the one we just removed becomes new head/current
        @head = node.next
        return node
    end

    def rotate(distance = 1)
        if distance > 0
            (1..distance).each do
                @head = @head.next
            end
        elsif distance < 0
            (1..distance.abs).each do
                @head = @head.prev
            end
        end
    end

    def debug
        print '['
        current = @head
        finish = @head.prev
        while current
            print current.value.to_s
            if current != finish
                print ', '
                current = current.next
            else
                current = nil
            end
        end
        puts ']'
    end
end

# Initialize our CircularList board
board = CircularList.new
board.insert(0)


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
        board.rotate(-7)
        scores[current_player] += board.remove.value
        # board.debug
    else
        # Move forward one, insert new marble after this marble; new marble becomes current
        board.rotate
        board.insert(next_marble)
        # board.debug
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