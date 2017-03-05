local world_generator = {}

function world_generator.generate(w, d, h)
    local map = Map(w, d, h)
    --ground
    for x=1, map.width do
        for y=1, map.depth do
            map.boxes[1][x][y] = Box(BoxType.Grass)
        end
    end

    --test
    for x=20, 30 do
        for y=10, 30 do
            map.boxes[2][x][y] = Box(BoxType.Wall)
        end
    end

    return map
end

return world_generator