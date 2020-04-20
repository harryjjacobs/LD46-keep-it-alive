local powerup = require("nodes/powerups/powerupbase")
local images = require("data/images")
local gameData = require("data/gamedata")
local inheritance = require("utils/inheritance")

local slowMotion = inheritance:inheritsFrom(powerup)

function slowMotion:init(world, effectDuration)
    powerup.init(self, world, effectDuration, images.powerups.slowMotion)
    self.world = world
end

function slowMotion:update(dt)
    powerup.update(self, dt)
end

function slowMotion:activate()
    powerup.activate(self)
    local newTimeScale = gameData.timeScale * 0.7
    if newTimeScale < 0.3 then
        self.applied = 1
    else
        gameData.timeScale = newTimeScale
        self.applied = newTimeScale
    end
end

function slowMotion:deactivate()
    powerup.deactivate(self)
    gameData.timeScale = gameData.timeScale / self.applied
end

return slowMotion