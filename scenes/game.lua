require("entities/ball")
require("entities/ground")
require("utils/collisionmanager")

game = {}

GAME_WORLD_GRAVITY = 15.0
GAME_WORLD_METER = 64 --the height of a meter our worlds will be 64px

function game:init()
    love.physics.setMeter(64) 
    self.world = love.physics.newWorld(0, GAME_WORLD_GRAVITY * GAME_WORLD_METER, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81

    ball:init(self.world)
    ground:init(self.world)

    collisionManager:init(self.world)
    collisionManager:addListener(ground.fixture, function(a, b, coll)
        if b == ball.fixture then
            state = STATE.GAME_OVER
        end
    end)
end

function game:update(dt)
    self.world:update(dt) --puts the world into motion
    --update entities
    ball:update(dt)
    ground:update(dt)
end

function game:render()
    ball:render()
    ground:render()
end

function game:onMousePressed(x, y, button, istouch)
    ball:onMousePressed(x, y, button, istouch)
end