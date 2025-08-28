local modules = require("@self/modules")
local serverdata = require("@self/serverdata")
local clientdata = require("@self/clientdata")
local ui = require("@self/ui")
local defaultcomponents = require("@self/defaultcomponents")
local state = require("@self/state")

return {
	modules = modules,
	serverdata = serverdata,
	clientdata = clientdata,
	ui = ui,
	defaultcomponents = defaultcomponents,
	state = state
}
