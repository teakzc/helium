--!strict

local Charm = require("../roblox_packages/charm")

type PlayerAtom = {
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
export type Methods = {
	AddCharmSyncer: (self: self, ignoreUnhydrated: boolean) -> (),
	YieldUntilReadReady: (self: self) -> (),
	GetState: (self: self) -> Dictionary<any>,
	GetData: (self: self) -> Dictionary<any>,
}

export type self = Methods & Properties

local clientdata = {
	PlayerAtom = Charm.atom({}),
} :: self

function clientdata:AddCharmSyncer(CharmSyncer: any)
	self.CharmSyncer = CharmSyncer
end

function clientdata:YieldUntilReadReady()
	local Ready = false
	repeat
		if self.PlayerAtom()["State"] ~= nil and self.PlayerAtom()["Data"] ~= nil then
			Ready = true
		else
			task.wait()
		end
	until Ready == true
end

function clientdata:GetState()
	self:YieldUntilReadReady()
	return self.PlayerAtom()["State"]
end

function clientdata:GetData()
	self:YieldUntilReadReady()
	return self.PlayerAtom()["Data"]
end

return clientdata
