#!/usr/bin/env bash
# Merge cursor/plugins main into the current branch, reapply the fork's
# marketplace and team-kit copies, then run the fork checks.
# Pass a ref to merge something other than upstream/main (used for testing).
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

ref=${1:-upstream/main}
if [[ $# -eq 0 ]]; then
  git remote get-url upstream >/dev/null 2>&1 ||
    git remote add upstream https://github.com/cursor/plugins.git
  git fetch upstream
fi

owned=.claude-plugin/marketplace.json
ours=$(git diff --name-only "$ref"...HEAD)
theirs=$(git diff --name-only HEAD..."$ref")
both=$(comm -12 <(sort <<<"$ours") <(sort <<<"$theirs") | grep -vxF "$owned" || true)
if [[ -n "$both" ]]; then
  echo "Upstream changed files this fork also edits. Recheck their FORK.md ledger rows:"
  sed 's/^/  /' <<<"$both"
fi

git merge --no-edit --no-commit "$ref" || true

cp fork/claude-marketplace.json "$owned"
fork/vendor-team-kit.sh
git add "$owned" team-kit-lite

left=$(git diff --name-only --diff-filter=U)
if [[ -n "$left" ]]; then
  echo "Resolve these conflicts, then run: git commit --no-edit && fork/check.sh"
  sed 's/^/  /' <<<"$left"
  exit 1
fi

if git rev-parse -q --verify MERGE_HEAD >/dev/null; then
  git commit --no-edit
fi
fork/check.sh
