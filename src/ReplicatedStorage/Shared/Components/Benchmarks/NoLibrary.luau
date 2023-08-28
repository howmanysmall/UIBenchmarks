--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function UpdateBenchmark()
	local StringValue = Instance.new("StringValue")
	StringValue.Value = "Initial"

	local Connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
		StringValue.Value = ReplicatedStorage:GetAttribute("Value")
	end)

	return function()
		Connection:Disconnect()
		StringValue:Destroy()
	end
end

return UpdateBenchmark
