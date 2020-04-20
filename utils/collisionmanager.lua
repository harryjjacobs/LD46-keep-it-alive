local collisionManager = {}

function collisionManager:init(world)
    self.world = world
    self.callbacks = {}
    world:setCallbacks(
        function(...)
            self:beginContact(...)
        end,
        function(...)
            self:endContact(...)
        end,
        function(...)
            self:preSolve(...)
        end, 
        function(...)
            self:postSolve(...)
        end
    )
end

function collisionManager:addListener(fixture, callback)
    self.callbacks[fixture] = callback
end

function collisionManager:removeListener(fixture, callback)
    self.callbacks[fixture] = nil
end

function collisionManager:beginContact(a, b, coll)
    if self.callbacks[a] ~= nil then
        self.callbacks[a](a, b, coll)
    elseif self.callbacks[b] ~= nil then
        self.callbacks[b](b, a, coll)
    end
end

--TODO
function collisionManager:endContact(a, b, coll)

end
 
function collisionManager:preSolve(a, b, coll)

end
 
function collisionManager:postSolve(a, b, coll, normalimpulse, tangentimpulse)

end

return collisionManager