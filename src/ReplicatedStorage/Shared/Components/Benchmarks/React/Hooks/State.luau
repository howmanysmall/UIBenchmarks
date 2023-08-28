--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local React = require(ReplicatedStorage.Packages.React)

local function UpdateBenchmark()
	local value, setValue = React.useState("Initial")

	React.useEffect(function()
		local connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
			setValue(ReplicatedStorage:GetAttribute("Value"))
		end)

		return function()
			connection:Disconnect()
		end
	end, {})

	return React.createElement("StringValue", {
		Value = value,
	})
end

return UpdateBenchmark
