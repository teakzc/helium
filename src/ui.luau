--!strict

local clientdata = require("./clientdata")

local Fusion = require("../roblox_packages/fusion")
local Charm = require("../roblox_packages/charm")

local Children, OnEvent = Fusion.Children, Fusion.OnEvent
local Subscribe = Charm.subscribe

type Array<T> = {T}
type Dictionary<T> = {[string]: T}

export type Methods = {
	CreateObject: (
        Scope: Fusion.Scope<typeof(Fusion)>,
	    Object: string,
        Props: Dictionary<any>?,
        Child: Array<any>?,
        Events: Dictionary<any>?
    ) -> (Instance),
}

export type Properties = {}

export type self = Methods & Properties

--[=[
    @class ui

    Controls all client UI using fusion and charm.
]=]
local ui = {} --:: self

--[=[
    @function CreateObject
    @param Scope Fusion.Scope<typeof(Fusion)> The scope to be used
	@param Object string The name of a instance to be created
    @param Props Dictionary<any>? Properties to be applied onto the new instance
    @param Child Array<any>? You can put more ui.CreateObject in here to be parented to the new instance
    @param Events Dictionary<any> You can put events here to control effects.
    @within ui
    @return Instance
]=]
function ui.CreateObject(
	Scope: Fusion.Scope<typeof(Fusion)>,
	Object: string,
	Props: Dictionary<any>?,
	Child: Array<any>?,
	Events: Dictionary<any>?
): Instance
	local Properties = {
		[Children] = {},
	}

	if Events ~= nil then
		for Event, Function in Events do
			Properties[OnEvent(Event)] = Function
		end
	end

	if Child ~= nil then
		for _, Function in Child do
			table.insert(Properties[Children], Function)
		end
	end

	local UI: Instance = Scope:New(Object)(Properties)

	if Props ~= nil then
		for Property: string, Value: any in Props do
			if (UI :: any)[Property] then
                (UI :: any)[Property] = Value
            else
                warn(UI.Name.." does not have "..Property.." as a property.")
			end
		end
	end

	return UI
end

function ui.CreateCharmValue<T>(
	Scope: Fusion.Scope<typeof(Fusion)>,
	SelectState: (State: Dictionary<any>) -> (T)
): Fusion.Value<T>
	local StateAtom = clientdata.PlayerAtom

	local Value = Scope:Value(
		SelectState(StateAtom())
	)

	print("My new value is ", SelectState(StateAtom()))

	local CleanUp = Subscribe(StateAtom, function(CurrentState: any, PreviousState: any)
		if CurrentState ~= PreviousState then
			Value:set(
				SelectState(CurrentState)
			)
		end
	end)

	table.insert(Scope, CleanUp)

	return Value
end

return ui
