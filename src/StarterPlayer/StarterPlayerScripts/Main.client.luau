--!optimize 2
--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Benchmarker = require(ReplicatedStorage.Shared.Benchmarker)

Benchmarker(ReplicatedStorage.Shared.Benchmarks)
