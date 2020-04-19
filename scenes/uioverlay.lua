local gameState = require("data/gamestate")
local gameData = require("data/gamedata")
local fonts = require("data/fonts")
local display = require("data/display")
local button = require("entities/ui/textbutton")

local uiOverlay = {
    TEXT_COLOR = { 1, 1, 1 },
    PAUSE_TEXT = "|  |",
    PLAY_TEXT = ">",
}

function uiOverlay:init()
    self.playPauseButton = button:create(self.PAUSE_TEXT, 10, 10, 200, 50, fonts.small)
end

function uiOverlay:deinit()

end

function uiOverlay:update(dt)
    self.playPauseButton:update(dt)
end

function uiOverlay:render()
    if gameState:get() == gameState.PLAYING then
        self:drawScore()
    elseif gameState:get() == gameState.PAUSED then
        
    end
    self.playPauseButton:render()
end

function uiOverlay:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left click
        display:screen2world(x, y)
    end
end

function uiOverlay:drawScore()
    love.graphics.setColor(self.TEXT_COLOR)
    love.graphics.setFont(fonts.medium)
    local scoreText = tostring(gameData.score)
    local textWidth = self:getTextWidth(scoreText)
    love.graphics.print(scoreText, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 10, 0, 1, 1)
end

function uiOverlay:getTextWidth(text)
    local font = love.graphics.getFont()
    return font:getWidth(text)
end

function uiOverlay:getTextHeight()
    local font = love.graphics.getFont()
    return font:getHeight()
end

return uiOverlay