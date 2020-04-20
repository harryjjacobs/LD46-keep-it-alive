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
    for entity, _ in pairs(self.despawnTimes) do
        entity:deinit()
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
                    local exists = false
                    for i, spawned in ipairs(self.childNodes) do
                        print(spawned.id)
                        print(p.entity)
                        if spawned.id == p.entity then
                            exists = true
                            break
                        end
                    end
                    if not exists then
                        self:spawn(p)
                    end
                end
            end
        end
    end
    --keep track of previous score to detect score changes
    self.previousScore = gameData.score
end

function powerupManager:checkDespawn()
    --check whether we should despawn any powerups
    for e, t in pairs(self.despawnTimes) do
        if love.timer.getTime() >= t then
            self:despawn(e)
        end
    end
end

function powerupManager:spawn(powerup)
    local entity = require(powerup.entity):create()
    entity.id = "nodes/powerups/solidground"
    entity:init(self.world, powerup.effectDuration)
    self.despawnTimes[entity] = love.timer.getTime() + powerup.lifespan
    node.addChild(self, entity)
end

function powerupManager:despawn(entity)
    if not entity.activated then entity:deinit() end
    --remove from tables
    node.removeChild(self, entity)
    self.despawnTimes[entity] = nil
end

return powerupManager