--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Helium = require(ReplicatedStorage.Shared.Components.Benchmarks.Helium)
local Types = require(ReplicatedStorage.Shared.Types)

local Tree

local Benchmark: Types.Benchmark = {
	Iterations = 100000;
	Setup = function()
		ReplicatedStorage:SetAttribute("Value", "Initial")
		Tree = Helium.new()
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
