local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)
local e = Roact.createElement

function ScrollableList(props, hooks)
	local canvasSize, setCanvasSize = hooks.useState(UDim2.new(1, 0, 0, 0))
	return e("ScrollingFrame", {
		Size = props.Size,
		Position = props.Position,
		BackgroundTransparency = 1,
		CanvasSize = canvasSize,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		TopImage = "",
		BottomImage = "",
		ScrollBarThickness = 0,
	}, {
		UIListLayout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			[Roact.Change.AbsoluteContentSize] = function(listLayout)
				setCanvasSize(UDim2.new(1, 0, 0, listLayout.AbsoluteContentSize.Y))
			end,
		}),
		Roact.createFragment(props.items),
	})
end

return Hooks.new(Roact)(
	ScrollableList,
	{ defaultProps = {
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0, 0, 0, 0),
	} }
)
