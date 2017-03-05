Player = class('Player')
function Player:initialize(character)
    self.character = character
    self.sense_range = 10
    self.inventory = {}
end

function Player:act(dx, dy)
    self.character:move(dx, dy)
end