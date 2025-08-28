--!strict

local Charm = require("../roblox_packages/charm")

local modules = require("./modules")

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
	PlayerAtom = Charm.atom({
		State = {},
		Data = {}
	}),
}

export type self = typeof(clientdata)

function clientdata.AddCharmSyncer(self: self, CharmSyncer: any)
	self.CharmSyncer = CharmSyncer
end

function clientdata.YieldUntilReadReady(self: self)
	local Ready = false
	repeat
		if self.PlayerAtom()["State"] ~= nil and self.PlayerAtom()["Data"] ~= nil then
			if self.PlayerAtom()["State"]["ReadReady"] == true then
				Ready = true
			end
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

function clientdata.InitializeState()
	local _C
	_C = Charm.subscribe(clientdata.PlayerAtom, function(current)
		if current["State"] then
			if current["State"]["ReadReady"] then
				modules:StartInitializeState()
				_C()
			end
		end
	end)
end

return clientdata
