local images = { }

function images:load()
    self.powerups = {
        solidGround = love.graphics.newImage("assets/images/powerups/PowerupGround.png"),
        slowMotion = love.graphics.newImage("assets/images/powerups/PowerupDecreaseGameSpeed.png"),
        fastMotion = love.graphics.newImage("assets/images/powerups/PowerupIncreaseGameSpeed.png")
    }
    self.environment = {
        background = love.graphics.newImage("assets/images/environment/background.png"),
        ground = love.graphics.newImage("assets/images/environment/Ground.png"),
        cloud = love.graphics.newImage("assets/images/environment/Cloud.png")
    }
end

return images