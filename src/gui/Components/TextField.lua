local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local Hooks = require(ReplicatedStorage.Packages.Hooks)
local t = require(ReplicatedStorage.Packages.t)
local e = Roact.createElement

function TextField(props, hooks)
	local borderColour, setBorderColour = hooks.useState(props.global.Colour.Secondary)
	local textColour, setTextColour = hooks.useState(props.global.Colour.Text.Default)
	local numberText, setNumberText = hooks.useState(if props.ShouldValidateInput then props.ValidRange.Min else nil)

	local function validate(text: string): boolean
		local result = false

		if t.numberConstrained(props.ValidRange.Min, props.ValidRange.Max)(tonumber(text)) then
			result = true
		end

		if result == true then
			setTextColour(props.global.Colour.Text.Correct)
		else
			setTextColour(props.global.Colour.Text.Incorrect)
		end

		return result
	end

	return e("Frame", {
		Size = UDim2.new(1, 0, 0, props.Size),
		BackgroundTransparency = 1,
	}, {
		EntityCount = e("TextBox", {
			Size = UDim2.new(1, -props.global.Padding.Inner * 2, 1, -props.global.Padding.Inner),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			BackgroundColor3 = props.global.Colour.Primary,
			BorderColor3 = props.global.Colour.Secondary,
			Font = props.global.Font,
			ClearTextOnFocus = props.ClearTextOnFocus,
			ClipsDescendants = true,
			TextSize = props.Size / 4,
			BackgroundTransparency = 0,
			Text = if numberText ~= nil then numberText else "",
			TextColor3 = textColour,
			PlaceholderText = props.PlaceholderText,
			[Roact.Event.Focused] = function(textBox)
				setBorderColour(props.global.Colour.Secondary:lerp(Color3.new(1, 1, 1), 0.5))

				if props.ShouldValidateInput == true then
					validate(textBox.Text)
				end
			end,
			[Roact.Change.Text] = function(textBox)
				if props.ShouldValidateInput == true then
					validate(textBox.Text)
				end
			end,
			[Roact.Event.FocusLost] = function(textBox)
				if props.ShouldValidateInput == true then
					if validate(textBox.Text) == true then
						setNumberText(tonumber(textBox.Text))
					else
						setNumberText(props.ValidRange.Min)
					end
				end

				setBorderColour(props.global.Colour.Secondary)
				setTextColour(props.global.Colour.Text.Default)
			end,
		}, {
			UICorner = e("UICorner", {
				CornerRadius = props.global.CornerRadius,
			}),
			UIStroke = e("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Thickness = props.global.BorderWidth,
				Color = borderColour,
			}),
		}),
	})
end

return Hooks.new(Roact)(TextField, { defaultProps = { Size = 100 } })
