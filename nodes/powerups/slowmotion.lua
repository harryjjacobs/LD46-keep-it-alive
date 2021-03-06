local powerup = require("nodes/powerups/powerupbase")
local images = require("data/images")
local sounds = require("data/sounds")
local gameData = require("data/gamedata")
local inheritance = require("utils/inheritance")

local slowMotion = inheritance:inheritsFrom(powerup)
local AMOUNT = 0.2

function slowMotion:init(world, effectDuration)
    powerup.init(self, world, effectDuration, images.powerups.slowMotion)
    self.world = world
    self.playedDeactivationSound = false
end

function slowMotion:update(dt)
    powerup.update(self, dt)

    if self.activated then
        if not self.playedDeactivationSound and self.activeTimeRemaining / self.effectDuration < 0.5 then
            love.audio.play(sounds.powerups.slowMotionDectivate:clone())
            self.playedDeactivationSound = true
        end
    end
end

function slowMotion:activate()
    powerup.activate(self)
    love.audio.play(sounds.powerups.slowMotionActivate:clone())
    local newTimeScale = gameData.timeScale - AMOUNT
    if newTimeScale < 0.3 then
        self.applied = 1
    else
        gameData.timeScale = newTimeScale
        self.applied = AMOUNT
    end
end

function slowMotion:deactivate()
    powerup.deactivate(self)
    gameData.timeScale = gameData.timeScale + self.applied
end

return slowMotion