Map = class('Map')
function Map:initialize(w, d, h)
    self.width = w
    self.depth = d
    self.height = h
    self.boxes = {}
    self.lightmap = {}
    for z=1, h, 1 do
        table.insert(self.boxes, z, {})
        table.insert(self.lightmap, z, {})
        print("z"..z.." created")
        for x=1, w, 1 do
            table.insert(self.boxes[z], x, {}) 
            table.insert(self.lightmap[z], x, {}) 
            for y=1, d, 1 do
                table.insert(self.boxes[z][x], y, Box(BoxType.Air))
                table.insert(self.lightmap[z][x], y, {0, 0, 0, 255})
            end
        end
    end
    self.objects = {}
end

function Map:draw(z)
    for x=(camera.x+1), (camera.x+camera.width) do
        if self.boxes[z][x] then
            for y=(camera.y+1), (camera.y+camera.height) do
                if self.boxes[z-1] then
                    console.drawRect("fill", x-camera.x, y-camera.y, 1, 1, self.boxes[z-1][x][y].color)
                end 
                console.drawRect("fill", x-camera.x, y-camera.y, 1, 1, self.boxes[z][x][y].color)
            end
        end
    end
end

function Map:is_blocked(z, x, y)
    if self.boxes[z][x][y].blocked then
        return true
    end
    for key,value in pairs(self.objects) do 
        if value.blocks and value.z == z and value.x == x and value.y == y then
            return true
        end
    end
 
    return false
end

function Map:has_gameobject(z, x, y)
    for k, v in pairs(self.objects) do
        if v.z == z and v.x == x and v.y == y then
            return v
        end
    end
    return nil
end