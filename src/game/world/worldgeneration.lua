local world_generator = {}

function world_generator.generate(w, d, h)
    local map = Map(w, d, h)
    --ground
    for x=1, map.width do
        for y=1, map.depth do
            map.boxes[1][x][y] = Box(BoxType.Grass)
        end
    end

    world_generator.create_roads(map, 50)
    world_generator.create_buildings(map, 50)

    return map
end

function world_generator.create_roads(map, count)
    for i=0, count do
        local x = love.math.random(1, map.width)
        local y = love.math.random(1, map.depth)
        local direction = love.math.random(1, 4)
        while x >= 1 and x <= map.width and y >= 1 and y <= map.depth do
            map.boxes[1][x][y] = Box(BoxType.Road)       
            if direction == 1 then
                x = x + 1
            elseif direction == 2 then
                x = x - 1
            elseif direction == 3 then
                y = y + 1
            elseif direction == 4 then
                y = y - 1
            end
        end
        print("road " .. i .. "/" .. count)
    end
end

function world_generator.create_buildings(map, count)
    for i=0, count do
        local x = love.math.random(1, map.width)
        local y = love.math.random(1, map.depth)
        local w = love.math.random(6, 10)
        local h = love.math.random(6, 10)
        local bu = Structure("building", x, y, 2, w, h, 1)
        for i=bu.x1, bu.x2 do
            map.boxes[2][bu.y1][i] = Box(BoxType.Wall)
            map.boxes[2][bu.y2][i] = Box(BoxType.Wall)
        end
        for i=bu.y1, bu.y2 do
            map.boxes[2][i][bu.x1] = Box(BoxType.Wall)
            map.boxes[2][i][bu.x2] = Box(BoxType.Wall) 
        end
    end
end

return world_generator