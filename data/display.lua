display = {
    GAME_WIDTH = 1024,
    GAME_HEIGHT = 768,

    -- For maintaining aspect ratio
    graphicsTransf = {
        scale = 1.0,
        translation = { x = 0.0, y = 0.0 }
    },
    
    updateTransformation = function()
        w, h = love.graphics.getDimensions()
        local scale = math.min(w / display.GAME_WIDTH, h / display.GAME_HEIGHT)
        display.graphicsTransf.translation.x = (w - scale * display.GAME_WIDTH) / 2
        display.graphicsTransf.translation.y = (h - scale * display.GAME_HEIGHT) / 2
        display.graphicsTransf.scale = scale
    end,

    world2screen = function(x, y)
        return  x * display.graphicsTransf.scale + display.graphicsTransf.translation.x, 
                y * display.graphicsTransf.scale + display.graphicsTransf.translation.y
    end,

    screen2world = function(x, y)
        return  (x - display.graphicsTransf.translation.x) / display.graphicsTransf.scale, 
                (y - display.graphicsTransf.translation.y) / display.graphicsTransf.scale
    end
}