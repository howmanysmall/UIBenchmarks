--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Shared.Components.Benchmarks.Pract)
local Constants = require(ReplicatedStorage.Shared.Constants)
local Pract = require(ReplicatedStorage.Packages.Pract)
local Types = require(ReplicatedStorage.Shared.Types)

local Tree

local Benchmark: Types.Benchmark = {
	Iterations = Constants.ITERATIONS;
	Setup = function()
		ReplicatedStorage:SetAttribute("Value", "Initial")
		Tree = Pract.mount(Pract.create(Component))
	end;

	Step = function(Index)
		ReplicatedStorage:SetAttribute("Value", tostring(Index))
	end;

	Teardown = function()
		Pract.unmount(Tree)
		ReplicatedStorage:SetAttribute("Value", "Initial")
	end;
}

return Benchmark
