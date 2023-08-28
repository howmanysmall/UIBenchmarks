--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local RoactHooks = require(ReplicatedStorage.Packages.RoactHooks)

local function UpdateBenchmark(_, hooks: RoactHooks.Hooks)
	local value, setValue = hooks.useBinding("Initial")

	hooks.useEffect(function()
		local connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
			setValue(ReplicatedStorage:GetAttribute("Value"))
		end)

		return function()
			connection:Disconnect()
		end
	end, {})

	return Roact.createElement("StringValue", {
		Value = value,
	})
end

return RoactHooks.new(Roact)(UpdateBenchmark, {
	componentType = "PureComponent",
	name = "UpdateBenchmark",
})
