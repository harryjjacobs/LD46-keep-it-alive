ball = require("entities/ball")
ground = require("entities/ground")
powerupManager = require("entities/powerupmanager")
solidGround = require("entities/powerups/solidground")
gameState = require("data/gamestate")
collisionManager = require("utils/collisionmanager")

game = {}

GAME_WORLD_GRAVITY = 15.0
GAME_WORLD_METER = 64 --the height of a meter our worlds will be 64px

function game:init()
    love.physics.setMeter(64) 
    self.world = love.physics.newWorld(0, GAME_WORLD_GRAVITY * GAME_WORLD_METER, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

    ball:init(self.world)
    ground:init(self.world)
    powerupManager:init(self.world)

    collisionManager:init(self.world)
    collisionManager:addListener(ground.fixture, function(a, b, coll)
        if not ground.isBouncable and b == ball.fixture then
            gameState.state = gameState.GAME_OVER
        end
    end)
end

function game:update(dt)
    self.world:update(dt) --puts the world into motion
    --update entities
    ball:update(dt)
    ground:update(dt)
    solidGround:update(dt)
    powerupManager:update(dt)
end

function game:render()
    ball:render()
    ground:render()
    powerupManager:render()
end

function game:onMousePressed(x, y, button, istouch)
    if gameState.state == gameState.PLAYING then
        ball:onMousePressed(x, y, button, istouch)
    end
end