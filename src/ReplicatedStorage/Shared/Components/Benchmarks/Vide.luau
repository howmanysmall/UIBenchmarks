--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local vide = require(ReplicatedStorage.Packages.vide)

local action = vide.action
local create = vide.create
local source = vide.source

-- this document is quite poorly documented with regards
-- to cleanups, so we'll do a hack here.
local function destroying(callback: () -> ())
	return action(function(instance)
		instance.Destroying:Connect(callback)
	end)
end

local function UpdateBenchmark()
	local value = source("Initial")
	local connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
		value(ReplicatedStorage:GetAttribute("Value"))
	end)

	return create("StringValue")({
		Value = value;
		destroying(function()
			connection:Disconnect()
		end);
	})
end

return UpdateBenchmark
