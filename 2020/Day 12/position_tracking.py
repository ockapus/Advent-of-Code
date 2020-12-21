'''
    Advent of Code 2020
    Day 12, Part 1 + 2
    Position Tracking
'''

# Import data
with open('Day 12/day12_input.txt') as file:
    data = [line.strip() for line in file]

# Initialize our position, and how we move for each direction
position = [0, 0]
facing = 0
direction = { 'E': 0, 'S': 1, 'W': 2, 'N': 3}
movement = [(0, 1), (-1, 0), (0, -1), (1, 0)]

# Now follow all our instructions
for instruction in data:
    command = instruction[0:1]
    amount = int(instruction[1:])
    # If our command is a direction, we simply move in that direction the amount given
    if command in direction:
        position[0] += movement[direction[command]][0] * amount
        position[1] += movement[direction[command]][1] * amount
    # If we're moving forward, use our facing and move in that direction
    elif command == 'F':
        position[0] += movement[facing][0] * amount
        position[1] += movement[facing][1] * amount
    # Otherwise, we're changing our facing 
    elif command == 'L':
        facing = (facing - int(amount / 90)) % 4
    else:
        facing = (facing + int(amount / 90)) % 4

print("Part 1: manhattan distance travelled = {}".format(abs(position[0]) + abs(position[1])))

# Part Two: follow modified instructions, using a waypoint marker
position = [0, 0]
waypoint = [1, 10]
for instruction in data:
    command = instruction[0:1]
    amount = int(instruction[1:])
    #print("Command: {} {} \n -> start waypoint {}, {} | start position {}, {}".format(command, amount, waypoint[0], waypoint[1], position[0], position[1]))
    # If our command is a direction, we move the waypoint the amount given
    if command in direction:
        waypoint[0] += movement[direction[command]][0] * amount
        waypoint[1] += movement[direction[command]][1] * amount
    # Or maybe we're rotating our waypoint
    # Thankfully, since we're doing this in 90 degree increments, we can do some easy cheats for cartesian rotation
    elif command == 'L' or command == 'R':
        # Normalize to counterclockwise
        angle = amount
        if command == 'R':
            angle = 360 - amount
        
        if angle == 90:
            temp = waypoint[0]
            waypoint[0] = waypoint[1]
            waypoint[1] = temp * -1 
        elif angle == 180:
            waypoint[0] = waypoint[0] * -1
            waypoint[1] = waypoint[1] * -1
        elif angle == 270:
            temp = waypoint[0]
            waypoint[0] = waypoint[1] * -1
            waypoint[1] = temp
    # Otherwise, if we're going forward, we move toward the waypoint the given number of times
    else:
        position[0] += waypoint[0] * amount
        position[1] += waypoint[1] * amount
    #print(" -> final waypoint {}, {} | final position {}, {}".format(waypoint[0], waypoint[1], position[0], position[1]))

print("Part 2: manhattan distance travelled = {}".format(abs(position[0]) + abs(position[1])))
    