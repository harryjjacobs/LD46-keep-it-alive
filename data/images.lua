local images = {
    powerups = {}
}

function images:load()
    self.powerups = {
        solidGround = love.graphics.newImage("assets/images/powerup_solidground.png")
    }
end

return images