return function(dummyRig: Model, colour: Color3)
	for _, descendant in pairs(dummyRig:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Color = colour
		end
	end
end
