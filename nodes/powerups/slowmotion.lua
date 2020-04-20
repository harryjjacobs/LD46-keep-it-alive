local powerup = require("nodes/powerups/powerupbase")
local images = require("data/images")
local inheritance = require("utils/inheritance")

local slowMotion = inheritance:inheritsFrom(powerup)

function slowMotion:init(world, effectDuration)
    powerup.init(self, world, effectDuration, images.powerups.slowMotion)
    self.world = world
    self.gravityModifier = 300
    self.applied = false
end

function slowMotion:update(dt)
    powerup.update(self, dt)
end

function slowMotion:activate()
    powerup.activate(self)
    local x, y = self.world:getGravity()
    local newY = y - self.gravityModifier
    if newY > 0 then
        self.world:setGravity(x, newY)
        self.applied = true
    end
end

function slowMotion:deactivate()
    powerup.deactivate(self)
    if self.applied then
        local x, y = self.world:getGravity()
        self.world:setGravity(x, y + self.gravityModifier)
    end
end

return slowMotion