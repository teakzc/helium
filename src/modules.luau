--!strict

local Players = game:GetService("Players")

export type Methods = {
	AddModules: (self: self, ModuleHolder: Instance | Folder) -> (),
	AddTarget: (self: self, Target: string, Fn: (any) -> any) -> (),
	Start: (self: self) -> (),
}

export type Properties = {
	ModuleHolder: Instance | Folder,
	TargettedFunctions: { string },
	TemporaryFunctions: {
		[string]: { [string]: any },
	},
	AddedFunctions: { (any) -> any },
}

export type self = Methods & Properties

local modules = {
	TargettedFunctions = {
		"Initialize",
		"PlayerAdded",
		"PlayerRemoving",
	},
	TemporaryFunctions = {},
	AddedFunctions = {},
} :: self

function modules:AddModules(ModuleHolder: Instance | Folder)
	self.ModuleHolder = ModuleHolder
end

function modules:AddTarget(Target: string, Fn: (TargettedFunctions: { [string]: (any?) -> () }) -> any)
	table.insert(self.TargettedFunctions, Target)
	table.insert(self.AddedFunctions, Fn(self.TemporaryFunctions[Target]))
end

function modules:Start()
	local ModuleHolder = self.ModuleHolder

	for _, Target in self.TargettedFunctions do
		self.TemporaryFunctions[Target] = {}
	end

	for _, Module in ModuleHolder:GetDescendants() do
		if Module:IsA("ModuleScript") then
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
		end
	end

	if self.AddedFunctions ~= {} then
		for _, Function: () -> () in self.AddedFunctions do
			task.spawn(Function)
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

return modules
