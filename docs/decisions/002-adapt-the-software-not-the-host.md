# Adapt the software, not the host

Status: Accepted

## Context

There are two ways to make a repo run on an older machine: change the repo's dependencies to fit the machine, or change the machine. Changing the machine is the risky one. On the first host, a newer macOS means an unsupported patcher, which is still a release candidate for Tahoe on this class of Mac ([AppleInsider](https://appleinsider.com/articles/26/11/05/how-to-install-macos-tahoe-on-unsupported-macs)).

## Decision

We will try fixes from cheapest to most invasive: pin, older official release with auto-update blocked, rebuild or CPU-only flag, backend swap within the project, small license-compatible source patch, Linux container, then hard wall. An OS upgrade is reported next to the verdict with its risk, and never run by the tool.

v0 runs only pins, older official releases, and documented CPU flags. The other rungs are planned and shown.

## Consequences

Every blocker carries exactly one class: pin, rebuild, swap backend, containerize, OS upgrade, or hard wall. A recipe never contains an OS change. Widening what v0 runs needs its own issue.

## Alternatives considered

**Lead with an OS upgrade.** Rejected: it is not reversible in a click, it can break the machine, and it hides which repos truly need a newer OS.

**Containerize everything.** Rejected: a Linux container has no Metal and does not answer "does this run on my Mac." It stays as one rung.
