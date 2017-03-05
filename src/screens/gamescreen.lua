local screen = require('screens/screen')
local gamescreen = {}

function gamescreen.new()
    local self = screen.new()

    function self:init()
        game.new_game()
    end

    function self:draw()
        draw_world()
        draw_data()
    end

    function self:keypressed(key)
        if key == "left" or key == "kp4" then game.data.player:act(-1, 0)
        elseif key == "right" or key == "kp6" then game.data.player:act(1, 0)    
        elseif key == "up" or key == "kp8" then game.data.player:act(0, -1)
        elseif key == "down" or key == "kp2" then game.data.player:act(0, 1)
        end

        game.update()
    end

    function draw_world()
        game.data.map:draw(game.data.player.character.z)
        game.data.player.character:draw()
    end

    function draw_data()
        console.drawText("x: " .. game.data.player.character.x, camera.width + 2, 2 )
        console.drawText("y: " .. game.data.player.character.y, camera.width + 2, 3 )
        console.drawText("z: " .. game.data.player.character.z, camera.width + 2, 4 )
    end

    return self
end

return gamescreen