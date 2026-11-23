# Constrained hardware, one first host

Status: Accepted

## Context

The first user has a 2017 MacBook Pro (MacBookPro14,1, Intel i5-7360U, Iris Plus 640, 8 GB) on macOS 13.7.8 Ventura, the last release Apple supports for it. The number of Intel Macs shrinks every year, so a tool built only for them has a short life. The questions it asks are general: which OS, which CPU features, which GPU, how much memory, which toolchain.

## Decision

We will build for one real first host and prove everything on it. Records, field names, and verdicts stay general, so a later host (an older Linux box, a machine with no usable GPU, a low memory laptop) is a new fingerprint, not a rewrite.

## Consequences

The eval set is chosen for the first host. Host facts in docs come with sources. Code paths must not hard-code "Intel Mac" where "this host" would do. Adding a second host is out of MVP scope.

## Alternatives considered

**Any old Mac at once.** Rejected because we could not prove it on hardware we do not have.

**A general tool from day one.** Rejected because "constrained" means different things on different machines, and we would have nothing to measure against.
