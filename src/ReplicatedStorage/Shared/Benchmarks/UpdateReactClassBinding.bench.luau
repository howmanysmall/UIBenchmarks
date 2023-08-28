--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Binding = require(ReplicatedStorage.Shared.Components.Benchmarks.React.Classes.Binding)
local React = require(ReplicatedStorage.Packages.React)
local ReactTree = require(ReplicatedStorage.Packages.ReactTree)
local Types = require(ReplicatedStorage.Shared.Types)

local Tree

local Benchmark: Types.Benchmark = {
	Iterations = 100000,
	Setup = function()
		ReplicatedStorage:SetAttribute("Value", "Initial")
		Tree = ReactTree.mount(React.createElement(Binding))
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
