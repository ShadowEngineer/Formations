local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local FormationList = require(ReplicatedStorage.Gui.App.FormationList)
local GlobalProperties = require(ReplicatedStorage.Gui.GlobalProperties)

return function(target)
	local handle = Roact.mount(Roact.createElement(FormationList, { global = GlobalProperties }), target)

	return function()
		Roact.unmount(handle)
	end
end
