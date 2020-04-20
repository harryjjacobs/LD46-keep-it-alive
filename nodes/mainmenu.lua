local node = require("nodes/node")
local textButton = require("nodes/ui/textbutton")
local display = require("data/display")

local mainMenu = node:create()

function mainMenu:init()
    node.init(self)
    self.playButton = textButton:create("PLAY", (display.GAME_WIDTH - 135) / 2, (display.GAME_HEIGHT) / 2, 135, 50, fonts.small)
end

function mainMenu:onMousePressed(x, y, button, istouch)
    
end