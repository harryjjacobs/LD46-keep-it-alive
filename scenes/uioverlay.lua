local gameState = require("data/gamestate")
local gameData = require("data/gamedata")
local fonts = require("data/fonts")
local display = require("data/display")

local uiOverlay = {}

function uiOverlay:init()
    self.TEXT_COLOR = { 1, 1, 1 }
end

function uiOverlay:update(dt)

end

function uiOverlay:render()
    if gameState.state == gameState.PLAYING then
        love.graphics.setFont(fonts.small)
        love.graphics.setColor(self.TEXT_COLOR)
        love.graphics.print("|  |", 10, 10, 0, 1, 1)
        self:drawScore()
    else

    end
end

function uiOverlay:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left click
        
    end
end

function uiOverlay:drawScore()
    love.graphics.setColor(self.TEXT_COLOR)
    love.graphics.setFont(fonts.medium)
    local scoreText = tostring(gameData.score)
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(scoreText)
    love.graphics.print(scoreText, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 10, 0, 1, 1)
end

return uiOverlay