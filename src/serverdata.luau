--!strict

local Players = game:GetService("Players")

local Lyra = require("../roblox_packages/lyra")
local Charm = require("../roblox_packages/charm")
local Immut = require("../roblox_packages/immut")

local state = require("./state")

type PlayerAtom = {
	[string]: {
		State: {
			[string]: any,
		},
		Data: {
			[string]: any,
		},
	},
}

type Array<T> = { T }
type Dictionary<T> = { [string]: T }

export type Properties = {
	Store: any,
	PlayerAtom: Charm.Atom<PlayerAtom>,
	FunctionsToRun: { (Player: string, NewData: {}, OldData: {}) -> () },
	CharmSyncer: any,
}

local serverdata = {
	PlayerAtom = Charm.atom({}),
	FunctionsToRun = {},
}

export type self = typeof(serverdata) & Properties

type CharmSyncProperties = {
	interval: number?,
	preserveHistory: boolean?,
	autoSerialize: boolean?,
}

function serverdata.AddCharmSyncer(self: self, CharmSyncer: any)
	self.CharmSyncer = CharmSyncer
end

function serverdata.LyraCharmSync(self: self, Key: string, NewData: {}, OldData: {})
	local Player = Players:GetNameFromUserIdAsync(tonumber(Key))

	if not Player then
		return
	end

	self.PlayerAtom(Immut.produce(self.PlayerAtom(), function(draft)
		if draft[Player] ~= nil then
			draft[Player]["Data"] = NewData
			return draft
		else
			return draft
		end
	end))
end

function serverdata.HandleLogs(message)
	-- Handle based on severity
	if message.level == "fatal" then
		-- Unrecoverable errors (e.g., corrupted data)
		warn("FATAL:", message.message)
	elseif message.level == "error" then
		-- Operation failures (e.g., update failed)
		warn("Error:", message.message)
	elseif message.level == "warn" then
		-- Potential issues (e.g., slow operations)
		warn("Warning:", message.message)
	elseif message.level == "info" then
		-- Important operations (e.g., session started)
		print("Info:", message.message)
	elseif message.level == "debug" then
		-- Detailed operation info
		print("Debug:", message.message)
	elseif message.level == "trace" then
		-- Very detailed debugging info
		print("Trace:", message.message)
	end
end

function serverdata.OpenStore(self: self, StoreConfigs: Dictionary<any>)
	local Store = Lyra.createPlayerStore(StoreConfigs)

	self.Store = Store

	Players.PlayerAdded:Connect(function(Client: Player)
		self.Store:loadAsync(Client)

		self.PlayerAtom(Immut.produce(self.PlayerAtom(), function(draft)
			draft[Client.Name] = {
				Data = {},
				State = state.Base
			}
			return draft
		end))
	end)

	Players.PlayerRemoving:Connect(function(Client: Player)
		self.Store:unloadAsync(Client)

		self.PlayerAtom(Immut.produce(self.PlayerAtom(), function(draft)
			draft[Client.Name] = nil
			return draft
		end))
	end)

	game:BindToClose(function()
		self.Store:closeAsync()
	end)
end

function serverdata.YieldUntilWriteReady(self: self, Client: Player)
	local Ready = false
	repeat
		if self.PlayerAtom()[Client.Name] then
			Ready = true
		else
			task.wait()
		end
	until Ready == true
end

function serverdata.SetState(self: self, Client: Player, Callback: (draft: Dictionary<any>) -> ())
	self:YieldUntilWriteReady(Client)
	self.PlayerAtom(Immut.produce(self.PlayerAtom(), function(draft)
		Callback(draft[Client.Name]["State"])
		return draft
	end))
end

function serverdata.GetState(self: self, Client: Player)
	self:YieldUntilWriteReady(Client)
	return self.PlayerAtom()[Client.Name]["State"]
end

function serverdata.GetStore(self: self)
	return self.Store
end

function serverdata.UpdateAsync(self: self, Client: Player, Callback: (data: any) -> boolean)
	self.Store:updateAsync(Client, function(data)
		return Callback(data)
	end)
end

function serverdata.UpdateImmutableAsync(self: self, Client: Player, Callback: (data: any) -> boolean | any)
	self.Store:updateImmutableAsync(Client, function(data)
		return Callback(data)
	end)
end

function serverdata.txAsync(self: self, Client1: Player, Client2: Player, Callback: ({ [string]: any }) -> boolean)
	self.Store:txAsync({ Client1, Client2 }, function(state)
		return Callback(state)
	end)
end

function serverdata.txImmutableAsync(self: self, Client1: Player, Client2: Player, Callback: ({ [string]: any }) -> boolean | any)
	self.Store:txImmutableAsync({ Client1, Client2 }, function(state)
		return Callback(state)
	end)
end

return serverdata :: self
