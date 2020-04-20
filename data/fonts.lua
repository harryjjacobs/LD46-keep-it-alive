local fonts = {}

function fonts:load()
    self.small = love.graphics.newFont("assets/fonts/Raleway-Regular.ttf", 32)
    self.medium = love.graphics.newFont("assets/fonts/Raleway-Regular.ttf", 64)
    self.large = love.graphics.newFont("assets/fonts/Raleway-Regular.ttf", 120)
end

return fonts