local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)
local TextField = require(ReplicatedStorage.Gui.Components.TextField)

local e = Roact.createElement

local function FormationList(props, _hooks)
	return e("Frame", {
		Name = "RootFrame",
		Size = UDim2.new(0, 400, 1, -2 * props.global.Padding.Interface),
		Position = UDim2.new(0, props.global.Padding.Interface, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = props.global.Colour.Primary,
		BackgroundTransparency = 0.5,
	}, {
		EntityCountTextField = e(TextField, {
			global = props.global,
			Size = 100,
			PlaceholderText = "Number of Guards...",
			ClearTextOnFocus = false,
			ShouldValidateInput = true,
			ValidRange = {
				Min = 0,
				Max = 50,
			},
		}),
	})
end

return Hooks.new(Roact)(FormationList, { defaultProps = {} })
