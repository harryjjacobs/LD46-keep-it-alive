local display = require("data/display")
local gameData = require("data/gamedata")
local node = require("nodes/node")

local ball = node:create()
 
function ball:init(world)
    node.init(self)
    self.body = love.physics.newBody(world, display.GAME_WIDTH/2, display.GAME_HEIGHT/3, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
    self.shape = love.physics.newCircleShape(50) --the ball's shape has a radius of 20
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 0.1.
    self.fixture:setRestitution(0.9) --let the ball bounce
    self.image = love.graphics.newImage("assets/images/balls/Ball.png")
end

function ball:update(dt)
    node.update(self, dt)
    --wrap position around screen
    if self.body:getX() < 0 then
        self.body:setPosition(display.GAME_WIDTH, self.body:getY())
    elseif self.body:getX() > display.GAME_WIDTH then
        self.body:setPosition(0, self.body:getY())
    end
end

function ball:render()
    node.render(self)
    love.graphics.setColor(1, 1, 1) --set the drawing color to red for the ball
    love.graphics.draw(ball.image, self.body:getX(), self.body:getY(), self.body:getAngle(), 0.084, 0.084, ball.image:getWidth()/2, ball.image:getHeight()/2)
    --love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
end

function ball:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left
        if self.fixture:testPoint(display:screen2world(x, y)) then
            local velX, velY = self.body:getLinearVelocity()
            local posX, posY = display:world2screen(self.body:getPosition())
            velX = (posX - x) / display.graphicsTransf.scale * 10
            velY = -600
            self.body:setLinearVelocity(velX, velY)
            self.body:setAngularVelocity(velX * 0.08)
            gameData.score = gameData.score + 1
        end
    end
end

return ball