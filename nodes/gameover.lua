local node = require("nodes/node")
local textButton = require("nodes/ui/textbutton")
local gameState = require("data/gamestate")
local gameData = require("data/gamedata")
local fonts = require("data/fonts")
local display = require("data/display")

local gameOver = node:create()

function gameOver:init()
    self.TEXT_COLOR = { 0.9, 0.9, 0.9 }
    node.init(self)
    self.restartButton = textButton:create("RESTART", (display.GAME_WIDTH - 135) / 2, (display.GAME_HEIGHT) / 2 + 100, 135, 50, fonts.small)
    self:addChild(self.restartButton)
end

function gameOver:deinit()
    node.deinit(self)
end

function gameOver:update(dt)
    node.update(self, dt)
end

function gameOver:render()
    node.render(self)
    self:drawGameOver()
    self:drawScore()
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
    local textHeight = font:getHeight()
    love.graphics.print(text, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 3 - textHeight, 0, 1, 1)
end

function gameOver:drawScore()
    love.graphics.setColor(self.TEXT_COLOR)
    love.graphics.setFont(fonts.medium)
    local scoreText = "SCORE: "..tostring(gameData.score)
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(scoreText)
    local textHeight = font:getHeight()
    love.graphics.print(scoreText, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 2 - textHeight - 20, 0, 1, 1)
end

return gameOver