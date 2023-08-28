--!optimize 2
--!strict
local Types = require(script.Parent.Types)

local function GetBenchmarks(Root: Instance, ModuleList: {ModuleScript})
	for _, Descendant in Root:GetDescendants() do
		if Descendant:IsA("ModuleScript") and string.match(Descendant.Name, "%.bench$") then
			table.insert(ModuleList, Descendant)
		end
	end
end

local function NoOperation() end

local EmptyTimes: {number} = {}
local function GetEmptyTime(Iterations: number)
	local Value = EmptyTimes[Iterations]
	if Value then
		return Value
	end

	local StartTime = os.clock()
	for _ = 1, Iterations do
		NoOperation()
	end

	local FinishTime = os.clock()
	local Result = FinishTime - StartTime
	EmptyTimes[Iterations] = Result
	return Result
end

local function Benchmarker(Parent: Instance)
	local BenchmarkModules: {ModuleScript} = {}
	GetBenchmarks(Parent, BenchmarkModules)
	table.sort(BenchmarkModules, function(A, B)
		return A.Name < B.Name
	end)

	print(string.format("Starting %* benchmarks...", #BenchmarkModules))
	print()

	for _, ModuleScript in BenchmarkModules do
		local require = require
		local Benchmark: Types.Benchmark = require(ModuleScript)

		local Setup = Benchmark.Setup
		if Setup then
			Setup()
		end

		local StartTime = os.clock()
		local Step = Benchmark.Step

		for Index = 1, Benchmark.Iterations do
			Step(Index)
		end

		local FinishTime = os.clock()
		local Teardown = Benchmark.Teardown
		if Teardown then
			Teardown()
		end

		local TotalTime = FinishTime - StartTime - GetEmptyTime(Benchmark.Iterations)
		local Message = string.format(
			"Benchmark %*:\n\t(%* iterations) took %* s (%* ns/iteration)",
			ModuleScript.Name,
			Benchmark.Iterations,
			TotalTime,
			1e9 * TotalTime / Benchmark.Iterations
		)

		print(Message)
		print()
	end
end

return Benchmarker
