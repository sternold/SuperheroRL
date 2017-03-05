local game = {}
game.data = {}

ALPHABET = {
    "a", "b", "c", "d", "e", 
    "f","g", "h", "i", "j", 
    "k", "l", "m", "n", "o", 
    "p", "q", "r", "s", "t", 
    "u", "v", "w", "x", "y", 
    "z"
}
DIRECTIONS = {
    up          = {dx=0,    dy=0,    dz=1}, 
    down        = {dx=0,    dy=0,    dz=-1}, 
    left        = {dx=-1,   dy=0,    dz=0}, 
    right       = {dx=1,    dy=0,    dz=0}, 
    front       = {dx=0,    dy=-1,   dz=0}, 
    back        = {dx=0,    dy=1,    dz=0}, 
    none        = {dx=0,    dy=0,    dz=0}
}

function game.new_game()
    --debug
    local time = os.clock()

    local worldgen = require("game/world/worldgeneration")
    game.data.map = worldgen.generate(512, 512, 16)
    game.data.player = Player(GameObject(2, 10, 10, "@", "player", colors.yellow, true))

    --debug
    print("init time: " .. (os.clock() - time))
    print("gameobjects: " .. table.count(game.data.map.objects))
    print("boxes: " .. (table.count(game.data.map.boxes) * table.count(game.data.map.boxes[1]) * table.count(game.data.map.boxes[1][1])))
end

function game.update()
    camera.move(game.data.player.character.x, game.data.player.character.y, game.data.map.width, game.data.map.depth)
end

return game