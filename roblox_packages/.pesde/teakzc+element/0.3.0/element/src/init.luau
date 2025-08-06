--!strict

local ObjectCache = require("./roblox_packages/objectcache")

local element = {}

local CachedTable = {}
local CachedTable2 = {}

local CustomCache = {} :: Self
CustomCache.__index = CustomCache

export type Methods = {
	SetCache: (self: element, Template: BasePart | Model, CacheSize: number) -> (),
	Return: (self: element, Part: Instance) -> (),
	Clone: (self: element, Part: Instance, NewCFrame: CFrame?) -> Instance,
	CreateCustomCache: (Part: Instance) -> MetaSelf,
}

export type Properties = {}
export type element = Methods & Properties

--[=[
    @function CreateCustomCache
    @param Part Instance
    Creates a custom cache independant of objectcache to store non physical objects.
]=]
function element.CreateCustomCache(Part: Instance): MetaSelf
	local self = setmetatable({
		Part = Part,
		Storage = {},
		Usage = {},
	}, CustomCache) :: MetaSelf

	if workspace:FindFirstChild("Container") == nil then
		local Container = Instance.new("Folder")
		Container.Name = "Container"
		Container.Parent = workspace
	end

	local Folder = Instance.new("Folder")
	Folder.Parent = workspace.Container
	Folder.Name = Part.Name .. "Cache"

	self.CacheFolder = Folder

	for i = 1, 10 do
		local Clone = Part:Clone()
		Clone.Parent = Folder
		table.insert(self.Storage, Clone)
	end

	return self
end

--[=[
    @function SetCache
    @param Template Basepart | Model
    @param CacheSize number

    Creates a objectcache based on the template.
]=]
function element:SetCache(Template: BasePart | Model, CacheSize: number)
	if workspace:FindFirstChild("Container") == nil then
		local Container = Instance.new("Folder")
		Container.Name = "Container"
		Container.Parent = workspace
	end

	CachedTable[Template.Name] = ObjectCache.new(Template, CacheSize, workspace.Container)
end

--[=[
    @function Return
    @param Part Instance

    Returns the part given to the cache, if part is a basepart or model and cache doesn't exist then errors. Else if part is not a basepart or model it creates a custom cache and stores it.
]=]
function element:Return(Part: Instance)
	if Part:IsA("BasePart") or Part:IsA("Model") then
		local Cache: nil | any = CachedTable[Part.Name]
		if Cache ~= nil then
			Cache:ReturnPart(Part);

			(Part :: any).Parent = Cache.CacheHolder
		else
			error("Returning a part without a cache!")
		end
	else
		local Cache: nil | any = CachedTable2[Part.Name]
		if Cache == nil then
			CachedTable2[Part.Name] = element.CreateCustomCache(Part)
		end

		CachedTable2[Part.Name]:Return(Part)
	end
end

--[=[
    @function Clone
    @param Part Instance
    @param NewCFrame CFrame?

    If part is a BasePart or Model then it will return a part from the cache, if cache doesn't exist it creates one for you.
    If parts dont meet the requirements it uses a custom cache instead.
]=]
function element:Clone(Part: Instance, NewCFrame: CFrame?): Instance
	if Part:IsA("BasePart") or Part:IsA("Model") then
		local Cache: nil | any = CachedTable[Part.Name]
		if Cache == nil then
			element:SetCache(Part, 10)
		end

		return CachedTable[Part.Name]:GetPart(NewCFrame)
	else
		local Cache: nil | any = CachedTable2[Part.Name]
		if Cache == nil then
			CachedTable2[Part.Name] = element.CreateCustomCache(Part)
		end

		return CachedTable2[Part.Name]:Clone()
	end
end

export type Self = {
	Part: Instance,
	Storage: { Instance },
	Usage: { Instance },
	CacheFolder: Instance?,
	Clone: (self: Self) -> Instance,
	Return: (self: Self, Part: Instance) -> (),
	__index: any,
}

local function GetType()
	return setmetatable({}, CustomCache)
end
type MetaSelf = typeof(GetType())

--[=[
    @function Clone
    Returns a instance of the custom cache.
]=]
function CustomCache:Clone(): Instance
	if #self.Storage > 0 then
		local Clone: Instance = self.Part:Clone()
		Clone.Parent = self.CacheFolder
		table.insert(self.Usage, Clone)

		return Clone
	else
		local Clone: Instance = self.Storage[1]

		table.insert(self.Usage, Clone)
		self.Storage[1] = nil

		return Clone
	end
end

--[=[
    @function Return
    @param Part Instance
    @error Part.Name.." does not belong to this cache!"
    Returns the instance to the custom cache.
]=]
function CustomCache:Return(Part: Instance)
	local Index = table.find(self.Usage, Part)

	if Index then
		self.Usage[Index] = nil
		table.insert(self.Storage, Part)
		Part.Parent = self.CacheFolder
	else
		error(Part.Name .. " does not belong to this cache!")
	end
end

return element
