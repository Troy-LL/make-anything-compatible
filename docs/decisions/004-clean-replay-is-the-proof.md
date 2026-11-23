# Clean replay is the proof

Status: Accepted

## Context

An install that worked once may have leaned on a package left over from an earlier attempt. In published setup research, a clean rebuild is what separated reproducible environments from ones that only worked in place ([Graph2Env](https://arxiv.org/abs/2609.33429), paper, self-reported).

## Decision

A fix counts only when the recipe, run alone in a fresh throwaway env, reaches the repo's success check. The success check is the repo's tests, or the demo command from its README. The tool runs the recipe once, deletes the env, rebuilds from the recipe alone, and checks again. Only the second pass writes a known-good record.

## Consequences

Replay roughly doubles run time. That is the cost of not lying. A recipe must hold every step it needs, so a step the agent ran by hand and forgot to record shows up as a replay failure. Known-good rows carry the date of their last replay and are re-verified before reuse.

## Alternatives considered

**Trust the first pass.** Rejected, for the reason above.

**A synthesized import or `--help` smoke check only.** Allowed only when a repo has no tests and no README demo, and the record says so.
