--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local UpdateBenchmark = React.PureComponent:extend("UpdateBenchmark")

function UpdateBenchmark:init()
	self.value, self.setValue = React.createBinding("Initial")
end

function UpdateBenchmark:componentDidMount()
	self.connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
		self.setValue(ReplicatedStorage:GetAttribute("Value"))
	end)
end

function UpdateBenchmark:componentWillUnmount()
	self.connection:Disconnect()
end

function UpdateBenchmark:render()
	return React.createElement("StringValue", {
		Value = self.value,
	})
end

return UpdateBenchmark
