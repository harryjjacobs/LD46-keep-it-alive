local gameState = require("data/gamestate")
local gameData = require("data/gamedata")
local fonts = require("data/fonts")
local display = require("data/display")

local gameOver = {}

function gameOver:init()
    self.TEXT_COLOR = { 1, 1, 1 }
end

function gameOver:deinit()

end

function gameOver:update(dt)

end

function gameOver:render()
    self:drawGameOver()
    self:drawScore()
    self:drawMenu()
end

function gameOver:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left click
        --forward to buttons
        gameState:set(gameState.PLAYING)
    end
end

function gameOver:drawGameOver()
    love.graphics.setColor(self.TEXT_COLOR)
    love.graphics.setFont(fonts.large)
    local text = "GAME OVER"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    love.graphics.print(text, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 3, 0, 1, 1)
end

function gameOver:drawScore()
    love.graphics.setColor(self.TEXT_COLOR)
    love.graphics.setFont(fonts.medium)
    local scoreText = "SCORE: "..tostring(gameData.score)
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(scoreText)
    love.graphics.print(scoreText, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 2, 0, 1, 1)
end

function gameOver:drawMenu()
    love.graphics.setColor(self.TEXT_COLOR)
    love.graphics.setFont(fonts.small)
    local scoreText = "TAP TO RESTART"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(scoreText)
    love.graphics.print(scoreText, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 2 + 100, 0, 1, 1)
end

return gameOver