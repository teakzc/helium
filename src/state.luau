--!strict

local state: self = {}

export type props = {
    Base: {[string]: any}
}

export type self = typeof(state)

function state.SetBaseState(self: self, Data: {[string]: any})
    Data.ReadReady = true
    self.Base = Data
end

return state
