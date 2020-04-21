local powerup = require("nodes/powerups/powerupbase")
local images = require("data/images")
local gameData = require("data/gamedata")
local sounds = require("data/sounds")
local inheritance = require("utils/inheritance")

local fastMotion = inheritance:inheritsFrom(powerup)

local AMOUNT = 0.7

function fastMotion:init(world, effectDuration)
    powerup.init(self, world, effectDuration, images.powerups.fastMotion)
    self.world = world
end

function fastMotion:update(dt)
    powerup.update(self, dt)

    if self.activated then
        if not self.playedDeactivationSound and self.activeTimeRemaining / self.effectDuration < 0.5 then
            love.audio.play(sounds.powerups.slowMotionDectivate:clone())
            self.playedDeactivationSound = true
        end
    end
end

function fastMotion:activate()
    powerup.activate(self)
    love.audio.play(sounds.powerups.slowMotionDectivate:clone())

    local newTimeScale = gameData.timeScale + AMOUNT
    if newTimeScale > 3 then
        self.applied = 1
    else
        gameData.timeScale = newTimeScale
        self.applied = AMOUNT
    end
end

function fastMotion:deactivate()
    powerup.deactivate(self)
    gameData.timeScale = gameData.timeScale - self.applied
end

return fastMotion