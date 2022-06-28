local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local Promise = require(ReplicatedStorage.Packages.Promise)

Knit.Components = script.Components
Knit.Controllers = script.Controllers
Knit.Modules = script.Modules
Knit.Shared = ReplicatedStorage.Shared
Knit.IsStudio = RunService:IsStudio()

Knit.AddControllers(Knit.Controllers)

Knit.ComponentsLoaded = false

function Knit.OnComponentsLoaded()
	return Promise.new(function(resolve, _reject, onCancel)
		if Knit.ComponentsLoaded then
			resolve()
		end

		local heartbeat
		heartbeat = RunService.Heartbeat:Connect(function()
			if Knit.ComponentsLoaded then
				heartbeat:Disconnect()
				resolve()
			end
		end)

		onCancel(function()
			if heartbeat then
				heartbeat:Disconnect()
			end
		end)
	end)
end

local function createRootPart()
	local newPart = Instance.new("Part")
	newPart.Name = "RootPart"
	newPart.Anchored = true

	if Knit.IsStudio then
		newPart.Transparency = 0.5
		newPart.Color = Color3.fromRGB(125, 0, 0)
	else
		newPart.Transparency = 1
	end

	newPart.Parent = workspace
	return newPart
end

Knit.RootPart = createRootPart()

Knit.DummyFolder = Instance.new("Folder")
Knit.DummyFolder.Name = "DummyFolder"
Knit.DummyFolder.Parent = workspace

Knit.HostDummy = ReplicatedStorage.assets.rig_white:Clone()
Knit.HostDummy.Parent = workspace
Knit.HostDummy.Name = "Commanding Officer"
Knit.HostDummy:PivotTo(CFrame.new())

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

if Knit.IsStudio then
	warn("Starting Knit...")
end

Knit.Start({ ServicePromises = true })
	:andThen(function()
		if Knit.IsStudio then
			warn("Knit started successfully.")
			warn("Loading components...")
		end

		for _, module in pairs(Knit.Components:GetDescendants()) do
			if module:IsA("ModuleScript") then
				require(module)
			end
		end

		Knit.ComponentsLoaded = true
		if Knit.IsStudio then
			warn("Components loaded successfully.")
		end
	end)
	:catch(warn)
