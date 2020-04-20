local node = {
    childNodes = {},
    active = true
}

function node:create()
    obj = {}
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function node:init()
    self.childNodes = {}
    self.active = true
    self.destroyed = false
end

function node:deinit()
    for _, n in ipairs(self.childNodes) do
        if (n.deinit ~= nil) then
            n:deinit()
        end
    end
    self.destroyed = true
end

function node:render()
    for _, n in ipairs(self.childNodes) do
        if (n.render ~= nil) then
            n:render()
        end
    end
end

function node:update(dt)
    for _, n in ipairs(self.childNodes) do
        if (n.update ~= nil) then
            n:update(dt)
        end
    end
end

function node:setActive(active)
    if (self.active == active) then return end
    self.active = active
    for _, n in ipairs(self.childNodes) do
        if (n.setActive ~= nil) then
            n:setActive(active)
        end
    end
end

function node:getActive()
    return self.active
end

function node:addChild(node)
    table.insert(self.childNodes, node)
end

function node:removeChild(node)
    self.childNodes[node] = nil
end

return node