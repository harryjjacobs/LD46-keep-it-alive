local powerup = require("nodes/powerups/powerupbase")
local ground = require("nodes/ground")
local images = require("data/images")
local inheritance = require("utils/inheritance")

local solidGround = inheritance:inheritsFrom(powerup)

function solidGround:init(world, effectDuration)
    powerup.init(self, world, effectDuration, images.powerups.solidGround)
end

function solidGround:update(dt)
    powerup.update(self, dt)
    if self.activated then
        ground:setAlpha(self.activeTimeRemaining / self.effectDuration)
    end
end

function solidGround:activate()
    print("ACTIVATE")
    powerup.activate(self)
    ground:setIsBouncable(true)
end

function solidGround:deactivate()
    powerup.deactivate(self)
    ground:setIsBouncable(false)
end

return solidGround