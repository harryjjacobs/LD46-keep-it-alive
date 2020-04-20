local node = require("nodes/node")
local collisionManager = require("utils/collisionmanager")
local inheritance = require("utils/inheritance")

local powerup = inheritance:inheritsFrom(node)

function powerup:init(world, effectDuration, size, drawable)
    node.init(self)
    self.effectDuration = effectDuration
    print(size)
    self.size = size
    self.drawable = drawable
    local spawnx, spawny = self:randomSpawnPosition()
    self.body = love.physics.newBody(world, spawnx, spawny, "static") --place the body in the center of the world and make it static, so it cant move around
    self.shape = love.physics.newCircleShape(self.size) --the collectable's shape has a radius of 20
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1
    self.fixture:setSensor(true)    --no collision resolution
    self.fixture:setRestitution(0.9) --let the ball bounce
    collisionManager:addListener(self.fixture, function(a, b, coll)
        print("Collision")
        if b == ball.fixture then
            self.pendingActivation = true
            --self:activate(self)
        end
    end)
end

function powerup:deinit()
    collisionManager:removeListener(self.fixture)
    self.body:destroy()
    self.shape:destroy()
    self.fixture:destroy()
    node.deinit(self)
end

function powerup:activate()
    print("Activate")
    self.activated = true
    self.activeTimeRemaining = self.effectDuration
    if self.onActivate then self.onActivate(self) end
end

function powerup:deactivate()
    self.activated = false
    if self.onDeactivate then self.onDeactivate(self) end
end

function powerup:update(dt)
    if self.pendingActivation then
        self.activated = true
        self.pendingActivation = false
        self:activate()
    end

    if self.activated then
        self.activeTimeRemaining = self.activeTimeRemaining - dt

        if self.activeTimeRemaining <= 0 then
            self.deactivate()
        end
    end
    
end

function powerup:render()
    if not self.activated then
        --draw the powerup icon only when not yet activated
        love.graphics.setColor(0.76, 0.76, 0.76) --set the drawing color to white for the powerup
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
    end
end

function powerup:randomSpawnPosition()
    return love.math.random(0, 0.9 * display.GAME_WIDTH), love.math.random(0, 0.9 * display.GAME_HEIGHT)
end

return powerup