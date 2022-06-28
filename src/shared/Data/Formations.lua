local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Defaults = {
	id = 1,
	name = "No name",
	description = "No description",
	aliases = {},
}
Defaults.__index = Defaults

local NumberUtil = require(ReplicatedStorage.Shared.Modules.NumberUtil)
local X_SPACING = 5
local X_SPACING_STAGGERED = 3
local Z_SPACING = 2

local Formations = {
	{
		id = 1,
		name = "Shoulder to Shoulder",
		description = "A straight horizontal line of Guards, standing shoulder width apart, facing their commanding offcer. Sometimes done in rank order, from right to left from the perspective of the Guards. Used for ceremonial purposes.",
		aliases = {
			"STS",
		},
		creator = function(n: number)
			local list = {}
			for i = 1, n do
				table.insert(
					list,
					CFrame.new(X_SPACING * (n / 2 - i) + X_SPACING / 2, 0, -X_SPACING) * CFrame.Angles(0, math.pi, 0)
				)
			end
			return list
		end,
	},
	{
		id = 2,
		name = "Single File Line",
		description = "A straight horizontal line of Guards behind their commanding officer, shoulder width apart. Used for patrolling.",
		aliases = {
			"SFL",
			"Line",
			"Column",
			"File",
		},
		creator = function(n: number)
			local list = {}
			for i = 1, n do
				table.insert(list, CFrame.new(0, 0, i * Z_SPACING))
			end
			return list
		end,
	},
	{
		id = 3,
		name = "Wedge",
		description = "Equally distributed Guards forming wings behind both sides of the commanding officer. Used for ceremonial purposes.",
		aliases = {
			"Arrow",
			"Arrowhead",
		},
		creator = function(n: number)
			local list = {}

			if NumberUtil.IsOdd(n) then
				table.insert(list, CFrame.new(0, 0, 2 * Z_SPACING))
				for i = 2, n do
					table.insert(
						list,
						CFrame.new(
							X_SPACING_STAGGERED * (if NumberUtil.IsEven(i) then 1 else -1) * math.floor(i / 2),
							0,
							Z_SPACING * math.floor(i / 2)
						)
					)
				end
			else
				for i = 1, n do
					table.insert(
						list,
						CFrame.new(
							X_SPACING_STAGGERED * (if NumberUtil.IsEven(i) then 1 else -1) * math.ceil(i / 2),
							0,
							Z_SPACING * math.ceil(i / 2)
						)
					)
				end
			end

			return list
		end,
	},
	{
		id = 4,
		name = "Inverted Wedge",
		description = "Equally distributed Guards forming wings in front of both sides of the commanding officer. Used for ceremonial purposes.",
		aliases = {
			"Inverted Arrow",
			"Inverted Arrowhead",
			"Funnel",
		},
		creator = function(n: number)
			local list = {}

			if NumberUtil.IsOdd(n) then
				table.insert(list, CFrame.new(0, 0, -2 * Z_SPACING))
				for i = 2, n do
					table.insert(
						list,
						CFrame.new(
							X_SPACING_STAGGERED * (if NumberUtil.IsEven(i) then 1 else -1) * math.floor(i / 2),
							0,
							-Z_SPACING * math.floor(i / 2)
						)
					)
				end
			else
				for i = 1, n do
					table.insert(
						list,
						CFrame.new(
							X_SPACING_STAGGERED * (if NumberUtil.IsEven(i) then 1 else -1) * math.ceil(i / 2),
							0,
							-Z_SPACING * math.ceil(i / 2)
						)
					)
				end
			end

			return list
		end,
	},
	{
		id = 5,
		name = "Right Wing",
		description = "Guards forming half a wedge on the commanding officer's right, behind them.",
		aliases = { "Wing" },
		creator = function(n: number)
			local list = {}
			for i = 1, n do
				table.insert(list, CFrame.new(i * X_SPACING_STAGGERED, 0, i * Z_SPACING))
			end
			return list
		end,
	},
	{
		id = 6,
		name = "Inverted Right Wing",
		description = "Guards forming half a wedge on the commanding officer's right, in front of them.",
		aliases = {
			"Inverted Wing",
		},
		creator = function(n: number)
			local list = {}
			for i = 1, n do
				table.insert(list, CFrame.new(i * X_SPACING_STAGGERED, 0, -i * Z_SPACING))
			end
			return list
		end,
	},
	{
		id = 7,
		name = "Left Wing",
		description = "Guards forming half a wedge on the commanding officer's left, behind them.",
		creator = function(n: number)
			local list = {}
			for i = 1, n do
				table.insert(list, CFrame.new(-i * X_SPACING_STAGGERED, 0, i * Z_SPACING))
			end
			return list
		end,
	},
	{
		id = 8,
		name = "Inverted Left Wing",
		description = "Guards forming half a wedge on the commanding officer's left, in front of them.",
		creator = function(n: number)
			local list = {}
			for i = 1, n do
				table.insert(list, CFrame.new(-i * X_SPACING_STAGGERED, 0, -i * Z_SPACING))
			end
			return list
		end,
	},
	{
		id = 9,
		name = "Wall",
		description = "Guards forming an STS in front of their commanding officer, but facing away from them.",
		aliases = {
			"Barrier",
		},
		creator = function(n: number)
			local list = {}
			for i = 1, n do
				table.insert(list, CFrame.new(X_SPACING * (n / 2 - i) + X_SPACING / 2, 0, -X_SPACING))
			end
			return list
		end,
	},
	{
		id = 10,
		name = "Box",
		description = "Guards forming a square shaped protective formation around their commanding officer, facing in the same direction as they are. A maximum number of 8 guards can do this.",
		aliases = {
			"Square",
		},
		creator = function(n: number)
			local list = {}

			--can only have a max of 8 in this one.
			if n > 8 then
				n = 8
			end

			--front
			if n >= 1 and n ~= 4 then
				table.insert(list, CFrame.new(0, 0, -X_SPACING_STAGGERED))
			end
			--front right and front left
			if n >= 7 or n == 4 then
				table.insert(list, CFrame.new(X_SPACING, 0, -X_SPACING_STAGGERED))
				table.insert(list, CFrame.new(-X_SPACING, 0, -X_SPACING_STAGGERED)) -- left front
			end
			--right and left
			if n >= 5 then
				table.insert(list, CFrame.new(X_SPACING, 0, 0))
				table.insert(list, CFrame.new(-X_SPACING, 0, 0))
			end
			--back right and back left
			if n >= 3 then
				table.insert(list, CFrame.new(X_SPACING, 0, X_SPACING_STAGGERED))
				table.insert(list, CFrame.new(-X_SPACING, 0, X_SPACING_STAGGERED))
			end
			--back
			if NumberUtil.IsEven(n) == true and n ~= 0 and n ~= 4 then
				table.insert(list, CFrame.new(0, 0, X_SPACING_STAGGERED))
			end

			return list
		end,
	},
	{
		id = 11,
		name = "Orbis",
		description = "Guards forming an equidistant, protective circle around their commanding officer, facing directly away from them. The guards should be static, and not spin.",
		aliases = {
			"All Round Defense",
			"ARD",
			"Orbis Theory",
		},
		creator = function(n: number)
			local circleCircumference = n * X_SPACING
			local circleRadius = circleCircumference / (2 * math.pi)
			circleRadius = math.max(circleRadius, Z_SPACING)
			local list = {}
			if n > 0 then
				for i = 0, n - 1 do
					table.insert(list, CFrame.Angles(0, i / n * math.pi * 2, 0) * CFrame.new(0, 0, -circleRadius))
				end
			end
			return list
		end,
	},
	{
		id = 12,
		name = "Prison",
		description = "Guards form an Orbis around a target person (not necessarily their commanding officer), face towards them and ignite their sabers. They should follow them if they move.",
		aliases = {
			"Jailbreak",
			"Dynamic Jailbreak",
		},
		creator = function(n: number)
			local circleCircumference = n * X_SPACING
			local circleRadius = circleCircumference / (2 * math.pi)
			circleRadius = math.max(circleRadius, Z_SPACING)
			local list = {}
			if n > 0 then
				for i = 0, n - 1 do
					table.insert(
						list,
						CFrame.Angles(0, i / n * math.pi * 2, 0)
							* CFrame.new(0, 0, -circleRadius)
							* CFrame.Angles(0, math.pi, 0)
					)
				end
			end
			return list
		end,
	},
	{
		id = 13,
		name = "Double Column",
		description = "Guards form 2 SFLs behind their commanding officer.",
		aliases = {
			"Double File",
		},
		creator = function(n: number)
			local list = {}
			for i = 1, n do
				table.insert(
					list,
					CFrame.new(
						(if NumberUtil.IsOdd(i) then 1 else -1) * X_SPACING_STAGGERED,
						0,
						math.floor(i * Z_SPACING / 2)
					)
				)
			end
			return list
		end,
	},
	{
		id = 14,
		name = "Staggered Column",
		description = "Guards form a Double Column, but the left side is staggered back by half a width.",
		aliases = {
			"Staggered File",
		},
		creator = function(n: number)
			local list = {}
			for i = 1, n do
				table.insert(
					list,
					CFrame.new(
						(if NumberUtil.IsOdd(i) then 1 else -1) * X_SPACING_STAGGERED,
						0,
						math.floor(i * Z_SPACING / 2) + (if NumberUtil.IsOdd(i) then -1 else 0) * Z_SPACING / 2
					)
				)
			end
			return list
		end,
	},
	{
		id = 15,
		name = "n Ranks",
		description = "Guards form n STS lines behind their commanding officer. 2 Ranks would mean 2 STS lines, 3 Ranks would mean 3, etc. 2 has been chosen for demonstration purposes.",
		aliases = {
			"n Rows",
		},
		creator = function(n: number)
			local list = {}
			local firstLineTotal = math.ceil(n / 2)
			local secondLineTotal = n - firstLineTotal
			for i = 1, firstLineTotal do
				table.insert(list, CFrame.new(X_SPACING * (firstLineTotal / 2 - i) + X_SPACING / 2, 0, X_SPACING))
			end
			for i = 1, secondLineTotal do
				table.insert(list, CFrame.new(X_SPACING * (secondLineTotal / 2 - i) + X_SPACING / 2, 0, 2 * X_SPACING))
			end
			return list
		end,
	},
}

Formations.ById = {}
Formations.ByName = {}

for _, entry in pairs(Formations) do
	setmetatable(entry, Defaults)
	Formations.ById[entry.id] = entry
	Formations.ByName[entry.name] = entry
end

return Formations
