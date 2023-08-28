local fs = require("@lune/fs")
local process = require("@lune/process")
local stdio = require("@lune/stdio")

local ParentFolder =
	stdio.prompt("text", "Where is the parent folder for benchmarks?", "src/ReplicatedStorage/Shared/Benchmarks")
if not fs.isDir(ParentFolder) then
	warn("Not directory!")
	process.exit(1)
end

local function GenerateBenchmarkFor(Library: "Classes" | "Hooks" | "HowHooked" | "Hooked", Type: string)
	local Contents: string
	if Library == "Hooked" then
		Contents = table.concat({
			"--!strict",
			"local ReplicatedStorage = game:GetService(\"ReplicatedStorage\")",
			`local Component = require(ReplicatedStorage.Shared.Components.Benchmarks.Roact.{Library}.{Type})`,
			"local Constants = require(ReplicatedStorage.Shared.Constants)",
			"local Roact = require(ReplicatedStorage.Packages.Roact)",
			"local RoactHooked = require(ReplicatedStorage.Packages.RoactHooked)",
			"local Types = require(ReplicatedStorage.Shared.Types)",
			"",
			"RoactHooked.withHookDetection(Roact)",
			"",
			"local Tree",
			"",
			"local Benchmark: Types.Benchmark = {",
			"\tIterations = Constants.ITERATIONS,",
			"\tSetup = function()",
			"\t\tReplicatedStorage:SetAttribute(\"Value\", \"Initial\")",
			`\t\tTree = Roact.mount(Roact.createElement(Component))`,
			"\tend,",
			"",
			"\tStep = function(Index)",
			"\t\tReplicatedStorage:SetAttribute(\"Value\", tostring(Index))",
			"\tend,",
			"",
			"\tTeardown = function()",
			"\t\tRoact.unmount(Tree)",
			"\t\tReplicatedStorage:SetAttribute(\"Value\", \"Initial\")",
			"\tend,",
			"}",
			"",
			"return Benchmark",
			"",
		}, "\n")
	else
		Contents = table.concat({
			"--!strict",
			"local ReplicatedStorage = game:GetService(\"ReplicatedStorage\")",
			`local Component = require(ReplicatedStorage.Shared.Components.Benchmarks.Roact.{Library}.{Type})`,
			"local Constants = require(ReplicatedStorage.Shared.Constants)",
			"local Roact = require(ReplicatedStorage.Packages.Roact)",
			"local Types = require(ReplicatedStorage.Shared.Types)",
			"",
			"local Tree",
			"",
			"local Benchmark: Types.Benchmark = {",
			"\tIterations = Constants.ITERATIONS,",
			"\tSetup = function()",
			"\t\tReplicatedStorage:SetAttribute(\"Value\", \"Initial\")",
			`\t\tTree = Roact.mount(Roact.createElement(Component))`,
			"\tend,",
			"",
			"\tStep = function(Index)",
			"\t\tReplicatedStorage:SetAttribute(\"Value\", tostring(Index))",
			"\tend,",
			"",
			"\tTeardown = function()",
			"\t\tRoact.unmount(Tree)",
			"\t\tReplicatedStorage:SetAttribute(\"Value\", \"Initial\")",
			"\tend,",
			"}",
			"",
			"return Benchmark",
			"",
		}, "\n")
	end

	fs.writeFile(ParentFolder .. `/UpdateRoact{Library}{Type}.bench.luau`, Contents)
end

GenerateBenchmarkFor("Classes", "Binding")
GenerateBenchmarkFor("Classes", "BindingPure")
GenerateBenchmarkFor("Classes", "State")
GenerateBenchmarkFor("Classes", "StatePure")

GenerateBenchmarkFor("Hooked", "Binding")
GenerateBenchmarkFor("Hooked", "BindingMemo")
GenerateBenchmarkFor("Hooked", "State")
GenerateBenchmarkFor("Hooked", "StateMemo")

GenerateBenchmarkFor("Hooks", "Binding")
GenerateBenchmarkFor("Hooks", "BindingMemo")
GenerateBenchmarkFor("Hooks", "State")
GenerateBenchmarkFor("Hooks", "StateMemo")

GenerateBenchmarkFor("HowHooked", "Binding")
GenerateBenchmarkFor("HowHooked", "BindingMemo")
GenerateBenchmarkFor("HowHooked", "State")
GenerateBenchmarkFor("HowHooked", "StateMemo")
