For coding agents. Humans: start at README.md.

# Agent map

Load this file. Then at most two others this turn, or three if this turn needs `docs/eval.md`. Skip unused. Cite paths. Do not paste.

- What it is: `README.md` when you need the planned `compat` CLI, the verdicts, or current limits
- Topology: `docs/architecture.md` when processes, records, sandboxes, or file layout come up
- Behavior: `docs/design.md` when CLI commands, the fix ladder, asking first, wall reports, or the skills pack come up
- Scored probe: `docs/eval.md` when the frozen set, the baseline, scoring, or the gold command come up
- First host: `docs/decisions/001-constrained-hardware-first-host.md` when hard-coding Intel Mac details or adding a second host looks useful
- Fix order: `docs/decisions/002-adapt-the-software-not-the-host.md` when an OS upgrade, a container first, or widening what v0 runs looks useful
- Decision index: `docs/decisions/README.md` when you need the list of decisions and their status
- Verdicts: `docs/decisions/003-three-verdicts-honest-walls.md` when a confidence score, a fourth verdict, or counting a swap as success looks useful
- Replay: `docs/decisions/004-clean-replay-is-the-proof.md` when reporting a fix before a clean replay looks useful
- MVP win: `docs/decisions/005-mvp-win-condition.md` when calling the product done or changing scope looks useful
- Interface: `docs/decisions/006-skills-first-interface.md` when an MCP-first or editor-only interface looks useful
- Binary probe: `docs/decisions/007-optional-binary-probe.md` when making REA or a disassembler required looks useful

Verify the docs with `bash scripts/verify-docs.sh`. Never change the OS. Never install into system Python. Never report a fix without a passing clean replay. Do not add `CONTEXT.md` or `GLOSSARY.md`.

Park thinking in `scratch/`. Do not map it. Do not commit it.
