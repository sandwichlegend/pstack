# sandwichlegend/pstack

A fork of [cursor/plugins](https://github.com/cursor/plugins) that runs [pstack](./pstack/README.md) in Claude Code and Codex. Lauren Tan (poteto) wrote pstack. This fork adds one hook and two plugin manifests. Every other plugin in the repo is upstream's, untouched.

## Install

Claude Code:

```text
/plugin install pstack --marketplace sandwichlegend/pstack
```

Codex:

```shell
codex plugin marketplace add sandwichlegend/pstack
codex plugin add pstack@sandwichlegend-pstack
```

Codex asks you to trust the hook on first run. Approve it again after any hook change.

To try a local checkout without installing, run `claude --plugin-dir ./pstack`.

## What the fork adds

- `pstack/hooks/`. A SessionStart hook for both tools. It tells the agent where pstack lives, when to use `poteto-mode`, and how to translate pstack's Cursor tool names to the harness it's running in.
- `pstack/.claude-plugin/plugin.json` and `pstack/.codex-plugin/plugin.json`. Plugin manifests for each tool.
- `.agents/plugins/marketplace.json`. The Codex marketplace.
- `fork/`. Sync and check scripts.

## Rule: add files, don't edit Lauren's

Put fork changes in new files. Upstream never touches them, so syncs merge cleanly. Edit an upstream file only when a new file can't do the job, and log it below.

## Sync with upstream

```shell
fork/sync-upstream.sh
```

It fetches `cursor/plugins`, merges `upstream/main` into the current branch, and runs `fork/check.sh`. After a sync, check that each ledger entry below still applies, and bump the fork version in both `plugin.json` files to the new upstream version.

## Ledger of upstream files this fork edits

| File | Change | Why |
|---|---|---|
| `.claude-plugin/marketplace.json` | Renamed the marketplace to `sandwichlegend-pstack` and added a `pstack` entry. | Claude Code only reads a marketplace from this path. The rename avoids clashing with upstream's `cursor-plugins` and with the `sandwichlegend` skills marketplace. |

## Not handled yet

- Windows. The hook is a bash script with no `commandWindows` override.
- Cross-family review is manual. The hook tells the agent to call `codex exec` or `claude -p`. There's no runner script.
