local inheritance = require("utils/inheritance")
local node = require("nodes/node")
local display = require("data/display")
local images = require("data/images")

local clouds = inheritance:inheritsFrom(node)

local MAX_CLOUD_WIDTH = 200
local MIN_CLOUD_SCALE = 0.1
local MAX_CLOUD_SCALE = 0.3
local NUM_CLOUDS = 7
local MAX_CLOUD_Y = display.GAME_HEIGHT * 0.3
local MIN_VELOCITY = 0.5
local MAX_VELOCITY = 2

cloud = {
    x = 0,
    y = 0,
    scale = 1,
    velocity = 0
}

function cloud:create(x, y, scale, velocity)
    c = {}
    setmetatable(c, cloud)
    cloud.__index = cloud
    c.x = x
    c.y = y
    c.scale = scale
    c.velocity = velocity
    return c
end

function clouds:init()
    node.init(self)
    self.clouds = {}

    for i = 1, NUM_CLOUDS do
        local x, y = self:randomCloudPosition()
        table.insert(self.clouds, cloud:create(
            x,
            y,
            self:randomCloudScale(),
            self:randomCloudVelocity(self:randomCloudDirection())
        ))
    end
end

function clouds:update(dt)
    node.update(self, dt)
    for i, cloud in ipairs(self.clouds) do

        if self:isOutsideVisibleArea(cloud) then
            if cloud.velocity > 0 then
                cloud.velocity = self:randomCloudVelocity(-1)
            elseif cloud.velocity < 0 then
                cloud.velocity = self:randomCloudVelocity(1)
            end
        end

        cloud.x = cloud.x + cloud.velocity
    end
end

function clouds:render()
    node.render(self)
    for i, cloud in ipairs(self.clouds) do
        love.graphics.draw(images.environment.cloud, cloud.x, cloud.y, 0, cloud.scale, cloud.scale, 0, 0)
    end
end

function clouds:isOutsideVisibleArea(cloud)
    return (cloud.x < MAX_CLOUD_WIDTH) or cloud.x > (display.GAME_WIDTH + MAX_CLOUD_WIDTH)
end

function clouds:randomCloudPosition()
    return love.math.random(-MAX_CLOUD_WIDTH, display.GAME_WIDTH + MAX_CLOUD_WIDTH),
            love.math.random(0, MAX_CLOUD_Y)
end

function clouds:randomCloudScale()
    return love.math.random(MIN_CLOUD_SCALE, MAX_CLOUD_SCALE)
end

function clouds:randomCloudVelocity(direction)
    return direction * love.math.random(MIN_VELOCITY, MAX_VELOCITY)
end

function clouds:randomCloudDirection()
    if love.math.random() < 0.5 then
        return -1
    else
        return 1
    end
end

return clouds