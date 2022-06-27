---@diagnostic disable: undefined-global
local game = remodel.readPlaceFile("build/formations.rbxl")
local DIRECTORIES = {
	ASSETS = "build-files/assets",
	STORAGE = "build-files/storage",
	WORKSPACE = "build-files/workspace",
}

--creating directories if they're not there
local _assets = remodel.createDirAll(DIRECTORIES.ASSETS)
local _storage = remodel.createDirAll(DIRECTORIES.STORAGE)
local _workspace = remodel.createDirAll(DIRECTORIES.WORKSPACE)

--cleaning the hierarchy
local toDestroy = {}
for _, descendant in pairs(game:GetDescendants()) do
	if
		descendant.ClassName == "Script"
		or descendant.ClassName == "LocalScript"
		or descendant.ClassName == "CoreScript"
		or descendant.ClassName == "ModuleScript"
		or descendant.ClassName == "Camera"
	then
		table.insert(toDestroy, descendant)
	end
end

for _, instance in pairs(toDestroy) do
	pcall(instance.Destroy, instance)
end

if game.ReplicatedStorage:FindFirstChild("assets") then
	for _, child in pairs(game.ReplicatedStorage.assets:GetChildren()) do
		remodel.writeModelFile(child, ("%s/%s.rbxm"):format(DIRECTORIES.ASSETS, child.Name))
	end
end
for _, child in pairs(game.ServerStorage:GetChildren()) do
	remodel.writeModelFile(child, ("%s/%s.rbxm"):format(DIRECTORIES.STORAGE, child.Name))
end
for _, child in pairs(game.Workspace:GetChildren()) do
	remodel.writeModelFile(child, ("%s/%s.rbxm"):format(DIRECTORIES.WORKSPACE, child.Name))
end
