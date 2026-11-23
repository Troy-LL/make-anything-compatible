#!/usr/bin/env bash
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
cd "$root"

status=0

required=(
  README.md
  AGENTS.md
  CONTRIBUTING.md
  SECURITY.md
  LICENSE
  docs/architecture.md
  docs/design.md
  docs/eval.md
  docs/decisions/001-constrained-hardware-first-host.md
  docs/decisions/002-adapt-the-software-not-the-host.md
  docs/decisions/003-three-verdicts-honest-walls.md
  docs/decisions/004-clean-replay-is-the-proof.md
  docs/decisions/005-mvp-win-condition.md
  docs/decisions/006-skills-first-interface.md
  docs/decisions/007-optional-binary-probe.md
  scripts/verify-docs.sh
)

for f in "${required[@]}"; do
  if [[ ! -f "$f" ]]; then
    echo "missing: $f"
    status=1
  fi
done

out=$(python3 - << 'PY'
import re
from pathlib import Path

problems = []

# Every path mapped in an AGENTS.md bullet must exist.
for line in Path("AGENTS.md").read_text(encoding="utf-8").splitlines():
    if line.lstrip().startswith("- "):
        for part in line.split("`")[1::2]:
            if part.endswith(".md") and part not in {"CONTEXT.md", "GLOSSARY.md"} and not Path(part).exists():
                problems.append(f"mapped but missing: {part}")

# Every decision needs a status line.
for path in sorted(Path("docs/decisions").glob("*.md")):
    if not re.search(r"^Status: (Accepted|Proposed|Superseded)", path.read_text(encoding="utf-8"), re.M):
        problems.append(f"{path}: no Status line")

# Relative links in markdown must resolve.
link = re.compile(r"\]\(([^)\s]+)\)")
for path in Path(".").rglob("*.md"):
    if {".git", "node_modules", "scratch"} & set(path.parts):
        continue
    text = path.read_text(encoding="utf-8")
    for i, line in enumerate(text.splitlines(), 1):
        if "\u2014" in line:
            problems.append(f"{path}:{i}: em dash")
        for target in link.findall(line):
            if re.match(r"^(https?:|mailto:|#)", target):
                continue
            target = target.split("#", 1)[0]
            if target and not (path.parent / target).exists():
                problems.append(f"{path}:{i}: broken link {target}")

print("\n".join(problems))
PY
)
if [[ -n "$out" ]]; then
  echo "$out"
  status=1
fi

for banned in CONTEXT.md GLOSSARY.md docs/glossary.md docs/CONTEXT.md docs/GLOSSARY.md; do
  if [[ -e "$banned" ]]; then
    echo "banned file present: $banned"
    status=1
  fi
done

if [[ "$status" -eq 0 ]]; then
  echo "verify-docs: ok"
fi
exit "$status"
