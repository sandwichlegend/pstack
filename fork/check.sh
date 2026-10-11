#!/usr/bin/env bash
# Static checks for the fork's additions. Exits nonzero on the first failure.
set -euo pipefail
cd "$(git rev-parse --show-toplevel)"

fail() { echo "FAIL: $*" >&2; exit 1; }

for f in .claude-plugin/marketplace.json .agents/plugins/marketplace.json \
  pstack/.claude-plugin/plugin.json pstack/.codex-plugin/plugin.json pstack/hooks/hooks.json; do
  python3 -m json.tool "$f" >/dev/null || fail "$f is not valid JSON"
done

version() { python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["version"])' "$1"; }
upstream_v=$(version pstack/.cursor-plugin/plugin.json)
claude_v=$(version pstack/.claude-plugin/plugin.json)
codex_v=$(version pstack/.codex-plugin/plugin.json)
[[ "$claude_v" == "$codex_v" ]] || fail "plugin versions differ: claude $claude_v, codex $codex_v"
[[ "$claude_v" == "$upstream_v"-* ]] ||
  echo "WARN: fork version $claude_v doesn't start with upstream $upstream_v. Bump both plugin.json files."

out=$(pstack/hooks/session-start) || fail "session-start hook exited nonzero"
[[ "$out" != *@PSTACK_ROOT@* ]] || fail "hook left @PSTACK_ROOT@ unexpanded"
mode=$(grep -o '[^`]*/skills/poteto-mode/SKILL.md' <<<"$out" | head -1)
[[ -f "$mode" ]] || fail "hook points at a missing file: $mode"

if [[ -n "${CLAUDE_BIN:-}" ]]; then
  "$CLAUDE_BIN" plugin validate . || fail "claude plugin validate (marketplace)"
  "$CLAUDE_BIN" plugin validate pstack || fail "claude plugin validate (pstack)"
fi

echo "fork checks pass (upstream pstack $upstream_v, fork $claude_v)"
