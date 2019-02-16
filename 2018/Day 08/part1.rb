# Advent of Code 2018, Day 8
# Part 1: Deserialize a tree

data = []
File.open("day08_input.txt").each do |line|
    # This should be a single line
    raw_data = line.chomp
    data = raw_data.split(" ")
end

metadata_total = 0
stack = []
current_node = nil
child = false
# By nature of our data stream, we know it should end with metadata for the top-level node, so:
# Loop while we still have data:
#   * If our current node is empty:
#     * See if there is anything in the stack, and pop from the top if so
#       * Only do this if we're not expecting to be dealing with a child node
#     * If not, then take the first two data items and create a new node header
#   * If we have a current node:
#     * If the child node total is > 0, decrement and push it onto the stack
#     * If we're dealt with all the child nodes:
#       * Claim all our metadata items from data, add them to running total
#       * Discard this node as finished
while data.length > 0
    if current_node == nil
        if stack.length > 0 && !child
            current_node = stack.pop
        else
            current_node = { children: data.shift.to_i, metadata: data.shift.to_i }
        end
    end
    if current_node[:children] > 0
        current_node[:children] -= 1
        stack << current_node
        current_node = nil
        child = true
    else
        (1..current_node[:metadata]).each do |i|
            metadata_total += data.shift.to_i
        end
        current_node = nil
        child = false
    end
end

puts "Metadata total: " + metadata_total.to_s