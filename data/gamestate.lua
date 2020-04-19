local state = nil

local gameState = {
    MENU = 0,
    PAUSED = 1,
    PLAYING = 2,
    GAME_OVER = 3,
    transitionListeners = {}
}

function gameState:get()
    return state
end

function gameState:set(newState)
    local oldState = state
    state = newState

    if self.transitionListeners[oldState] ~= nil and 
       self.transitionListeners[oldState][newState] ~= nil then
        for i, cb in ipairs(self.transitionListeners[oldState][newState]) do
            cb()
        end
    end
end

function gameState:reset()
    self.transitionListeners = {}
    state = self.MENU
end

function gameState:addChangeListener(from, to, callback)
    if self.transitionListeners[from] == nil then
        self.transitionListeners[from] = {}
    end
    if self.transitionListeners[from][to] == nil then
        self.transitionListeners[from][to] = {}
    end
    table.insert(self.transitionListeners[from][to], callback)
end

return gameState