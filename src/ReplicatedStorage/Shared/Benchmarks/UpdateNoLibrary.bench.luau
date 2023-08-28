--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NoLibrary = require(ReplicatedStorage.Shared.Components.Benchmarks.NoLibrary)
local Types = require(ReplicatedStorage.Shared.Types)

local Tree

local Benchmark: Types.Benchmark = {
	Iterations = 100000;
	Setup = function()
		ReplicatedStorage:SetAttribute("Value", "Initial")
		Tree = NoLibrary()
	end;

	Step = function(Index)
		ReplicatedStorage:SetAttribute("Value", tostring(Index))
	end;

	Teardown = function()
		Tree()
		ReplicatedStorage:SetAttribute("Value", "Initial")
	end;
}

return Benchmark
