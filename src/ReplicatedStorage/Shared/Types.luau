--!strict

export type Benchmark = {
	Iterations: number,
	Setup: () -> (),
	Step: (Index: number) -> (),
	Teardown: () -> (),
}

return false
