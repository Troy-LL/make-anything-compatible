# Three verdicts and honest walls

Status: Accepted

## Context

The failure that costs people the most time is not "no." It is "probably fine," followed by an hour of installs. Setup agents tend to call a run a success when an install finishes.

## Decision

Every check ends in one of three verdicts: runs as is, runs with a fix, or hard wall. "Runs with a fix" is only reported to the user as working after a clean replay passes. If the only path is to use a different project, that is a hard wall for the repo asked about, with the other project named as the alternative.

A wall report always has the blocker, the evidence link, and the cheapest alternative.

## Consequences

The eval counts a false fix (called fixed, failed replay) separately, and treats it as worse than an honest no. The skills pack tells agents never to claim success without a passing replay. There is no confidence score that lets a weak result pass as a fix.

## Alternatives considered

**A compatibility percentage.** Rejected: it invites "73% compatible" answers that tell the user nothing about whether to try.

**Counting swaps as success.** Rejected: it would inflate the score while the user still cannot run the repo they asked for.
