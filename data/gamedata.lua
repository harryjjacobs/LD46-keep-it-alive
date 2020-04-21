local gameData = {
    score = 0,
    timeScale = 1,
    powerups = {
        {   -- solid ground effect
            minScore = 4,           --score at which is starts spawning
            chance = 0.2,          --probability of being spawned at any given score
            lifespan = 5,           --how long until despawn if not collected (seconds)
            effectDuration = 10,    --how long the powerup is effective when applied
            entity = "nodes/powerups/solidground",   --the entity to spawn when collected (must have a .create method and :init, :deinit etc)
        },
        {   -- slow motion effect
            minScore = 2,           --score at which is starts spawning
            chance = 0.2,          --probability of being spawned at any given score
            lifespan = 5,           --how long until despawn if not collected (seconds)
            effectDuration = 3,     --how long the powerup is effective when applied
            entity = "nodes/powerups/slowmotion",   --the entity to spawn when collected (must have a .create method and :init, :deinit etc)
        },
        {   -- fast motion effect
            minScore = 10,          --score at which is starts spawning
            chance = 0.3,           --probability of being spawned at any given score
            lifespan = 5,           --how long until despawn if not collected (seconds)
            effectDuration = 3,     --how long the powerup is effective when applied
            entity = "nodes/powerups/fastmotion",   --the entity to spawn when collected (must have a .create method and :init, :deinit etc)
        }
    }
}

function gameData:init()
    self.score = 0
    self.timeScale = 1
end

return gameData