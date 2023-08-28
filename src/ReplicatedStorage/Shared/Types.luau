--!strict

export type Benchmark = {
	Iterations: number,
	Setup: nil | () -> (),
	Step: (Index: number) -> (),
	Teardown: nil | () -> (),
}

return false
