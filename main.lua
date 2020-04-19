local display = require("data/display")
local fonts = require("data/fonts")
local images = require("data/images")
local uiOverlay = require("scenes/uioverlay")
local gameState = require("data/gamestate")
require("scenes/game")

function love.load()
    fonts:load()
    images:load()

    game:init()
    uiOverlay:init()

    --set the background color to a soothing blue
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
    display:updateTransformation()

    gameState.state = gameState.PLAYING
end

function love.update(dt)
    if gameState.state == gameState.MENU then

    elseif gameState.state == gameState.PLAYING then
        game:update(dt)
        uiOverlay:update(dt)
    elseif gameState.state == gameState.PAUSED then

    elseif gameState.state == gameState.GAME_OVER then
        --show losing screen
    end
end

function love.draw()
    --for maintaining aspect ratio
    love.graphics.translate(display.graphicsTransf.translation.x, display.graphicsTransf.translation.y)
    love.graphics.scale(display.graphicsTransf.scale, display.graphicsTransf.scale)
    
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
    display:updateTransformation()
end

--pause the game when focus is lost
function love.focus(f)
    isPaused = not f
end