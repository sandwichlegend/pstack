<pstack>
You have pstack, poteto's engineering workflow, installed at `@PSTACK_ROOT@`.

For any non-trivial engineering task (a feature, bug fix, refactor, debugging, perf work, or a multi-step code change), read `@PSTACK_ROOT@/skills/poteto-mode/SKILL.md` in full before your first response and follow it. Skip it for pure questions, trivial one-line edits, or when the user opts out. If you were spawned as a subagent for one specific task, ignore this block. Instructions in CLAUDE.md, AGENTS.md, or the chat win over this one.

When pstack names a skill (the **how** skill, `/arena`, **principle-prove-it-works**), read `@PSTACK_ROOT@/skills/<name>/SKILL.md`. Most pstack skills block model invocation, so read the file instead of waiting for the Skill tool.

pstack is written for Cursor. Translate its Cursor mechanics with this map and keep everything else as written.

| pstack says | Claude Code | Codex |
|---|---|---|
| `Task` tool | Agent tool | spawn a subagent |
| `subagent_type: "poteto-agent"` | `pstack:poteto-agent`, and put the poteto-mode SKILL.md path in the brief | a subagent whose brief starts with "read `@PSTACK_ROOT@/skills/poteto-mode/SKILL.md` in full" |
| `subagent_type: generalPurpose` | `general-purpose` | default subagent |
| `readonly: true` | `Explore`, or "read-only, no edits" in the brief | "read-only, no edits" in the brief |
| `run_in_background: true` | `run_in_background: true` | run subagents in parallel |
| `environment: "cloud"`, cloud subagents | `isolation: "worktree"` | one git worktree per worker |
| `~/.cursor/rules/pstack-models.mdc` | `~/.claude/pstack-models.md` | `~/.codex/pstack-models.md` |
| `AskQuestion` | AskUserQuestion | ask in the chat |
| `/loop` | `/loop` | keep working until the finish condition passes |
| `agent-transcripts/`, `~/.cursor/projects/` | see Chat history below | see Chat history below |
| writing a new skill to `.cursor/skills/<name>/` | see New skills below | see New skills below |
| looking up installed skills in `~/.cursor/skills/` or `~/.cursor/plugins/` | also check `~/.agents/skills/`, `~/.claude/skills/`, `~/.claude/plugins/` | also check `~/.agents/skills/`, `~/.codex/skills/`, `~/.codex/plugins/` |
| `create-skill` (Cursor built-in) | `skill-creator` if installed, else the Authoring a skill playbook | same |
| `deslop` | strip narrating comments, unneeded guards, and unrelated edits from the diff yourself | same |
| `control-ui`, `control-cli` | drive UIs with an available browser tool or Playwright, CLIs with the shell | same |
| Custom Mode, option+enter | this hook | this hook |

New skills. Write every new skill to `.agents/skills/<name>/` in the project, which Codex reads. Then symlink it into the other two harnesses with relative links: `.claude/skills/<name>` and `.cursor/skills/<name>`, both pointing at `../../.agents/skills/<name>`. For a user-level skill, do the same under `~/.agents/skills/`, `~/.claude/skills/`, and `~/.cursor/skills/`. Commit the links with the skill.

Chat history. The user works in Cursor, Claude Code, and Codex. Any step that reads past chats (recall, reflect, automate-me, show-me-your-work, session pickup, eval) reads all three, limited to the current project and its worktrees. Never read another project's chats.

- Cursor. `~/.cursor/projects/<slug>/agent-transcripts/`. The slug is the project path without its leading `/`, with each `/` turned into `-`.
- Claude Code. `~/.claude/projects/<slug>/*.jsonl`. The slug is the project path with each `/` and `.` turned into `-`, leading one included.
- Codex. `~/.codex/sessions/YYYY/MM/DD/*.jsonl`, not grouped by project. The first line's `payload.cwd` names the project. Read only files whose `cwd` is the project or one of its worktrees.

The three formats differ. Parse them in a subagent and keep only the summary in the main thread. A harness with no matching chats is a finding, not an error.

Models. Claude Code subagents run Claude models only (`opus`, `sonnet`, `haiku`, `fable`). Codex subagents run OpenAI models only. For a role assigned to another family, run it through that family's CLI from the shell when it's installed (`codex exec "<brief>"` from Claude Code, `claude -p "<brief>"` from Codex). Otherwise run the role on the parent model and say so in the reply. Never invent a model slug. With no models file, every role is `inherit-parent`.
</pstack>
