# Advent of Code 2018, Day 13
# Part 2: Mine Cart Madness: last cart standing

grid = []
carts = []
north = { x: 0, y: -1 }
south = { x: 0, y: 1 }
east = { x: 1, y: 0 }
west = { x: -1, y: 0 }
directions = [north, east, south, west]
File.open("day13_input.txt").each do |line|
    grid << line.split('')
end

grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
        if ['<', '>', '^', 'v'].include?(cell)
            cart = {
                location: {
                    x: x,
                    y: y
                },
                turns: 0,
                crashed: false
            }
            case cell
            when '^'
                cart[:velocity] = 0
                grid[y][x] = '|'
            when '>'
                cart[:velocity] = 1
                grid[y][x] = '-'
            when 'v'
                cart[:velocity] = 2
                grid[y][x] = '|'
            when '<'
                cart[:velocity] = 3
                grid[y][x] = '-'
            end
            carts << cart
        end
    end
end

crashes = 0
# Now that we've got our map and our carts, start moving things around until we have crashed all but one
while carts.length - crashes > 1
    # Start by sorting our carts in the order they'll move
    carts.sort! { |a,b| [a[:location][:y], a[:location][:x]] <=> [b[:location][:y], b[:location][:x]]}
    carts.each do |cart|
        # If this cart has crashed, just skip it
        next if cart[:crashed]
        # Update the location of this cart, and see if it ran into any other cart
        cart[:location][:y] += directions[cart[:velocity]][:y]
        cart[:location][:x] += directions[cart[:velocity]][:x]
        carts.each do |check|
            if cart != check && !check[:crashed] && cart[:location][:x] == check[:location][:x] && cart[:location][:y] == check[:location][:y]
                cart[:crashed] = true
                check[:crashed] = true
                crashes += 2
                break
            end
        end

        # If we didn't crash, then see if we need to update our velocity
        if !cart[:crashed] 
            case grid[cart[:location][:y]][cart[:location][:x]]
                when "+"
                    # Do some math so we turn by modifying direction by [-1, 0, 1] repeating,
                    # as well as adjustments to keep our final velocity within array limits
                    cart[:velocity] = (cart[:velocity] + ((cart[:turns] % 3) - 1)) % 4
                    cart[:turns] += 1
                when "\\"
                    if cart[:velocity] % 2 == 0
                        cart[:velocity] = (cart[:velocity] - 1) % 4
                    else
                        cart[:velocity] = (cart[:velocity] + 1) % 4
                    end
                when "/"
                    if cart[:velocity] % 2 == 0
                        cart[:velocity] = (cart[:velocity] + 1) % 4
                    else
                        cart[:velocity] = (cart[:velocity] - 1) % 4
                    end
            end
        end
    end
end

last_cart = carts.select{ |cart| cart[:crashed] == false }[0]
puts "Last cart standing: " + last_cart[:location][:x].to_s + ', ' + last_cart[:location][:y].to_s