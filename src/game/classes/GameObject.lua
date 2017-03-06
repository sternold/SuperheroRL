
--class definitions
GameObject = class('GameObject')
function GameObject:initialize(z, x, y, char, name, color, blocks, ai)
    self.x = x
    self.y = y
    self.z = z
    self.char = char
    self.name = name
    self.color = color
    self.blocks = blocks or false
    self.ai = ai or nil
    if self.ai then
        self.ai.owner = self
    end
end

function GameObject:move(dx, dy)
    if not game.data.map:is_blocked(self.z, self.x + dx, self.y + dy) then
        self.x = self.x + dx
        self.y = self.y + dy
    end
end

function GameObject:draw()
    local x, y = camera.coordinates(self.x, self.y)
    if x~=nil and y~=nil then
        console.drawText(self.char, x, y, self.color, 1, -1)
    end
end

function GameObject:move_towards(target_x, target_y)
    local dx = target_x - self.x
    local dy = target_y - self.y
    local distance = math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))

    dx = math.round(dx / distance)
    dy = math.round(dy / distance)
    self:move(dx, dy) 
end

function GameObject:distance_to(other)
    local dx = other.x - self.x
    local dy = other.y - self.y
    return math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))
end