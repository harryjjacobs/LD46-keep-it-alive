require("data/display")
require("data/fonts")
require("scenes/game")
require("scenes/uioverlay")
require("data/gamestate")

function love.load()
    fonts:load()

    game:init()
    uiOverlay:init()

    --set the background color to a soothing blue
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
    setGraphicsTransformation()

    gameState = STATE.PLAYING
end

function love.update(dt)
    if gameState == STATE.MENU then

    elseif gameState == STATE.PLAYING then
        game:update(dt)
        uiOverlay:update(dt)
    elseif gameState == STATE.PAUSED then

    elseif gameState == STATE.GAME_OVER then
        --show losing screen
    end
end

function love.draw()
    --for maintaining aspect ratio
    love.graphics.translate(graphicsTransf.translation.x, graphicsTransf.translation.y)
    love.graphics.scale(graphicsTransf.scale, graphicsTransf.scale)
    
    game:render()
    uiOverlay:render()
end

--forward mouse presses
--todo put in separate file
function love.mousepressed(x, y, button, istouch)
    game:onMousePressed(x, y, button, istouch)
    uiOverlay:onMousePressed(x, y, button, istouch)
end

--for maintaining aspect ratio
function love.resize(w, h)
    setGraphicsTransformation()
end

--pause the game when focus is lost
function love.focus(f)
    isPaused = not f
end