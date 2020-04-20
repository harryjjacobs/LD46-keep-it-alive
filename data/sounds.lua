local sounds = {
    powerups = {}
}

function images:load()
    self.powerups = {
        slowMotionActivate = love.graphics.newImage("assets/sounds/powerups/SlowMotionActivate.png")
        slowMotionDectivate = love.graphics.newImage("assets/sounds/powerups/SlowMotionDectivate.png")
    }
end

return sounds