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
| `agent-transcripts/` | `~/.claude/projects/<project>/*.jsonl` | `~/.codex/sessions/` |
| `create-skill` (Cursor built-in) | `skill-creator` if installed, else the Authoring a skill playbook | same |
| `deslop` | strip narrating comments, unneeded guards, and unrelated edits from the diff yourself | same |
| `control-ui`, `control-cli` | drive UIs with an available browser tool or Playwright, CLIs with the shell | same |
| Custom Mode, option+enter | this hook | this hook |

Models. Claude Code subagents run Claude models only (`opus`, `sonnet`, `haiku`, `fable`). Codex subagents run OpenAI models only. For a role assigned to another family, run it through that family's CLI from the shell when it's installed (`codex exec "<brief>"` from Claude Code, `claude -p "<brief>"` from Codex). Otherwise run the role on the parent model and say so in the reply. Never invent a model slug. With no models file, every role is `inherit-parent`.
</pstack>
