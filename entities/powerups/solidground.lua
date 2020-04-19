local powerup = require("entities/powerups/powerupbase")
local images = require("data/images")

local solidGround = powerup:create(
    40,
    images.powerups.solidGround
)

function solidGround:update(dt)
    --called when the powerup has been activated
end

return solidGround