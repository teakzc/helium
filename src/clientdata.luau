--!strict

local Charm = require("../roblox_packages/charm")
local CharmSync = require("../roblox_packages/charm-sync")

type PlayerAtom = {
	State: {},
	Data: {},
}

type Array<T> = { T }
type Dictionary<T> = { [string]: T }

export type Properties = {
	PlayerAtom: Charm.Atom<PlayerAtom>,
	CharmSyncer: any,
}
export type Methods = {
	CreateCharmSyncer: (self: self, ignoreUnhydrated: boolean) -> (),
	GetState: (self: self, Client: Player) -> Dictionary<any>,
	GetData: (self: self, Client: Player) -> Dictionary<any>,
}

export type self = Methods & Properties

local clientdata = {
	PlayerAtom = Charm.atom({
		State = {},
		Data = {},
	}),
} :: self

function clientdata:CreateCharmSyncer(ignoreUnhydrated: boolean)
	CharmSync.client({
		atoms = {
			PlayerAtom = self.PlayerAtom,
		},
		ignoreUnhydrated = ignoreUnhydrated,
	})
end

function clientdata:GetState(Client: Player)
	return self.PlayerAtom()[Client.Name]["State"]
end

function clientdata:GetData(Client: Player)
	return self.PlayerAtom()[Client.Name]["Data"]
end

return clientdata
