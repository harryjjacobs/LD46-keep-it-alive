--Entry point for the game
local mainMenu = require("nodes/mainmenu")
local game = require("nodes/game")
local gameOver = require("nodes/gameover")
local paused = require("nodes/pausedmenu")
local uiOverlay = require("nodes/uioverlay")
local display = require("data/display")
local fonts = require("data/fonts")
local images = require("data/images")
local sounds = require("data/sounds")
local gameState = require("data/gamestate")
local gameData = require("data/gamedata")

function love.load()
    fonts:load()
    images:load()
    sounds:load()
    
    mainMenu:init()

    nodes = {
        mainMenu,
        game,
        uiOverlay,
        paused,
        gameOver
    }

    gameState:set(gameState.MENU)
    gameState:addChangeListener(gameState.MENU, gameState.PLAYING, startGame)

    --startGame()
end

function love.update(dt)
    if gameState:get() == gameState.MENU then
        mainMenu:setActive(true)
        game:setActive(false)
        paused:setActive(false)
        uiOverlay:setActive(false)
        gameOver:setActive(false)
    elseif gameState:get() == gameState.PLAYING then
        mainMenu:setActive(false)
        game:setActive(true)
        uiOverlay:setActive(true)
    elseif gameState:get() == gameState.PAUSED then
        mainMenu:setActive(false)
        game:setActive(false)
        paused:setActive(true)
    elseif gameState:get() == gameState.GAME_OVER then
        mainMenu:setActive(false)
        game:setActive(false)
        uiOverlay:setActive(false)
        --show losing screen
        gameOver:setActive(true)
    end

    for _, n in ipairs(nodes) do
        if n:getActive() then
            n:update(dt * gameData.timeScale)
        end
    end
end

function love.draw()
    --for maintaining aspect ratio
    love.graphics.translate(display.graphicsTransf.translation.x, display.graphicsTransf.translation.y)
    love.graphics.scale(display.graphicsTransf.scale, display.graphicsTransf.scale)
    --cut off anything outside the display window (to stop things
    --being rendered in the margins caused by the aspect ratio fitting)
    love.graphics.setScissor(
        display.graphicsTransf.translation.x,
        display.graphicsTransf.translation.y,
        display.GAME_WIDTH * display.graphicsTransf.scale,
        display.GAME_HEIGHT * display.graphicsTransf.scale
    )

    if gameState:get() == gameState.MENU then
        mainMenu:render()
    elseif gameState:get() == gameState.PLAYING then
        game:render()
        uiOverlay:render()
    elseif gameState:get() == gameState.PAUSED then
        game:render()
        uiOverlay:render()
        paused:render()
    elseif gameState:get() == gameState.GAME_OVER then
        game:render()
        --show losing screen above game
        gameOver:render()
    end

    love.graphics.setScissor()
end

--forward mouse presses
--todo put in separate file
function love.mousepressed(x, y, button, istouch)
    if gameState:get() == gameState.MENU then
        mainMenu:onMousePressed(x, y, button, istouch)
    elseif gameState:get() == gameState.PLAYING then
        game:onMousePressed(x, y, button, istouch)
        uiOverlay:onMousePressed(x, y, button, istouch)
    elseif gameState:get() == gameState.PAUSED then
        paused:onMousePressed(x, y, button, istouch)
        uiOverlay:onMousePressed(x, y, button, istouch)
    elseif gameState:get() == gameState.GAME_OVER then
        gameOver:onMousePressed(x, y, button, istouch)
    end
end

--for maintaining aspect ratio
function love.resize(w, h)
    display:updateTransformation()
end

--pause the game when focus is lost
function love.focus(f)
    if f == false then
        gameState:set(gameState.PAUSED)
    end
end

function startGame()
    game:init()
    uiOverlay:init()
    gameOver:init()
    paused:init()

    love.graphics.setBackgroundColor(0.1, 0.1, 0.15)
    display:updateTransformation()

    gameState:addChangeListener(gameState.GAME_OVER, gameState.PLAYING, onRestart)

    gameState:set(gameState.PLAYING)
end

function stopGame()
    game:deinit()
    uiOverlay:deinit()
    gameOver:deinit()
    paused:deinit()

    gameState:reset()
end

function onRestart()
    --game has been restarted
    --reset everything and start again
    stopGame()
    startGame()
end