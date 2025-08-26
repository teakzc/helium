--!strict

local Charm = require("../roblox_packages/charm")

export type PlayerAtom = {
	State: {
		[string]: any,
	},
	Data: {
		[string]: any,
	},
}

type Array<T> = { T }
type Dictionary<T> = { [string]: T }

export type Properties = {
	PlayerAtom: Charm.Atom<PlayerAtom>,
	CharmSyncer: any,
}

local clientdata = {
	PlayerAtom = Charm.atom({}),
}

export type self = typeof(clientdata) & Properties

function clientdata.AddCharmSyncer(self: self, CharmSyncer: any)
	self.CharmSyncer = CharmSyncer
end

function clientdata.YieldUntilReadReady(self: self)
	local Ready = false
	repeat
		if self.PlayerAtom()["State"] ~= nil and self.PlayerAtom()["Data"] ~= nil then
			Ready = true
		else
			task.wait()
		end
	until Ready == true
end

function clientdata.GetState(self: self)
	self:YieldUntilReadReady()
	return self.PlayerAtom()["State"]
end

function clientdata.GetData(self: self)
	self:YieldUntilReadReady()
	return self.PlayerAtom()["Data"]
end

return clientdata
