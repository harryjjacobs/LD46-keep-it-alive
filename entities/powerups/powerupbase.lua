require("utils/collisionmanager")

local powerup = {}

function powerup:create(size, drawable)
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function powerup:init(world)
    self.body = love.physics.newBody(world, randomSpawnPosition(), "static") --place the body in the center of the world and make it static, so it cant move around
    self.shape = love.physics.newCircleShape(40) --the collectable's shape has a radius of 20
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1
    self.fixture:setSensor(true)    --no collision resolution
    self.fixture:setRestitution(0.9) --let the ball bounce
    collisionManager.addListener(self.fixture, function(a, b, coll)
        if b == ball.fixture then
            self:activate()
        end
    end)
end

function powerup:deinit()
    
end

function powerup:activate()
    self.activated = true
    if self.onActivate then self.onActivate(self) end
end

function powerup:deactivate()
    self.activated = false
    if self.onDeactivate then self.onDeactivate(self) end
end

function powerup:update(dt)
    
end

function powerup:render()
    if not self.activated then
        --draw the powerup icon only when not yet activated
        love.graphics.setColor(0.76, 0.76, 0.76) --set the drawing color to white for the powerup
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
    end
end

function powerup:randomSpawnPosition()
    return love.math.random(0, 0.9 * GAME_WIDTH), love.math.random(0, 0.9 * GAME_HEIGHT)
end

return powerup