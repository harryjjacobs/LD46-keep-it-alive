local node = require("nodes/node")
local gameData = require("data/gamedata")

local powerupManager = node:create()

function powerupManager:init(world)
    node.init(self)
    self.world = world
    self.previousScore = gameData.score
    self.despawnTimes = {}
end

function powerupManager:deinit()
    node.deinit(self)
    for i, p in ipairs(self.spawned) do
        p.entity:deinit()
    end
end

function powerupManager:update(dt)
    node.update(self, dt)
    self:checkSpawn()
    self:checkDespawn()
end

function powerupManager:render()
    node.render(self)
end

function powerupManager:checkSpawn()
    --check if score has changed since last tick
    if self.previousScore ~= gameData.score then
        --spawn any new powerups
        for i, p in ipairs(gameData.powerups) do
            if gameData.score >= p.minScore and ((p[maxScore] == nil) or
                (p[maxScore] ~= nil and p[maxScore] == nil)) then
                if love.math.random() < p.chance then
                    self:spawn(p)
                end
            end
        end
    end
    --keep track of previous score to detect score changes
    self.previousScore = gameData.score
end

function powerupManager:checkDespawn()
    --check whether we should despawn any powerups
    for e, t in ipairs(self.despawnTimes) do
        if t >= love.timer.getTime() then
            self:despawn(e)
        end
    end
end

function powerupManager:spawn(powerup)
    local entity = powerup.entity:create()
    entity:init(self.world, powerup.effectDuration)
    node.addChild(self, entity)
    self.despawnTimes[entity] = love.timer.getTime() + powerup.lifespan
end

function powerupManager:despawn(entity)
    e:deinit()
    --remove from tables
    node.removeChild(self, entity)
    self.despawnTimes[e] = nil
end

return powerupManager