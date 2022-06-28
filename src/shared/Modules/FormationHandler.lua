local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Knit = require(ReplicatedStorage.Packages.Knit)
local FormationData = require(ReplicatedStorage.Shared.Data.Formations)
local ColourDummy = require(ReplicatedStorage.Shared.Modules.ColourDummy)

local FormationHandler = {}

function FormationHandler.ClearFormation()
	Knit.DummyFolder:ClearAllChildren()
end

function FormationHandler.CreateFormation(formationName: string, numberOfGuards): ({ [number]: CFrame })
	if type(FormationData.ByName[formationName].creator) == "function" then
		local listOfCFrames = {}
		listOfCFrames = FormationData.ByName[formationName].creator(numberOfGuards)

		for _, cframe in pairs(listOfCFrames) do
			local newDummy = Knit.HostDummy:Clone()
			newDummy.Name = ""
			newDummy.Parent = Knit.DummyFolder
			newDummy:PivotTo(cframe)
			ColourDummy(newDummy, Color3.fromRGB(255, 225, 0))
		end
	end
end

return FormationHandler
