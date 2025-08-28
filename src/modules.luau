--!strict

local Players = game:GetService("Players")

local modules = {
	TargettedFunctions = {
		"Initialize",
		"InitializeState",
		"PlayerAdded",
		"PlayerRemoving",
	},
	TemporaryFunctions = {},
	AddedFunctions = {},
}

export type modules = typeof(modules)

function modules.AddModules(self: modules, ModuleHolder: Instance | Folder)
	self.ModuleHolder = ModuleHolder
end

function modules.AddTarget(self: modules, Target: string, Fn: {Connect: (any, (any) -> ()) -> ()})
	table.insert(self.TargettedFunctions, Target)
	self.AddedFunctions[Target] = Fn
end

function modules.Start(self: modules)
	local ModuleHolder = self.ModuleHolder

	for _, Target in self.TargettedFunctions do
		self.TemporaryFunctions[Target] = {} --Setting table to store functions for each "TargettedFunctions"
	end

	local Count, Tally = 0, 0

	for _, Module in ModuleHolder:GetDescendants() do
		if Module:IsA("ModuleScript") then

			Count += 1

			task.spawn(function()
				local success, err = pcall(function()
					local RequiredModule = require(Module) :: any
					for _, Target in self.TargettedFunctions do
						if RequiredModule[Target] then
							self.TemporaryFunctions[Target][Module.Name] = RequiredModule[Target]
						end
					end
				end)

				if not success then
					warn(Module.Name .. " has errored! " .. tostring(err))
				end

				Tally += 1
			end)
		end
	end

	repeat
		task.wait()
	until Tally == Count

	if self.AddedFunctions ~= {} then
		for Name, Connection in self.AddedFunctions do
			Connection:Connect(function(...)
				local Args = { ... }
				for _, Function in self.TemporaryFunctions[Name] do
					task.spawn(function()
						Function(unpack(Args))
					end)
				end
			end)
		end
	end

	for Name, Function: () -> () in self.TemporaryFunctions["Initialize"] do
		task.spawn(function()
			local StartTime = os.clock()
			Function()
			local RoundedTime = math.round((os.clock() - StartTime) * 100) / 100
			print(string.format(Name .. " took [%s] ms to load!", RoundedTime))
		end)
	end

	Players.PlayerAdded:Connect(function(Client: Player)
		for _, Function: (Client: Player) -> () in self.TemporaryFunctions["PlayerAdded"] do
			task.spawn(function()
				Function(Client)
			end)
		end
	end)

	Players.PlayerRemoving:Connect(function(Client: Player)
		for _, Function: (Client: Player) -> () in self.TemporaryFunctions["PlayerRemoving"] do
			task.spawn(function()
				Function(Client)
			end)
		end
	end)
end

function modules.StartInitializeState(self: modules)
	for Name, Function: () -> () in self.TemporaryFunctions["InitializeState"] do
		task.spawn(function()
			local StartTime = os.clock()
			Function()
			local RoundedTime = math.round((os.clock() - StartTime) * 100) / 100
			print(string.format(Name .. " took [%s] ms to load!", RoundedTime))
		end)
	end
end

return modules
