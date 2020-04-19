require("entities/powerups/solidground")

local gameData = {
    score = 0,
    powerups = {
        {
            minScore = 5,           --score at which is starts spawning
            maxScore = 10,          --score at which it stops spawning (optional)
            chance = 0.5,           --probability of being spawned at any given score
            lifespan = 5,           --how long until despawn if not collected (seconds)
            effectDuration = 5,     --how long the powerup is effective when applied
            entity = solidGround,   --the entity to spawn when collected (must have a .create method and :init, :deinit etc)
        }
    }
}

function gameData:init()
    self.score = 0
end

return gameData