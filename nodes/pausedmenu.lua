local node = require("nodes/node")
local gameState = require("data/gamestate")
local gameData = require("data/gamedata")
local fonts = require("data/fonts")
local sounds = require("data/sounds")
local display = require("data/display")
local textButton = require("nodes/ui/textbutton")

local paused = node:create()

function paused:init()
    node.init(self)
    self.TEXT_COLOR = { 1, 1, 1 }
    self.resumeButton = textButton:create("RESUME", (display.GAME_WIDTH - 150) / 2, (display.GAME_HEIGHT) / 2, 150, 50, fonts.small)
    self.resumeButton:addClickListener(function()
        gameState:set(gameState.PLAYING)
    end)
    self.quitButton = textButton:create("QUIT", (display.GAME_WIDTH - 150) / 2, (display.GAME_HEIGHT) / 2 + 50, 150, 50, fonts.small)
    self.quitButton:addClickListener(function()
        love.event.quit()
    end)
end

function paused:update(dt)
    node.update(self, dt)
    self.resumeButton:update(dt)
    self.quitButton:update(dt)
end

function paused:render()
    node.render(self)
    self:drawPaused()
    self.resumeButton:render()
    self.quitButton:render()
end

function paused:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left click
        --forward to buttons
        self.resumeButton:onMousePressed(x, y, button, istouch)
        self.quitButton:onMousePressed(x, y, button, istouch)
    end
end

function paused:drawPaused()
    love.graphics.setColor(self.TEXT_COLOR)
    love.graphics.setFont(fonts.large)
    local text = "GAME PAUSED"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    love.graphics.print(text, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 3, 0, 1, 1)
end

return paused