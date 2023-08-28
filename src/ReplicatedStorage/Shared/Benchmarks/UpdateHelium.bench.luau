--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Shared.Components.Benchmarks.Helium)
local Constants = require(ReplicatedStorage.Shared.Constants)
local Types = require(ReplicatedStorage.Shared.Types)

local Tree

local Benchmark: Types.Benchmark = {
	Iterations = Constants.ITERATIONS;
	Setup = function()
		ReplicatedStorage:SetAttribute("Value", "Initial")
		Tree = Component.new()
	end;

	Step = function(Index)
		ReplicatedStorage:SetAttribute("Value", tostring(Index))
	end;

	Teardown = function()
		Tree:Destroy()
		ReplicatedStorage:SetAttribute("Value", "Initial")
	end;
}

return Benchmark
