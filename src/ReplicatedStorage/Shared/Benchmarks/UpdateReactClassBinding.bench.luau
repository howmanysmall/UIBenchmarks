--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Component = require(ReplicatedStorage.Shared.Components.Benchmarks.React.Classes.Binding)
local Constants = require(ReplicatedStorage.Shared.Constants)
local React = require(ReplicatedStorage.Packages.React)
local ReactTree = require(ReplicatedStorage.Packages.ReactTree)
local Types = require(ReplicatedStorage.Shared.Types)

local Tree

local Benchmark: Types.Benchmark = {
	Iterations = Constants.ITERATIONS,
	Setup = function()
		ReplicatedStorage:SetAttribute("Value", "Initial")
		Tree = ReactTree.mount(React.createElement(Component))
	end,

	Step = function(Index)
		ReplicatedStorage:SetAttribute("Value", tostring(Index))
	end,

	Teardown = function()
		ReactTree.unmount(Tree)
		ReplicatedStorage:SetAttribute("Value", "Initial")
	end,
}

return Benchmark
