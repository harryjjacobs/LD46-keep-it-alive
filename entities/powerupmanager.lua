local gameData = require "data/gamedata"

local powerupManager = {}

function powerupManager:init(world)
    self.world = world
    self.previousScore = gameData.score
    self.despawnTimes = {}
    self.renderable = {}
    self.active = {}
end

function powerupManager:deinit()
    for i, p in ipairs(self.spawned) do
        p.entity:deinit()
    end
end

function powerupManager:update(dt)
    self:checkSpawn()
    self:checkDespawn()
end

function powerupManager:render()
    for i, e in ipairs(self.renderable) do
        e:render()
    end
end

function powerupManager:updateActive()

end

function powerupManager:checkSpawn()
    --check if score has changed since last tick
    if self.previousScore ~= gameData.score then
        --spawn any new powerups
        for i,p in ipairs(gameData.powerups) do
            if p.minScore >= gameData.score and 
                p[maxScore] ~= nil and p.maxScore < gameData.score then
                if love.math.random() < p.chance then
                    local entity = p.entity.create()
                    entity:init(self.world)
                    entity.onActivate = function()
                        table.insert(self.active, entity)
                    end
                    entity.onDectivate = function()
                        self.active[entity] = nil
                    end
                    self.despawnTimes[entity] = love.timer.getTime() + p.lifespan
                    table.insert(self.renderable, entity)
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
            e:deinit()
            --remove from tables
            self.despawnTimes[e] = nil
            self.renderable[e] = nil
        end
    end
end

return powerupManager