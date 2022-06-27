local RunService = game:GetService("RunService")
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

warn("Starting Knit...")

Knit.Start({ ServicePromises = true })
	:andThen(function()
		warn("Knit Started Successfully.")
		warn("Loading Components...")

		for _, module in pairs(Knit.Components:GetDescendants()) do
			if module:IsA("ModuleScript") then
				require(module)
			end
		end

		warn("Components loaded successfully.")
		Knit.ComponentsLoaded = true
	end)
	:catch(warn)
