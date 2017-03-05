Structure =  class('Structure')
function Structure:initialize(name, x, y, z, w, d, h)
    self.name = name
    self.x1 = x
    self.y1 = y
    self.z1 = z
    self.x2 = x + w
    self.y2 = y + d
    self.z2 = z + h
end

function Structure:center()
    cx = math.round((self.x1 + self.x2) / 2)
    cy = math.round((self.y1 + self.y2) / 2)
    cz = math.round((self.z1 + self.z2) / 2)
    return cx, cy, cz
end

function Structure:intersect(other)
    return (self.x1 <= other.x2 and self.x2 >= other.x1 and self.y1 <= other.y2 and self.y2 >= other.y1)
end
