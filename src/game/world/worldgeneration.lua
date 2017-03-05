local world_generator = {}

function world_generator.generate(w, d, h)
    local map = Map(w, d, h)
    --ground
    for x=1, map.width do
        for y=1, map.depth do
            map.boxes[1][x][y] = Box(BoxType.Road)
        end
    end
    
    --buildings
    local cells = world_generator.cellify(map, 16)
    world_generator.create_buildings(map, cells, 3)

    return map
end

function world_generator.cellify(map, min_size)
    print("creating bsp...")
    local init_leaf = {x = 1, y = 1, w = map.width-1, h = map.depth-1, left = nil, right = nil}
    local queue = {init_leaf}
    local function split_hor(leaf)
        if leaf.h - min_size <= min_size then
            return false
        end
        local spl = math.random(min_size, leaf.h - min_size) 
        leaf.left =     {x=leaf.x,          y=leaf.y,           w=leaf.w,           h=spl,              left = nil, right = nil}
        leaf.right =    {x=leaf.x,          y=leaf.y + spl,     w=leaf.w,           h=leaf.h - spl,     left = nil, right = nil}
        
        table.insert(queue, leaf.left)
        table.insert(queue, leaf.right)
    end
    local function split_ver(leaf)
        if leaf.w - min_size <= min_size  then
            return false
        end
        local spl = math.random(min_size, leaf.w - min_size) 
        leaf.left =     {x=leaf.x,          y=leaf.y,           w=spl,              h=leaf.h,           left = nil, right = nil}
        leaf.right =    {x=leaf.x + spl,    y=leaf.y,           w=leaf.w - spl,     h=leaf.h,           left = nil, right = nil}
        
        table.insert(queue, leaf.left)
        table.insert(queue, leaf.right)
    end
    while #queue > 0 do
        local l = table.remove(queue, 1)
        print("leaf: x" .. l.x .."y"..l.y.."w"..l.w.."h"..l.h)
        if love.math.random(1,2) == 1 then
            split_hor(l)
        else
            split_ver(l)
        end
    end
    local cells = {}
    function child_to_cell(leaf)
        local childless = true
        if leaf.left then
            child_to_cell(leaf.left)
            childless = false
        end
        if leaf.right then
            child_to_cell(leaf.right)
            childless = false
        end
        if childless then
            table.insert(cells, leaf)
        end
    end
    child_to_cell(init_leaf)
    return cells
end

function world_generator.create_buildings(map, cells, roadsize)
    print("creating buildings...")
    for k,v in pairs(cells) do
        local x = v.x + 2
        local y = v.y + 2
        local z = 1
        local w = v.w-1 - roadsize
        local d = v.h-1 - roadsize   
        local h = love.math.random(2, map.height - z)           
        print("x"..x.."y"..y.."z"..z.."w"..w.."d"..d.."h"..h)
        local bu = Structure("building", x, y, z, w, d, h)
        for i=bu.x1, bu.x2 do
            for j=bu.y1, bu.y2 do
                map.boxes[1][j][i] = Box(BoxType.Floor)
            end
        end
        for z=bu.z1, bu.z2 do
            for i=bu.x1, bu.x2 do
                map.boxes[z][bu.y1][i] = Box(BoxType.Wall)
                map.boxes[z][bu.y2][i] = Box(BoxType.Wall)
            end
            for i=bu.y1, bu.y2 do
                map.boxes[z][i][bu.x1] = Box(BoxType.Wall)
                map.boxes[z][i][bu.x2] = Box(BoxType.Wall) 
            end
        end
        
        local cx, cy = bu:center()
        local choice = love.math.random(1, 4)
        if choice == 1 then
            map.boxes[1][cy][bu.x1] = Box(BoxType.Dirt)
            map.boxes[2][cy][bu.x1] = Box(BoxType.Air)
        elseif choice == 2 then 
            map.boxes[1][cy][bu.x2] = Box(BoxType.Dirt)
            map.boxes[2][cy][bu.x2] = Box(BoxType.Air)
        elseif choice == 3 then 
            map.boxes[1][bu.y1][cx] = Box(BoxType.Dirt)
            map.boxes[2][bu.y1][cx] = Box(BoxType.Air)
        elseif choice == 4 then 
            map.boxes[1][bu.y2][cx] = Box(BoxType.Dirt)
            map.boxes[2][bu.y2][cx] = Box(BoxType.Air)
        end
    end
end

return world_generator