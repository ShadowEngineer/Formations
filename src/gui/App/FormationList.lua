local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)
local TextField = require(ReplicatedStorage.Gui.Components.TextField)
local ScrollableList = require(ReplicatedStorage.Gui.Components.ScrollableList)
local FormationListItem = require(ReplicatedStorage.Gui.Components.FormationListItem)

local FormationData = require(ReplicatedStorage.Shared.Data.Formations)

local e = Roact.createElement

local function FormationList(props, _hooks)
	local topSize = 100

	local formationListings = {}

	for i, listing in ipairs(FormationData) do
		formationListings[listing.id] = e(FormationListItem, {
			global = props.global,
			listing = listing,
			index = i,
			Size = UDim2.new(1, 0, 0, 100),
		})
	end

	return e("Frame", {
		Name = "RootFrame",
		Size = UDim2.new(0, 400, 1, -2 * props.global.Padding.Interface),
		Position = UDim2.new(0, props.global.Padding.Interface, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundColor3 = props.global.Colour.Primary,
		BackgroundTransparency = 1,
	}, {
		EntityCountTextField = e(TextField, {
			global = props.global,
			Size = topSize,
			PlaceholderText = "Number of Guards...",
			ClearTextOnFocus = false,
			ShouldValidateInput = true,
			ValidRange = {
				Min = 0,
				Max = 50,
			},
		}),
		FormationList = e(ScrollableList, {
			Size = UDim2.new(1, 0, 1, -topSize),
			Position = UDim2.new(0, 0, 0, topSize),
			items = formationListings,
		}),
	})
end

return Hooks.new(Roact)(FormationList, { defaultProps = {} })
