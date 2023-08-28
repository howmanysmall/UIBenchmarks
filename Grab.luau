local fs = require("@lune/fs")
local process = require("@lune/process")
local stdio = require("@lune/stdio")

local STRING = [[--!strict
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
]]

print(string.split(STRING, "\n"))
process.exit(1)

local ParentFolder =
	stdio.prompt("text", "Where is the parent folder for benchmarks?", "src/ReplicatedStorage/Shared/Benchmarks")
if not fs.isDir(ParentFolder) then
	warn("Not directory!")
	process.exit(1)
end

local function GenerateBenchmarkFor(Library: "React" | "Roact" | "RoactHooked", Type: string)
	if Library == "React" then
		local String = {
			"--!strict",
			"local ReplicatedStorage = game:GetService(\"ReplicatedStorage\")",
			`local {Library} = require(ReplicatedStorage.Shared.Components.Benchmarks.React.Classes.{Type})`,
			"local React = require(ReplicatedStorage.Packages.React)",
			"local ReactTree = require(ReplicatedStorage.Packages.ReactTree)",
			"local Types = require(ReplicatedStorage.Shared.Types)",
			"",
			"local Tree",
			"",
			"local Benchmark: Types.Benchmark = {",
			"\tIterations = 100000,",
			"\tSetup = function()",
			"\t\t\tReplicatedStorage:SetAttribute(\"Value\", \"Initial\")",
			`\t\t\tTree = ReactTree.mount(React.createElement({Library}))`,
			"\tend,",
			"",
			"\tStep = function(Index)",
			"\t\t\tReplicatedStorage:SetAttribute(\"Value\", tostring(Index))",
			"\tend,",
			"",
			"\tTeardown = function()",
			"\t\t\tReactTree.unmount(Tree)",
			"\t\t\tReplicatedStorage:SetAttribute(\"Value\", \"Initial\")",
			"\tend,",
			"}",
			"",
			"return Benchmark",
			"",
		}
	end
end
