BasicAI = class('BasicAI')
function BasicAI:initialize()

end

function BasicAI:act()
    local x, y = camera.coordinates(self.owner.x, self.owner.y)
    if x ~= nil and self.owner:distance_to(game.data.player.character) > 2 then
        self.owner:move_towards(game.data.player.character.x, game.data.player.character.y)
    end
end