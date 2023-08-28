--!optimize 2
--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.Roact)
local RoactHooked = require(ReplicatedStorage.Packages.RoactHooked)
local Types = require(script.Parent.Types)

local function GetBenchmarks(Root: Instance, ModuleList: {ModuleScript})
	for _, Descendant in Root:GetDescendants() do
		if Descendant:IsA("ModuleScript") and string.match(Descendant.Name, "%.bench$") then
			table.insert(ModuleList, Descendant)
		end
	end
end

local function NoOperation() end

local function Benchmarker(Parent: Instance, SortByFastest: boolean?)
	local BenchmarkModules: {ModuleScript} = {}
	GetBenchmarks(Parent, BenchmarkModules)
	table.sort(BenchmarkModules, function(A, B)
		return A.Name < B.Name
	end)

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

	local HasRanHooked = false

	print(string.format("Starting %* benchmarks...", #BenchmarkModules))
	print()

	local BenchmarkResults: {
		{
			Name: string,
			Iterations: number,
			TotalTime: number,
			NanoSecond: number,
		}
	} =
		table.clone(BenchmarkModules) :: any

	for Index, ModuleScript in BenchmarkModules do
		if not HasRanHooked and string.find(ModuleScript.Name, "RoactHooked") then
			RoactHooked.withHookDetection(Roact)
			HasRanHooked = true
		end

		local require = require
		local Benchmark: Types.Benchmark = require(ModuleScript)

		local Setup = Benchmark.Setup
		if Setup then
			Setup()
		end

		local StartTime = os.clock()
		local Step = Benchmark.Step

		for StepIndex = 1, Benchmark.Iterations do
			Step(StepIndex)
		end

		local FinishTime = os.clock()
		local Teardown = Benchmark.Teardown
		if Teardown then
			Teardown()
		end

		local TotalTime = FinishTime - StartTime - GetEmptyTime(Benchmark.Iterations)
		-- local Message = string.format(
		-- 	"Benchmark %*:\n\t(%* iterations) took %* s (%* ns/iteration)",
		-- 	string.gsub(ModuleScript.Name, "^Z", ""),
		-- 	Benchmark.Iterations,
		-- 	TotalTime,
		-- 	1E9 * TotalTime / Benchmark.Iterations
		-- )

		BenchmarkResults[Index] = {
			Name = string.gsub(ModuleScript.Name, "^Z", "");
			Iterations = Benchmark.Iterations;
			TotalTime = TotalTime;
			NanoSecond = 1E9 * TotalTime / Benchmark.Iterations;
		}

		-- print(Message)
		-- print()
	end

	if SortByFastest then
		table.sort(BenchmarkResults, function(A, B)
			return A.NanoSecond < B.NanoSecond
		end)
	end

	local String: {string} = table.clone(BenchmarkResults) :: any
	for Index, BenchmarkResult in BenchmarkResults do
		String[Index] = string.format(
			"Benchmark %*:\n\t(%* iterations) took %* s (%* ns/iteration)",
			BenchmarkResult.Name,
			BenchmarkResult.Iterations,
			BenchmarkResult.TotalTime,
			BenchmarkResult.NanoSecond
		)
	end

	print(table.concat(String, "\n"))
	print("Benchmarks complete!")
end

return Benchmarker
