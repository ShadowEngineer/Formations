local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Knit = require(ReplicatedStorage.Packages.Knit)
local Promise = require(ReplicatedStorage.Packages.Promise)

Knit.Components = script.Components
Knit.Services = script.Services
Knit.Modules = script.Modules
Knit.Shared = ReplicatedStorage.Shared
Knit.IsStudio = RunService:IsStudio() or RunService:IsRunMode()

Knit.AddServices(Knit.Services)

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

if Knit.IsStudio then
	warn("Starting Knit...")
end

Knit.Start()
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
