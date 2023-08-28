--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local UpdateBenchmark = React.PureComponent:extend("UpdateBenchmark")

function UpdateBenchmark:init()
	self:setState({
		value = "Initial",
	})
end

function UpdateBenchmark:componentDidMount()
	self.connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
		self:setState({
			value = ReplicatedStorage:GetAttribute("Value"),
		})
	end)
end

function UpdateBenchmark:componentWillUnmount()
	self.connection:Disconnect()
end

function UpdateBenchmark:render()
	return React.createElement("StringValue", {
		Value = self.state.value,
	})
end

return UpdateBenchmark
