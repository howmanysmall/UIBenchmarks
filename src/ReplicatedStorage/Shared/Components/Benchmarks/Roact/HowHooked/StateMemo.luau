--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local RoactHooked = require(ReplicatedStorage.Packages.HowRoactHooked)

local function UpdateBenchmark()
	local value, setValue = RoactHooked.UseState("Initial")

	RoactHooked.UseEffect(function()
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

return RoactHooked.HookPure(UpdateBenchmark, {Name = "UpdateBenchmark"})
