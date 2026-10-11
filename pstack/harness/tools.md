# Cursor tools in Claude Code and Codex

pstack is written for Cursor. Translate each Cursor mechanic below and keep the rest of the instruction as written. `<pstack root>` is the path the session hook gave you.

| pstack says | Claude Code | Codex |
|---|---|---|
| `Task` tool | Agent tool | spawn a subagent |
| `subagent_type: "poteto-agent"` | `pstack:poteto-agent`, with `<pstack root>/skills/poteto-mode/SKILL.md` named in the brief | a subagent whose brief starts with "read `<pstack root>/skills/poteto-mode/SKILL.md` in full" |
| `subagent_type: generalPurpose` | `general-purpose` | default subagent |
| `readonly: true` | `Explore`, or "read-only, no edits" in the brief | "read-only, no edits" in the brief |
| `run_in_background: true` | `run_in_background: true` | run subagents in parallel |
| `environment: "cloud"`, cloud agents, `/in-cloud` | `isolation: "worktree"` | one git worktree per worker |
| `AskQuestion` | AskUserQuestion | ask in the chat |
| `/loop` | `/loop` | keep working until the finish condition passes |
| `create-skill` (Cursor built-in) | `skill-creator` if installed, else the Authoring a skill playbook | same |
| `deslop`, `control-ui`, `control-cli` | the `team-kit-lite` plugin's skills | same |
| Custom Mode, option+enter | the session hook | the session hook |

Subagents don't get the session hook. Put every path a subagent needs in its brief.

If `team-kit-lite` isn't installed, do the work by hand. For `deslop`, review the branch diff and remove narrating comments, guards that trusted code doesn't need, `any` casts that hide type errors, nesting an early return would flatten, and anything unlike the surrounding code. Keep behavior unchanged. For `control-ui`, drive the app with the repo's Playwright or browser harness, or any browser tool you have. For `control-cli`, drive the CLI from the shell and capture its output.
