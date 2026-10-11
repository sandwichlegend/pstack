#!/usr/bin/env bash
# Copy the cursor-team-kit skills pstack calls into team-kit-lite.
# Real copies, because Codex drops symlinks when it installs a plugin.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"
for s in $(<fork/team-kit-skills.txt); do
  rm -rf "team-kit-lite/skills/$s"
  cp -R "cursor-team-kit/skills/$s" "team-kit-lite/skills/$s"
done
