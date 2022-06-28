local Defaults = {
	id = 1,
	name = "No name",
	description = "No description",
	aliases = {},
}

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
		aliaes = {
			"SFL",
			"Line",
		},
	},
	{
		id = 3,
		name = "Wedge",
		description = "Equally distributed Guards forming wings behind both sides of the commanding officer. Used for ceremonial purposes.",
	},
}

for _, entry in pairs(Formations) do
	setmetatable(entry, Defaults)
end

return Formations
