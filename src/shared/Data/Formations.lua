local Defaults = {
	id = 1,
	name = "No name",
	description = "No description",
	aliases = {},
}
Defaults.__index = Defaults

local Formations = {
	{
		id = 1,
		name = "Shoulder to Shoulder",
		description = "A straight horizontal line of Guards, standing shoulder width apart, facing their commanding offcer. Sometimes done in rank order, from right to left from the perspective of the Guards. Used for ceremonial purposes.",
		aliases = {
			"STS",
		},
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
	},
	{
		id = 3,
		name = "Wedge",
		description = "Equally distributed Guards forming wings behind both sides of the commanding officer. Used for ceremonial purposes.",
		aliases = {
			"Arrow",
			"Arrowhead",
		},
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
	},
	{
		id = 5,
		name = "Right Wing",
		description = "Guards forming half a wedge on the commanding officer's right, behind them.",
		aliases = { "Wing" },
	},
	{
		id = 6,
		name = "Inverted Right Wing",
		description = "Guards forming half a wedge on the commanding officer's right, in front of them.",
		aliases = {
			"Inverted Wing",
		},
	},
	{
		id = 7,
		name = "Left Wing",
		description = "Guards forming half a wedge on the commanding officer's left, behind them.",
	},
	{
		id = 8,
		name = "Right Wing",
		description = "Guards forming half a wedge on the commanding officer's left, in front of them.",
	},
	{
		id = 9,
		name = "Wall",
		description = "Guards forming an STS in front of their commanding officer, but facing away from them.",
		aliases = {
			"Barrier",
		},
	},
	{
		id = 10,
		name = "Box",
		description = "Guards forming a square shaped protective formation around their commanding officer, facing in the same direction as they are. A maximum number of 8 guards can do this.",
		aliases = {
			"Square",
		},
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
	},
	{
		id = 12,
		name = "Prison",
		description = "Guards form an Orbis around a target person (not necessarily their commanding officer), face towards them and ignite their sabers. They should follow them if they move.",
		aliases = {
			"Jailbreak",
			"Dynamic Jailbreak",
		},
	},
	{
		id = 13,
		name = "Double Column",
		description = "Guards form 2 SFLs behind their commanding officer.",
	},
	{
		id = 13,
		name = "Staggered Column",
		description = "Guards form a Double Column, but the left side is staggered back by half a width.",
		aliases = {
			"Staggered File",
		},
	},
	{
		id = 14,
		name = "n Ranks",
		description = "Guards form n STS lines behind their commanding officer. 2 Ranks would mean 2 STS lines, 3 Ranks would mean 3, etc. 2 has been chosen for demonstration purposes.",
		aliases = {
			"n Rows",
		},
	},
}

for _, entry in pairs(Formations) do
	setmetatable(entry, Defaults)
end

return Formations
