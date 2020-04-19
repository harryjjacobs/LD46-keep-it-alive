local gameState = require("data/gamestate")
local gameData = require("data/gamedata")
local fonts = require("data/fonts")
local display = require("data/display")
local textButton = require("entities/ui/textbutton")

local paused = {}

function paused:init()
    self.TEXT_COLOR = { 1, 1, 1 }
    self.resumeButton = textButton:create("Resume", (display.GAME_WIDTH - 135) / 2, (display.GAME_HEIGHT) / 2, 135, 50, fonts.small)
    self.resumeButton:addClickListener(function()
        gameState:set(gameState.PLAYING)
    end)
    self.quitButton = textButton:create("Quit", (display.GAME_WIDTH - 71) / 2, (display.GAME_HEIGHT) / 2 + 50, 71, 50, fonts.small)
    self.quitButton:addClickListener(function()
        love.event.quit()
    end)
end

function paused:deinit()

end

function paused:update(dt)
    self.resumeButton:update(dt)
    self.quitButton:update(dt)
end

function paused:render()
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