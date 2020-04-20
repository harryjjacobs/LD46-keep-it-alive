local display = require("data/display")
local node = require("nodes/node")

local ground = node:create()

ground.HEIGHT = 100
 
function ground:init(world)
    self.body = love.physics.newBody(world, display.GAME_WIDTH / 2, display.GAME_HEIGHT + self.HEIGHT / 2)
    self.shape = love.physics.newRectangleShape(display.GAME_WIDTH, self.HEIGHT) --make a rectangle with a width of 650 and a height of 50
    self.fixture = love.physics.newFixture(self.body, self.shape) --attach shape to body
    self.alpha = 1.0
    self.image = love.graphics.newImage("assets/images/environment/Ground.png")
    self:setIsBouncable(false)
end

function ground:render()
    node.render(self)
    love.graphics.setColor(0.28, 0.63, 0.05, self.alpha) -- set the drawing color to green for the ground
    if self.isBouncable then
        love.graphics.draw(self.image, 0, self.body:getY() - 140, 0, 0.45, 0.4, 0, 0)
    end
    --love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates
end

--whether or not to behave as a bouncable ground
function ground:setIsBouncable(state)
    self.isBouncable = state
    if self.isBouncable then
        self.body:setY(display.GAME_HEIGHT - self.HEIGHT / 2)
    else
        self.body:setY(display.GAME_HEIGHT + self.HEIGHT / 2)
    end
end

function ground:setAlpha(alpha)
    self.alpha = alpha
end

return ground