# Skills pack and CLI first

Status: Accepted

## Context

The doctor should work from any coding agent and from a plain terminal. A large MCP tool catalog costs every agent context on every turn, and ties the tool to one protocol. The same choice was made for Troy-LL's other tool, [Trace Anything](https://github.com/Troy-LL/trace-anything), for the same reasons.

## Decision

The interface is the `compat` CLI plus a skills pack in this repo, following the Agent Skills standard. The skills teach an agent the order probe, check, plan, ask, run, replay, report, and how to report a wall. Install is `npx skills add https://github.com/Troy-LL/make-anything-compatible`, or copying the skill folders into `~/.cursor/skills`, `~/.claude/skills`, or `~/.codex/skills`.

A tiny MCP server with two tools (search the typed surface, and run a short script against it in a sandbox) may come later as an extra.

## Consequences

The library and CLI hold all behavior. Skills hold guidance only. Issue #5 ships the CLI and the skills pack. The MCP server is out of scope for that issue and for the MVP. A change that only works inside one editor is incomplete.

## Alternatives considered

**MCP first, one tool per command.** Rejected because of context cost and because it makes MCP required.

**CLI only.** Rejected because agents need packaged guidance to ask before risky steps and to report walls honestly.
