--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)

local UpdateBenchmark = Roact.Component:extend("UpdateBenchmark")

function UpdateBenchmark:init()
	self.value, self.setValue = Roact.createBinding("Initial")
end

function UpdateBenchmark:didMount()
	self.connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
		self.setValue(ReplicatedStorage:GetAttribute("Value"))
	end)
end

function UpdateBenchmark:willUnmount()
	self.connection:Disconnect()
end

function UpdateBenchmark:render()
	return Roact.createElement("StringValue", {
		Value = self.value,
	})
end

return UpdateBenchmark
