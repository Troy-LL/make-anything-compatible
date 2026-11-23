# Optional binary probe

Status: Accepted

## Context

Some blockers only show up in shipped binaries: a release asset that is arm64 only, or a Mach-O whose minimum OS is newer than the host. [REA](https://github.com/morluto/rea) can read a Mach-O's platform, minimum OS, SDK, and slices through `inspect_macho` (vendor docs). It is an agent tool for inspecting binaries, not a setup tool, and it does not plan Python environments.

## Decision

The binary probe uses `otool` and `lipo` by default, and calls REA `inspect_macho` when it is installed. MAC never depends on REA, and never depends on commercial disassemblers. CPU feature scanning (for example AVX-512 use) is MAC's own probe, since REA was not verified to report it.

## Consequences

Installing MAC never pulls in REA. Records say which probe produced a binary fact. Binary inspection is limited to software the user has and is allowed to examine, which matches REA's own terms.

## Alternatives considered

**Require REA.** Rejected: it adds a Node runtime requirement and a large surface for a small set of facts.

**No binary probe.** Rejected: arm64-only release assets are a whole slice of the eval set.
