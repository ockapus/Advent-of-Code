# Advent of Code 2018, Day 8
# Part 2: Deserialize a tree, with extra processing

data = []
File.open("day08_input.txt").each do |line|
    # This should be a single line
    raw_data = line.chomp
    data = raw_data.split(" ")
end

stack = []
current_node = nil
parent_node = nil
child = false
last_metadata_total = 0
# By nature of our data stream, we know it should end with metadata for the top-level node, so:
# Loop while we still have data:
#   * If our current node is empty:
#     * See if there is anything in the stack, and pop from the top if so
#       * Only do this if we're not expecting to be dealing with a child node
#     * If not, then take the first two data items and create a new node header
#       * Keep track of the parent node for each child, so we can pass back up metadata totals
#   * If we have a current node:
#     * If the child node total is > 0, decrement and push it onto the stack
#     * If we're dealt with all the child nodes:
#       * If we had children, process our metadata as indicies against the child nodes
#       * If we had no children, all up our raw metadata values
#       * Either way, pass this total up to store in the parent node
#       * Discard this node as finished
while data.length > 0
    if current_node == nil
        if stack.length > 0 && !child
            current_node = stack.pop
        else
            current_node = { 
                children: data.shift.to_i, 
                metadata: data.shift.to_i, 
                parent_node: parent_node,
                child_meta: Array.new()
            }
        end
    end
    if current_node[:children] > 0
        current_node[:children] -= 1
        stack << current_node
        parent_node = current_node
        current_node = nil
        child = true
    else
        metadata_total = 0
        (1..current_node[:metadata]).each do |i|
            if current_node[:child_meta].length == 0
                metadata_total += data.shift.to_i
            else
                index = data.shift.to_i
                if index <= current_node[:child_meta].length
                    metadata_total += current_node[:child_meta][index - 1]
                end
            end
        end
        current_node[:parent_node][:child_meta] << metadata_total if current_node[:parent_node]
        last_metadata_total = metadata_total
        current_node = nil
        child = false
    end
end

puts "Metadata total for top node: " + last_metadata_total.to_s