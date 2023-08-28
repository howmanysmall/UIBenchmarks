--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Helium = require(ReplicatedStorage.Packages.Helium)

local UpdateBenchmark = Helium.Component.Extend("UpdateBenchmark")

function UpdateBenchmark:Constructor()
	self.Value = "Initial"
	self.Connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
		self.Value = ReplicatedStorage:GetAttribute("Value")
		self.QueueRedraw()
	end)
end

UpdateBenchmark.RedrawBinding = Helium.RedrawBinding.Heartbeat
function UpdateBenchmark:Redraw()
	local StringValue: StringValue = self.StringValue
	if not StringValue then
		StringValue = self.Janitor:Add(Instance.new("StringValue"), "Destroy")
		self.StringValue = StringValue
	end

	StringValue.Value = self.Value
end

return UpdateBenchmark
