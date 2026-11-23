# Contributing

Issues are the specs. Open product work is listed in the [README](README.md#where-its-at) and in issues [#1](https://github.com/Troy-LL/make-anything-compatible/issues/1) through [#5](https://github.com/Troy-LL/make-anything-compatible/issues/5).

## Facts need sources

These docs make claims about other projects: which versions ship for which OS, and what fails where. Every such claim needs a link to the project's own docs, release notes, registry data, or issues. If you cannot find one, mark the claim unverified. Please do not add numbers you cannot link.

## Link checks

The docs CI checks every link, except appleinsider.com and intel.com. Those sites block bots, so the checker skips them. Their links were checked by hand. GitHub file links (`/blob/`) are checked through their raw file URLs, because GitHub often answers bots with 503 on those pages.

## Pull requests

- One change per PR, against `main`.
- Keep commits focused. Do not add `CONTEXT.md` or `GLOSSARY.md`.
- Before you ask for review, run:

```sh
bash scripts/verify-docs.sh
```

By contributing, you license your work under Apache License 2.0. See [LICENSE](LICENSE).
