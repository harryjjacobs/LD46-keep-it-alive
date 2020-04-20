local powerup = require("nodes/powerups/powerupbase")
local images = require("data/images")

local solidGround = powerup:create(
    40,
    images.powerups.solidGround
)

function solidGround:update(dt)
    if self.activated then
        
    end
end

return solidGround