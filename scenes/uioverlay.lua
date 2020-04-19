local gameState = require("data/gamestate")
local gameData = require("data/gamedata")
local fonts = require("data/fonts")
local display = require("data/display")
local button = require("entities/ui/textbutton")

local uiOverlay = {
    TEXT_COLOR = { 1, 1, 1 },
    PAUSE_TEXT = " | | ",
    PLAY_TEXT = " > ",
}

function uiOverlay:init()
    self.playPauseButton = button:create(self.PAUSE_TEXT, 10, 10, 41, 50, fonts.small)
    self.playPauseButton:addClickListener(function()
        if gameState:get() == gameState.PLAYING then
            gameState:set(gameState.PAUSED)
        elseif gameState:get() == gameState.PAUSED then
            gameState:set(gameState.PLAYING)
        end
    end)
end

function uiOverlay:deinit()

end

function uiOverlay:update(dt)
    self.playPauseButton:update(dt)
end

function uiOverlay:render()
    if gameState:get() == gameState.PLAYING then
        self:drawScore()
        self.playPauseButton:setText(self.PAUSE_TEXT)
    elseif gameState:get() == gameState.PAUSED then
        self.playPauseButton:setText(self.PLAY_TEXT)
    end
    self.playPauseButton:render()
end

function uiOverlay:onMousePressed(x, y, button, istouch)
    self.playPauseButton:onMousePressed(x, y, button, istouch)
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

function uiOverlay:onPauseClicked()

end

return uiOverlay