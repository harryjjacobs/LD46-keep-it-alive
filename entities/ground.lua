local display = require("data/display")

local ground = {}
 
function ground:init(world)
    self.body = love.physics.newBody(world, display.GAME_WIDTH / 2, display.GAME_HEIGHT - 50 / 2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
    self.shape = love.physics.newRectangleShape(display.GAME_WIDTH, 50) --make a rectangle with a width of 650 and a height of 50
    self.fixture = love.physics.newFixture(self.body, self.shape) --attach shape to body
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

return ground