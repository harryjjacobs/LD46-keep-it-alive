local gameState = require("data/gamestate")
local gameData = require("data/gamedata")
local fonts = require("data/fonts")
local display = require("data/display")

local paused = {}

function paused:init()
    self.TEXT_COLOR = { 1, 1, 1 }
end

function paused:deinit()

end

function paused:update(dt)

end

function paused:render()
    self:drawPaused()
    self:drawMenu()
end

function paused:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left click
        --forward to buttons
        gameState:set(gameState.PLAYING)
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

function paused:drawMenu()
    love.graphics.setColor(self.TEXT_COLOR)
    love.graphics.setFont(fonts.small)
    local scoreText = "TAP TO CONTINUE"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(scoreText)
    love.graphics.print(scoreText, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 2 + 100, 0, 1, 1)
end

return paused