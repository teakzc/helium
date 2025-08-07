--!strict

local Charm = require("../roblox_packages/charm")
local CharmSync = require("../roblox_packages/charm-sync")

type PlayerAtom = {
	State: {
		[string]: any
	},
	Data: {
		[string]: any
	},
}


type Array<T> = { T }
type Dictionary<T> = { [string]: T }

export type Properties = {
	PlayerAtom: Charm.Atom<PlayerAtom>,
	CharmSyncer: any,
}
export type Methods = {
	CreateCharmSyncer: (self: self, ignoreUnhydrated: boolean) -> (),
	YieldUntilReadReady: (self: self, Client: Player) -> (),
	GetState: (self: self, Client: Player) -> Dictionary<any>,
	GetData: (self: self, Client: Player) -> Dictionary<any>,
}

export type self = Methods & Properties

local clientdata = {
	PlayerAtom = Charm.atom({}),
} :: self

function clientdata:CreateCharmSyncer(ignoreUnhydrated: boolean)
	CharmSync.client({
		atoms = {
			PlayerAtom = self.PlayerAtom,
		},
		ignoreUnhydrated = ignoreUnhydrated,
	})
end

function clientdata:YieldUntilReadReady(Client: Player)
	local Ready = false
	repeat
		if self.PlayerAtom()["State"] ~= nil and self.PlayerAtom()["Data"] ~= nil then
			Ready = true
		else
			task.wait()
		end
	until Ready == true
end

function clientdata:GetState(Client: Player)
	self:YieldUntilReadReady(Client)
	return self.PlayerAtom()["State"]
end

function clientdata:GetData(Client: Player)
	self:YieldUntilReadReady(Client)
	return self.PlayerAtom()["Data"]
end

return clientdata
