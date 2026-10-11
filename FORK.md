# sandwichlegend/pstack

A fork of [cursor/plugins](https://github.com/cursor/plugins) that runs [pstack](./pstack/README.md) in Claude Code and Codex. Lauren Tan (poteto) wrote pstack. This fork adds a startup hook, harness reference files, and a small `team-kit-lite` plugin, plus manifests for both tools. Every other plugin in the repo is upstream's, untouched.

## Install

Claude Code:

```text
/plugin install pstack --marketplace sandwichlegend/pstack
/plugin install team-kit-lite@sandwichlegend-pstack
```

Codex:

```shell
codex plugin marketplace add sandwichlegend/pstack
codex plugin add pstack@sandwichlegend-pstack
codex plugin add team-kit-lite@sandwichlegend-pstack
```

Codex asks you to trust the hook on first run. Approve it again after any hook change.

To try a local checkout without installing, run `claude --plugin-dir ./pstack --plugin-dir ./team-kit-lite`.

Cursor: use upstream, not this fork. pstack is written for Cursor, so it needs none of the fork's additions there.

```text
/add-plugin pstack
/add-plugin cursor-team-kit
```

Then run `/setup-pstack` once. The fork's hook doesn't run in Cursor, so in Cursor pstack writes new skills to `.cursor/skills/` and reads only Cursor chats.

Plugins install to your home folder (`~/.claude/plugins/`, `~/.codex/plugins/`), not into the repo. A repo only records which plugins to turn on.

## Updating

The plugin manifests leave out `version` on purpose. Without one, each git commit counts as a new version, so a push to `main` is a release. `fork/check.sh` fails if a manifest sets one.

Claude Code. Turn on auto-update once per machine: run `/plugin`, open Marketplaces, pick `sandwichlegend-pstack`, and enable auto-update. Claude then updates the marketplace and its plugins at startup. To update by hand:

```shell
claude plugin marketplace update sandwichlegend-pstack
claude plugin update pstack@sandwichlegend-pstack
claude plugin update team-kit-lite@sandwichlegend-pstack
```

Restart Claude after an update.

Codex. Update by hand:

```shell
codex plugin marketplace upgrade sandwichlegend-pstack
codex plugin add pstack@sandwichlegend-pstack
codex plugin add team-kit-lite@sandwichlegend-pstack
```

Codex asks you to trust the hook again if it changed.

## What the fork adds

- `pstack/hooks/`. A SessionStart hook for both tools. It tells the agent where pstack lives, when to use `poteto-mode`, and which `harness/` file to read when a Cursor-specific instruction comes up.
- `pstack/harness/`. How to translate pstack's Cursor mechanics: tools, models, chat history, and where new skills go. The agent reads these only when needed.
- `team-kit-lite/`. The three `cursor-team-kit` skills pstack calls: `deslop`, `control-ui`, and `control-cli`. They're real copies, because Codex drops symlinks on install. `fork/vendor-team-kit.sh` refreshes them from upstream, and `fork/check.sh` fails if they drift.
- `pstack/.claude-plugin/plugin.json` and `pstack/.codex-plugin/plugin.json`. Plugin manifests for each tool.
- `.agents/plugins/marketplace.json`. The Codex marketplace.
- `fork/`. Sync and check scripts.

## Rule: add files, don't edit Lauren's

Put fork changes in new files. Upstream never touches them, so syncs merge cleanly. Edit an upstream file only when a new file can't do the job, and log it below.

## Sync with upstream

```shell
fork/sync-upstream.sh
```

It fetches `cursor/plugins` and merges `upstream/main` into the current branch. Then it restores the fork's Claude marketplace, refreshes `team-kit-lite`, commits the merge, and runs `fork/check.sh`. If a conflict remains in any other file, it stops and lists it. After a sync, check that each ledger entry below still applies, then push `main`. That push is the update everyone picks up.

## Ledger of upstream files this fork edits

| File | Change | Why |
|---|---|---|
| `.claude-plugin/marketplace.json` | Replaced with `fork/claude-marketplace.json`, which lists only `pstack` and `team-kit-lite` under the name `sandwichlegend-pstack`. | Claude Code only reads a marketplace from this path. `fork/sync-upstream.sh` copies the fork version back after every merge, so upstream changes to this file never need a manual fix. Edit `fork/claude-marketplace.json`, not this file. |

## Not handled yet

- Windows. The hook is a bash script with no `commandWindows` override.
- Cross-family review is manual. The hook tells the agent to call `codex exec` or `claude -p`. There's no runner script.
