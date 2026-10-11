#!/usr/bin/env bash
# Merge cursor/plugins main into the current branch, then run the fork checks.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

git remote get-url upstream >/dev/null 2>&1 ||
  git remote add upstream https://github.com/cursor/plugins.git
git fetch upstream

ours=$(git diff --name-only upstream/main...HEAD)
theirs=$(git diff --name-only HEAD...upstream/main)
both=$(comm -12 <(sort <<<"$ours") <(sort <<<"$theirs") | sed '/^$/d')
if [[ -n "$both" ]]; then
  echo "Upstream changed files this fork also edits. Recheck their FORK.md ledger rows:"
  sed 's/^/  /' <<<"$both"
fi

git merge --no-edit upstream/main
fork/check.sh
