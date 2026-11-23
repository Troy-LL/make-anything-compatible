# MVP win condition

Status: Accepted

## Context

It would be easy to call this done once `compat check` prints a nice verdict for a few famous repos. The first win has to be narrower than that, measured on the real host, and rerunnable by anyone who has the same kind of machine.

## Decision

We will treat the MVP as won only when all four of the following hold:

1. On the frozen 30-repo set from [issue #2](https://github.com/Troy-LL/make-anything-compatible/issues/2), on the first host, with the same agent and model, an agent using MAC reaches more success checks after clean replay than the same agent without MAC. The set, prompt, scripts, logs, and score table are committed.
2. Zero false fixes. Every row MAC reports as running passed clean replay. MAC declares at least as many of the expected hard walls correctly as the baseline.
3. The same run works from the `compat` CLI and from an agent via the skills pack, with JSON in and out, and writes the same records.
4. Every run stays inside throwaway environments and under the spend cap and per-repo time limit set in issue #2 before the first paid run. No OS changes and no binary patches. Those limits are not set yet.

A stop rule sits beside these: if `compat check` is wrong on more than 1 in 5 frozen rows, stop and rescope before building replay.

The optional MCP server in [decision 006](006-skills-first-interface.md) is out of MVP scope. A second host is out of MVP scope.

## Consequences

Issues #1 to #5 are the work that makes these true. A demo on a hand-picked repo does not satisfy the MVP. A higher reached count that comes with even one false fix does not satisfy it either.
