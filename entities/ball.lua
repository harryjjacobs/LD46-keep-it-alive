require("data/display")

ball = {}
 
function ball:init(world)
    self.body = love.physics.newBody(world, GAME_WIDTH/2, GAME_HEIGHT/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
    self.shape = love.physics.newCircleShape(40) --the ball's shape has a radius of 20
    self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 0.1.
    self.fixture:setRestitution(0.9) --let the ball bounce
end

function ball:update(dt)
    --wrap position around screen
    if self.body:getX() < 0 then
        self.body:setPosition(GAME_WIDTH, self.body:getY())
    elseif self.body:getX() > GAME_WIDTH then
        self.body:setPosition(0, self.body:getY())
    end
end

function ball:render()
    love.graphics.setColor(0.76, 0.18, 0.05) --set the drawing color to red for the ball
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.shape:getRadius())
end

function ball:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left
        if self.fixture:testPoint(screen2world(x, y)) then
            local velX, velY = self.body:getLinearVelocity()
            local posX, posY = world2screen(self.body:getPosition())
            velX = (posX - x) * graphicsTransf.scale * 10
            velY = -600
            self.body:setLinearVelocity(velX, velY)
        end
    end
end