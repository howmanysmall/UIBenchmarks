--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Pract = require(ReplicatedStorage.Packages.Pract)

local function UpdateBenchmark()
	local value, setValue = Pract.useStateTyped("Initial")

	Pract.useEffect(function()
		local connection = ReplicatedStorage:GetAttributeChangedSignal("Value"):Connect(function()
			setValue(ReplicatedStorage:GetAttribute("Value"))
		end)

		return function()
			connection:Disconnect()
		end
	end)

	return Pract.create("StringValue", {
		Value = value;
	})
end

return UpdateBenchmark
