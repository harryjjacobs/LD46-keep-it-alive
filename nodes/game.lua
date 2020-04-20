node = require("nodes/node")
ball = require("nodes/ball")
ground = require("nodes/ground")
powerupManager = require("nodes/powerupmanager")
solidGround = require("nodes/powerups/solidground")
clouds = require("nodes/clouds")
gameState = require("data/gamestate")
gameData = require("data/gamedata")
display = require("data/display")
collisionManager = require("utils/collisionmanager")

local game = node:create()

GAME_WORLD_GRAVITY = 15.0
GAME_WORLD_METER = 64 --the height of a meter our worlds will be 64px

function game:init()
    node.init(self)
    love.physics.setMeter(64) 
    self.world = love.physics.newWorld(0, GAME_WORLD_GRAVITY * GAME_WORLD_METER, true) --create a world for the bodies to exist in

    gameData:init()
    ball:init(self.world)
    ground:init(self.world)
    powerupManager:init(self.world)
    collisionManager:init(self.world)
    clouds:init()

    collisionManager:addListener(ground.fixture, function(a, b, coll)
        if not ground.isBouncable and b == ball.fixture then
            gameState:set(gameState.GAME_OVER)
        end
    end)
end

function game:deinit()
    node.deinit(self)
end

function game:update(dt)
    node.update(self, dt)
    self.world:update(dt) --puts the world into motion
    --update entities
    ball:update(dt)
    ground:update(dt)
    solidGround:update(dt)
    powerupManager:update(dt)
    clouds:update()
end

function game:render()
    node.render(self)
    --render background
    love.graphics.setColor(0.3, 0.46, 0.87)
    love.graphics.rectangle("fill", 0, 0, display.GAME_WIDTH, display.GAME_HEIGHT)
    clouds:render()
    ball:render()
    ground:render()
    powerupManager:render()
end

function game:onMousePressed(x, y, button, istouch)
    if gameState:get() == gameState.PLAYING then
        ball:onMousePressed(x, y, button, istouch)
    end
end

return game