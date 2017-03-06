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
        --draw_minimap(1, 63, 45)
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
        for k, v in pairs(game.data.map.objects) do
            v:draw()
        end
        game.data.player.character:draw()
    end

    function draw_minimap(z, mx, my)
        local scale = 4
        local function drawpip(color, x, y)
            love.graphics.setColor(color)
            love.graphics.rectangle("fill", mx*console.scale+x*scale, my*console.scale+y*scale, scale, scale)
            love.graphics.setColor(colors.white)
        end
        --outline
        love.graphics.setColor(colors.dark_red)
        love.graphics.rectangle("line", mx*console.scale, my*console.scale, (camera.width+1)*scale, (camera.height+1)*scale)
        love.graphics.setColor(colors.white)
        --map
        for x=0, camera.width do
            for y=0, camera.height do
                local b = game.data.map.boxes[z][x+camera.x+1][y+camera.y+1]
                drawpip(b.color, x, y)
            end
        end
        --player
        local drawx, drawy = camera.coordinates(game.data.player.character.x, game.data.player.character.y)
        drawpip(game.data.player.character.color, drawx, drawy)
    end

    function draw_data()
        console.drawText("x: " .. game.data.player.character.x, camera.width + 2, 2 )
        console.drawText("y: " .. game.data.player.character.y, camera.width + 2, 3 )
        console.drawText("z: " .. game.data.player.character.z, camera.width + 2, 4 )
    end

    return self
end

return gamescreen