local node = require("nodes/node")
local gameState = require("data/gamestate")
local gameData = require("data/gamedata")
local fonts = require("data/fonts")
local display = require("data/display")
local button = require("nodes/ui/textbutton")

local uiOverlay = node:create()

uiOverlay.TEXT_COLOR = { 1, 1, 1 }
uiOverlay.PAUSE_TEXT = " | | "
uiOverlay.PLAY_TEXT = " > "

function uiOverlay:init()
    node.init(self)
    self.playPauseButton = button:create(self.PAUSE_TEXT, 10, 10, 41, 50, fonts.small)
    self.playPauseButton:addClickListener(function()
        if gameState:get() == gameState.PLAYING then
            gameState:set(gameState.PAUSED)
        elseif gameState:get() == gameState.PAUSED then
            gameState:set(gameState.PLAYING)
        end
    end)
    node.addChild(self, self.playPauseButton)
end

function uiOverlay:deinit()
    node.deinit(self)
end

function uiOverlay:update(dt)
    node.update(self, dt)
end

function uiOverlay:render()
    node.render(self)
    if gameState:get() == gameState.PLAYING then
        self:drawScore()
        self.playPauseButton:setText(self.PAUSE_TEXT)
    elseif gameState:get() == gameState.PAUSED then
        self.playPauseButton:setText(self.PLAY_TEXT)
    end
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