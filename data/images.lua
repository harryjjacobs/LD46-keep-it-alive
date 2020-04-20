local images = {
    powerups = {}
}

function images:load()
    self.powerups = {
        solidGround = love.graphics.newImage("assets/images/powerups/PowerupGround.png"),
        slowMotion = love.graphics.newImage("assets/images/powerups/PowerupDecreaseGameSpeed.png")
    }
    self.environment = {
        ground = love.graphics.newImage("assets/images/environment/Ground.png"),
        cloud = love.graphics.newImage("assets/images/environment/Cloud.png")
    }
end

return images