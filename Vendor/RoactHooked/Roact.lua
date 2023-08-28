local modules = script:FindFirstAncestor("node_modules")

if modules then
	if modules:FindFirstChild("roact") then
		return require(modules.roact.src)
	elseif modules:FindFirstChild("@rbxts") then
		return require(modules["@rbxts"].roact.src)
	end
end

if script.Parent.Parent:FindFirstChild("Roact") then
	return require(script.Parent.Parent.Roact)
else
	error("Could not find Roact or @rbxts/roact in the parent hierarchy.")
end
