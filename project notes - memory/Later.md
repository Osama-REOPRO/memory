- [ ] add delay to [[cach hit]], we can't figure out that we had a hit without a delay
- [ ] lookup how memory capacity correlates with latency, then implement memory delay based on the capacity parameter
- [ ] if received address is already being output, do nothing
- [ ] implement word writes and line writes etc. for refilling of caches
	- right now we can only do one byte write
- [ ] check parameter edge cases, small numbers and zeros, because it is a small design, we might have lots of those
- [ ] add more cache levels
- [ ] make reading async, writing sync
- [ ] rewrite testbench more elegently
- [ ] lookup write buffers
	- cache flushes entire lines at once to write buffer, then the write buffer at some point completes the writes to ram
- [ ] change var naming so it conforms with competition spec
	- I put the `i_ / o_` before the var name but it should be after it according to the spec
- what needs to be communicated to cache from outside
	- dirty override
		- ignore the fact that it is dirty and overwrite
- how about the model where we prompt the cache for a hit or a conflict, and that data is returned to the outside system, the outside system decides what to do with that info
	- so when the outside system requests a write, we always write, when it requests a read we always read, the lower system does not concern itself with any rules, it does what it is told
- [ ] [[use_mem]] is unnecessary when directly mapped