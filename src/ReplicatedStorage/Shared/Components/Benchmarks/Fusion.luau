--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local Cleanup = Fusion.Cleanup
local New = Fusion.New
local Value = Fusion.Value

local function UpdateBenchmark()
	local value = Value("Initial")
	local connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
		value:set(ReplicatedStorage:GetAttribute("Value"))
	end)

	return New("StringValue")({
		Value = value;
		[Cleanup] = connection;
	})
end

return UpdateBenchmark
