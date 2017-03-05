--requires util
local fov = {}

function fov.calculate(z, row, cstart, cend, xx, xy, yx, yy, range)
    local startx, starty = game.data.player.character.x, game.data.player.character.y
    local radius = range
    local start = cstart
    
    local new_start = 0
    if start < cend then
        return
    end

    local width = game.data.map.width
    local height = game.data.map.depth

    local blocked = false
    for distance = row, radius do
        local deltay = distance * -1
        for deltax = distance * -1, 0 do
            local currentx = startx + deltax * xx + deltay * xy
            local currenty = starty + deltax * yx + deltay * yy 
            local leftslope = (deltax - .5) / (deltay +.5)
            local rightslope = (deltax + .5) / (deltay - .5)

            if not (currentx >= 0 and currenty >= 0 and currentx < width and currenty < height) or start < rightslope then
                --Continue
            elseif cend > leftslope then
                break;
            else
                if math.circle_radius(deltax, deltay, 0) <= radius then
                    game.data.map.lightmap[z][currentx][currenty][4] = 0
                end

                if blocked then
                    if game.data.map.boxes[z][currentx][currenty].block_sight then
                        new_start = rightslope
                        --Continue
                    else 
                        blocked = false
                        start = new_start
                    end
                else
                    if game.data.map.boxes[z][currentx][currenty].block_sight and distance < radius then
                        blocked = true
                        fov.calculate(z, distance + 1, start, leftslope, xx, xy, yx, yy, range)
                        new_start = rightslope
                    end
                end
            end
        end
        if blocked then
            break
        end
    end
end

return fov