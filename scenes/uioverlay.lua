require("data/gamestate")
require("data/fonts")

uiOverlay = {}

function uiOverlay:init()
    self.TEXT_COLOR = { 1, 1, 1 }
end

function uiOverlay:update(dt)

end

function uiOverlay:render()
    if gameState == STATE.PLAYING then
        love.graphics.setFont(fonts.default)
        love.graphics.setColor(self.TEXT_COLOR)
        love.graphics.print("|  |", 10, 10, 0, 1, 1)
    else

    end
end

function uiOverlay:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left click
        
    end
end