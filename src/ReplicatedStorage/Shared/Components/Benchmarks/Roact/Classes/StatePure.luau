--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)

local UpdateBenchmark = Roact.PureComponent:extend("UpdateBenchmark")

function UpdateBenchmark:init()
	self:setState({
		value = "Initial",
	})
end

function UpdateBenchmark:didMount()
	self.connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
		self:setState({
			value = ReplicatedStorage:GetAttribute("Value"),
		})
	end)
end

function UpdateBenchmark:willUnmount()
	self.connection:Disconnect()
end

function UpdateBenchmark:render()
	return Roact.createElement("StringValue", {
		Value = self.state.value,
	})
end

return UpdateBenchmark
