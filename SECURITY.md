# Security

Make Anything Compatible is at spec stage. There is no shipped CLI yet.

## How to report

Please report a vulnerability through [GitHub private vulnerability reporting](https://github.com/Troy-LL/make-anything-compatible/security/advisories/new). Do not file a public issue or pull request that describes the problem in detail.

## Planned surface

This tool will run other people's setup steps, so its limits matter more than most:

- `compat probe` and `compat check` install nothing. The probe makes no network calls.
- `compat run` and `compat replay` work only inside a throwaway venv, conda env, or disposable Linux container, with CPU and memory limits.
- They never install into system Python and never write outside the throwaway env.
- They ask before `sudo`, `curl | sh`, any upstream install script, or a container. A "no" ends the run.
- They never change the OS, and never patch, re-sign, or redistribute closed binaries.

A report that any of these can be bypassed is in scope.

Do not put secrets in issues, chat, or sample logs.
