local display = {
    -- For maintaining aspect ratio
    graphicsTransf = {
        scale = 1.0,
        translation = { x = 0.0, y = 0.0 }
    }
}

--configure game size based on platform
if love.system.getOS() == 'iOS' or love.system.getOS() == 'Android' then
    display.GAME_WIDTH = 900
    display.GAME_HEIGHT = 1792
else
    display.GAME_WIDTH = 1024
    display.GAME_HEIGHT = 768
end

function display:updateTransformation()
    w, h = love.graphics.getDimensions()
    local scale = math.min(w / self.GAME_WIDTH, h / self.GAME_HEIGHT)
    self.graphicsTransf.translation.x = (w - scale * self.GAME_WIDTH) / 2
    self.graphicsTransf.translation.y = (h - scale * self.GAME_HEIGHT) / 2
    self.graphicsTransf.scale = scale
end

function display:world2screen(x, y)
    return  x * self.graphicsTransf.scale + self.graphicsTransf.translation.x, 
            y * self.graphicsTransf.scale + self.graphicsTransf.translation.y
end

function display:screen2world(x, y)
    return  (x - self.graphicsTransf.translation.x) / self.graphicsTransf.scale, 
            (y - self.graphicsTransf.translation.y) / self.graphicsTransf.scale
end

return display