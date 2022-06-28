local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local Roact = require(ReplicatedStorage.Packages.Roact)

local Gui = ReplicatedStorage.Gui
local GlobalProperties = require(Gui.GlobalProperties)
local FormationList = require(Gui.App.FormationList)

local UIController = Knit.CreateController({ Name = "UIController" })

local function App(props)
	return Roact.createElement("ScreenGui", props, {
		FormationList = FormationList,
	})
end

function UIController:KnitStart()
	Roact.mount(Roact.createElement(App, GlobalProperties), Knit.Player.PlayerGui)
end

function UIController:KnitInit()
	self.RootPart = Knit.RootPart
	self.Camera = workspace.CurrentCamera

	self.Camera.CameraSubject = self.RootPart
	self.Camera.CameraType = Enum.CameraType.Custom
end

return UIController
