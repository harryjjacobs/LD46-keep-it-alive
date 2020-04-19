local bounds = require("utils/boundingbox")
local display = require("data/display")

local textButton = {}

function textButton:create(text, x, y, width, height, font)
    button = {}
    setmetatable(button, self)
    self.__index = self
    button._listeners = {}
    button._text = text
    button._x = x
    button._y = y
    button._width = width
    button._height = height
    button._padding = 5
    button._font = font
    button._backgroundColor = { 0, 0, 0, 0 }    --transparent
    button._foregroundColor = { 1, 1, 1, 1 }    --white
    return button
end

function textButton:render()
    love.graphics.setColor(self._backgroundColor)
    love.graphics.rectangle("fill", self._x, self._y, self._width, self._height)
    love.graphics.setColor(self._foregroundColor)
    love.graphics.setFont(self._font or love.graphics.getFont())
    love.graphics.print(
        self._text,
        self._x + self._padding,
        self._y + self._padding,
        0,  --rotation
        1,  --scale x
        1   --scale y
    )
end

function textButton:update(dt)

end

function textButton:addClickListener(callback)
    table.insert(self._listeners, callback)
end

function textButton:onMousePressed(x, y, button, istouch)
    if button == 1 or istouch then -- left
        if self:isPointInside(display:screen2world(x, y)) then
            for i, cb in ipairs(self._listeners) do
                cb()
            end
        end
    end
end

function textButton:setSize(width, height)
    self._width = width
    self._height = height
end

function textButton:setPosition(x, y)
    self._x = x
    self._y = y
end

function textButton:setText(text)
    self._text = text
    --recalculate text positioning
end

function textButton:setBackgroundColor(color)
    self._backgroundColor = color
end

function textButton:setForegroundColor(color)
    self._foregroundColor = color
end

function textButton:getSize()
    return self._width, self._height
end

function textButton:getPosition()
    return self._x, self._y
end

function textButton:getText()
    return self._text
end

function textButton:getBackgroundColor()
    return self._backgroundColor
end

function textButton:getForegroundColor()
    return self._foregroundColor
end

function textButton:isPointInside(x, y)
    return bounds:isPointWithinBoundingBox({
        { x = self._x, y = self._y },
        { x = self._x + self._width, y = self._y + self._height }
    }, x, y)
end

return textButton