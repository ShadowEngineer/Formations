local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)

local e = Roact.createElement

local function FormationListItem(props, _hooks)
	local selected, setSelected = Roact.createBinding(false)

	local function compareState(state)
		if state.formation == props.listing.name then
			setSelected(true)
		else
			setSelected(false)
		end
	end

	compareState(props.store:getState())
	props.store.changed:connect(function(state)
		compareState(state)
	end)

	local aliasText = ""
	if #props.listing.aliases > 0 then
		aliasText = "<i>"
		for i, alias in ipairs(props.listing.aliases) do
			if i < #props.listing.aliases then
				aliasText ..= alias .. ", "
			else
				aliasText ..= alias
			end
		end
		aliasText ..= "</i>"
	end

	return e("Frame", {
		Name = props.listing.name,
		LayoutOrder = props.index,
		Size = props.Size,
		BackgroundColor3 = props.global.Colour.Secondary,
		ClipsDescendants = true,
	}, {
		Button = e("ImageButton", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			[Roact.Event.Activated] = function(_button, _InputObject, _clickCount)
				props.store:dispatch({ type = "formationChanged", newFormationName = props.listing.name })
			end,
		}),
		UICorner = e("UICorner", {
			CornerRadius = props.global.CornerRadius,
		}),
		FormationName = e("TextLabel", {
			Size = UDim2.new(1, 0, 0.25, 0),
			BackgroundTransparency = 1,
			TextStrokeTransparency = 1,
			TextSize = 25,
			Font = props.global.Font,
			TextColor3 = selected:map(function(value)
				if value == true then
					return props.global.Colour.Text.Selected
				else
					return props.global.Colour.Text.Default
				end
			end),
			Text = "<b>" .. props.listing.name .. "</b>",
			RichText = true,
			TextXAlignment = Enum.TextXAlignment.Center,
		}, {
			UIPadding = e("UIPadding", {
				PaddingTop = UDim.new(0, props.global.Padding.SmallInner),
				PaddingLeft = UDim.new(0, props.global.Padding.SmallInner),
				PaddingRight = UDim.new(0, props.global.Padding.SmallInner),
			}),
		}),
		Aliases = e("TextLabel", {
			Size = UDim2.new(1, 0, 0.25, 0),
			Position = UDim2.new(0, 0, 0.25, 0),
			BackgroundTransparency = 1,
			TextStrokeTransparency = 1,
			TextSize = 15,
			Font = props.global.Font,
			TextColor3 = props.global.Colour.Text.Default,
			Text = aliasText,
			RichText = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Top,
		}, {
			UIPadding = e("UIPadding", {
				PaddingLeft = UDim.new(0, props.global.Padding.SmallInner),
				PaddingRight = UDim.new(0, props.global.Padding.SmallInner),
				PaddingBottom = UDim.new(0, props.global.Padding.SmallInner),
			}),
		}),
		Description = e("TextLabel", {
			Size = UDim2.new(1, 0, 0.5, 0),
			Position = UDim2.new(0, 0, 0.5, 0),
			BackgroundTransparency = 1,
			TextStrokeTransparency = 1,
			TextSize = 12,
			Font = props.global.Font,
			TextColor3 = props.global.Colour.Text.Default,
			Text = props.listing.description,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextWrapped = true,
			RichText = false,
			TextXAlignment = Enum.TextXAlignment.Center,
			TextYAlignment = Enum.TextYAlignment.Top,
		}),
		Gradient = e("UIGradient", {
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(1, 0.2),
			}),
			Rotation = 90,
		}),
	})
end

return Hooks.new(Roact)(FormationListItem)
