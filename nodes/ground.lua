local display = require("data/display")

local ground = {
    HEIGHT = 50
}
 
function ground:init(world)
    self.body = love.physics.newBody(world, display.GAME_WIDTH / 2, display.GAME_HEIGHT + self.HEIGHT / 2)
    self.shape = love.physics.newRectangleShape(display.GAME_WIDTH, self.HEIGHT) --make a rectangle with a width of 650 and a height of 50
    self.fixture = love.physics.newFixture(self.body, self.shape) --attach shape to body
    self:setIsBouncable(false)
    self.notifyCollision = {}
end

function ground:update(dt)

end

function ground:render()
    love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
end

function ground:onCollisionWith(fixture, callback)
    self.notifyCollision[fixture] = callback
end

--whether or not to behave as a bouncable ground
function ground:setIsBouncable(state)
    self.isBouncable = state
    if (self.isBouncable) then
        self.body:setY(display.GAME_HEIGHT - self.HEIGHT / 2)
    else
        self.body:setY(display.GAME_HEIGHT + self.HEIGHT / 2)
    end
end

return ground