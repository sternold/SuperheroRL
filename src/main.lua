--libraries
require("libraries/util")
class               = require("libraries/middleclass")
bitser              = require("libraries/bitser")
console             = require("libraries/loveconsole")
screenmanager       = require("libraries/screenmanager")
camera              = require("libraries/camera")
colors              = require("libraries/colors")
--classes
require("game/world/classes/Map")
require("game/world/classes/Box")
require("game/classes/GameObject")
require("game/classes/Player")
--modules
game                = require("game/game")

--constants
SAVE_FILE = "save.rl"
CONF_FILE = "conf.rl"

function register()
    bitser.registerClass(Box)
    bitser.registerClass(Map)
    bitser.registerClass(GameObject)
    bitser.registerClass(Player)
end

function love.load()
    --bitser
    register()

    --config
    love.filesystem.createDirectory(love.filesystem.getSaveDirectory())
    config = load_config()
    
    --window
    console.init(80, 60, 16)
    camera.init(60, 50)
    love.keyboard.setKeyRepeat(true)

    --initialize screen managers
    local screens = {
        main = require("screens/mainscreen"),
        game = require("screens/gamescreen")
    }
    screenmanager.init(screens, "game")
    screenmanager.registerCallbacks()
end

function love.update(dt)
    screenmanager.update(dt)
end

function love.draw()
    screenmanager.draw()
end

--config init
function save_config()
    bitser.dumpLoveFile(CONF_FILE, config)
end

function load_config()
    local config_default = {fullscreen=false}
    if not love.filesystem.isFile(CONF_FILE) or table.count(bitser.loadLoveFile(CONF_FILE)) ~= table.count(config_default) then      
        bitser.dumpLoveFile(CONF_FILE, config_default)
        print("Default config loaded.")
    end
    return bitser.loadLoveFile(CONF_FILE)
end