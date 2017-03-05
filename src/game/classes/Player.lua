Player = class('Player')
function Player:initialize(character)
    self.character = character
    self.sense_range = 10
    self.inventory = {}
end

function Player:act(dx, dy)
    self.character:move(dx, dy)
end

--do not use
function Player:visible_range()
    game.data.map.lightmap[self.character.z][self.character.x][self.character.y] = {0, 0, 0, 0}

    for z, plane in pairs(game.data.map.lightmap) do
        for x, arr in pairs(plane) do
            for y, coord in pairs(arr) do
                if coord[4] == 0 then
                    coord[4] = 100
                end
            end
        end
    end

    for k,v in pairs(DIRECTIONS) do
        fov.calculate(self.character.z, 1, 1, 0, 0, v.dx, v.dy, 0, self.sense_range)
        fov.calculate(self.character.z, 1, 1, 0, v.dx, 0, 0, v.dy, self.sense_range)
    end
end