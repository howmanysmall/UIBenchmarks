--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Shared.Components.Benchmarks.Roact.Classes.StatePure)
local Constants = require(ReplicatedStorage.Shared.Constants)
local Roact = require(ReplicatedStorage.Packages.Roact)
local Types = require(ReplicatedStorage.Shared.Types)

local Tree

local Benchmark: Types.Benchmark = {
	Iterations = Constants.ITERATIONS,
	Setup = function()
		ReplicatedStorage:SetAttribute("Value", "Initial")
		Tree = Roact.mount(Roact.createElement(Component))
	end,

	Step = function(Index)
		ReplicatedStorage:SetAttribute("Value", tostring(Index))
	end,

	Teardown = function()
		Roact.unmount(Tree)
		ReplicatedStorage:SetAttribute("Value", "Initial")
	end,
}

return Benchmark
