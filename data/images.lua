local images = {
    powerups = {}
}

function images:load()
    self.powerups = {
        solidGround = love.graphics.newImage("assets/images/powerups/PowerupGround.png"),
        slowMotion = love.graphics.newImage("assets/images/powerups/PowerupDecreaseGameSpeed.png")
    }
end

return images