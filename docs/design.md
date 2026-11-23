# Design

How the doctor behaves for the person using it. Topology is in [architecture](architecture.md).

## Who it is for

Someone with an older or limited machine who wants to run a repo that was built on a newer one, and who would rather hear "no" in a minute than find it out after an hour of failed installs. The first person is the owner of a 2017 Intel MacBook Pro on Ventura. The same questions apply to any constrained host: old OS, old architecture, no usable GPU, little RAM. See [decision 001](decisions/001-constrained-hardware-first-host.md).

## CLI

| Command | Reads | Writes | Side effects |
| --- | --- | --- | --- |
| `compat probe` | The host | `records/host.json` | None. Read only, no network |
| `compat check <repo>` | Repo, registries, fingerprint | `verdict.json` | Network reads only. Installs nothing |
| `compat plan` | `verdict.json` | `recipe.json` | None |
| `compat run` | `recipe.json` | Logs, first attempt in `replay.json` | Creates a throwaway env. Asks before risky steps |
| `compat replay` | `recipe.json` | `replay.json`, a known-good row on pass | Deletes and rebuilds the env |

Every command prints one JSON object on stdout and human notes on stderr. Exit codes: 0 done, 1 the answer is "no" (hard wall or failed replay), 2 bad input, 3 needs a yes from the user.

## The ladder

When a repo can run with a fix, the planner tries the cheapest honest change first:

1. Pin a version that already ships for this host.
2. Stay on an older official release, and block its auto-update. Ollama v0.12.4 is one: [v0.12.5](https://github.com/ollama/ollama/releases/tag/v0.12.5) dropped macOS 13, and the app will try to update itself.
3. Rebuild from source, or run CPU-only with a documented flag.
4. Swap a backend the project already supports.
5. Patch source, only when the license allows and the change is small, like a version gate.
6. Run the Linux build in a disposable container, for CPU-only work that is officially supported on Linux.
7. Say no, give the reason, and name the cheapest alternative.

OS upgrade is not a rung. It is reported next to the verdict, with its risk, and left to the user. See [decision 002](decisions/002-adapt-the-software-not-the-host.md).

v0 auto-runs only rungs 1 to 3, and only pins, older official releases, and documented CPU flags. The rest are planned and shown, not run.

## Asking first

The doctor stops and asks before any of these: `sudo`, `curl | sh`, an upstream install script, a download over a size limit, a container, or anything that writes outside the throwaway env. When the user says no, the run ends with that reason in the record. It does not look for a way around.

## Reporting a wall

A hard wall report has three parts: what blocks it, the evidence link, and the cheapest alternative. For example, [bitsandbytes](https://github.com/bitsandbytes-foundation/bitsandbytes/blob/main/README.md) lists macOS 14 or later on arm64 only, and it needs a PyTorch newer than the last official Intel macOS wheel, so the alternative is a CUDA host for that work.

If the only path is to replace the project with a different one, that is still a wall for the repo the user asked about. The replacement goes in the alternative field.

## Usable, not just installed

8 GB of RAM and two cores change the answer. A record notes when a repo installs and passes its check but is too slow or too large to be practical, like a large model on CPU. It does not invent timings. It records what the run measured.

## Pins rot

Upstream keeps dropping old hosts. A known-good row carries the date of its last replay and is re-verified before reuse. Auto-updaters can undo a pin, so the recipe says how to block them where the project documents it.

## Skills pack

The skills teach an agent to:

- Run `compat probe` once and reuse the fingerprint.
- Run `compat check` before any install.
- Show the recipe and ask before `compat run`.
- Report success only from a `replay.json` with a clean pass.
- Report a wall in plain words, with the reason and the alternative.

See [decision 006](decisions/006-skills-first-interface.md).

## Optional MCP server

A tiny server with two tools, one to search the typed CLI surface and one to run a short script against it in a sandbox, may come after the MVP. It never grows into one tool per command, and it is never required.

## Safety and legal

Running someone else's setup scripts can run anything. Every run uses a throwaway env with limits on CPU and memory, and network access defaults to the registries it needs: PyPI, conda-forge, npm, crates, and GitHub.

Rebuilding open source code from source is usually fine if license notices are kept. The doctor does not strip signatures, bypass license checks, or patch and redistribute closed apps. A closed app with no build for this host is a wall.

Any binary inspection is limited to software the user has and is allowed to examine.

## Distribution

The CLI and the skills pack ship from this repo. The runtime must itself run on the first host. That rules out anything that needs macOS 14 or later, and it is checked in [issue #5](https://github.com/Troy-LL/make-anything-compatible/issues/5).
