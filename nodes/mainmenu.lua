local node = require("nodes/node")
local textButton = require("nodes/ui/textbutton")
local display = require("data/display")
local gameState = require("data/gamestate")
local fonts = require("data/fonts")
local images = require("data/images")

local mainMenu = node:create()

function mainMenu:init()
    node.init(self)
    self.TEXT_COLOR = { 0.9, 0.9, 0.9, 1.0 }
    self.playButton = textButton:create("PLAY", (display.GAME_WIDTH - 135) / 2, (display.GAME_HEIGHT) / 2, 135, 50, fonts.small)
    self.playButton:addClickListener(function()
        gameState:set(gameState.PLAYING)
    end)
    self.quitButton = textButton:create("QUIT", (display.GAME_WIDTH - 135) / 2, (display.GAME_HEIGHT) / 2 + 50, 135, 50, fonts.small)
    self.quitButton:addClickListener(function()
        love.event.quit()
    end)

    node.addChild(self, self.playButton)
    node.addChild(self, self.quitButton)

    love.audio.play(sounds.music.title)
end

function mainMenu:setActive(active)
    node.setActive(self, active)
    if not active then
        love.audio.stop(sounds.music.title)
    end
end

function mainMenu:render()
    love.graphics.draw(images.environment.background, 0, -520, 0, 0.6, 0.6, 0, 0)
    node.render(self)
    self:drawTitle()
    self:drawCredits()
end

function mainMenu:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left click
        --forward to buttons
        self.playButton:onMousePressed(x, y, button, istouch)
        self.quitButton:onMousePressed(x, y, button, istouch)
    end
end

function mainMenu:drawTitle()
    love.graphics.setColor(self.TEXT_COLOR)
    love.graphics.setFont(fonts.large)
    local text = "Keep It Alive!"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()
    love.graphics.print(text, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT / 2 - textHeight, 0, 1, 1)
end

function mainMenu:drawCredits()
    love.graphics.setFont(fonts.small)
    local text = "Programming: Harry Jacobs | Sound and art: Sam Pepper"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    local textHeight = font:getHeight()
    love.graphics.print(text, display.GAME_WIDTH / 2 - textWidth / 2, display.GAME_HEIGHT - textHeight, 0, 1, 1)
end

return mainMenu