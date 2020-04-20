solidGround = require("nodes/powerups/solidground")
slowMotion = require("nodes/powerups/slowmotion")

local gameData = {
    score = 0,
    powerups = {
        {   -- solid ground effect
            minScore = 2,           --score at which is starts spawning
            chance = 0.05,          --probability of being spawned at any given score
            lifespan = 5,           --how long until despawn if not collected (seconds)
            effectDuration = 10,    --how long the powerup is effective when applied
            entity = solidGround,   --the entity to spawn when collected (must have a .create method and :init, :deinit etc)
        },
        {   -- slow motion effect
            minScore = 0,           --score at which is starts spawning
            chance = 0.1,           --probability of being spawned at any given score
            lifespan = 5,           --how long until despawn if not collected (seconds)
            effectDuration = 5,     --how long the powerup is effective when applied
            entity = slowMotion,   --the entity to spawn when collected (must have a .create method and :init, :deinit etc)
        }
    }
}

function gameData:init()
    self.score = 0
end

return gameData