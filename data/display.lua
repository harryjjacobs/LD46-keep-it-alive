GAME_WIDTH = 1024
GAME_HEIGHT = 768

-- For maintaining aspect ratio
graphicsTransf = {
    scale = 1.0,
    translation = { x = 0.0, y = 0.0 }
}

function setGraphicsTransformation()
    w, h = love.graphics.getDimensions()
    local scale = math.min(w / GAME_WIDTH, h / GAME_HEIGHT)
    graphicsTransf.translation.x = (w - scale * GAME_WIDTH) / 2
    graphicsTransf.translation.y = (h - scale * GAME_HEIGHT) / 2
    graphicsTransf.scale = scale
end

function world2screen(x, y)
    return  x * graphicsTransf.scale + graphicsTransf.translation.x, 
            y * graphicsTransf.scale + graphicsTransf.translation.y
end

function screen2world(x, y)
    return  (x - graphicsTransf.translation.x) / graphicsTransf.scale, 
            (y - graphicsTransf.translation.y) / graphicsTransf.scale
end