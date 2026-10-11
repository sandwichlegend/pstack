<pstack>
You have pstack, poteto's engineering workflow, installed at `@PSTACK_ROOT@`.

For any non-trivial engineering task (a feature, bug fix, refactor, debugging, perf work, or a multi-step code change), read `@PSTACK_ROOT@/skills/poteto-mode/SKILL.md` in full before your first response and follow it. Skip it for pure questions, trivial one-line edits, or when the user opts out. If you were spawned as a subagent for one specific task, ignore this block. Instructions in CLAUDE.md, AGENTS.md, or the chat win over this one.

When pstack names a skill (the **how** skill, `/arena`, **principle-prove-it-works**), read `@PSTACK_ROOT@/skills/<name>/SKILL.md`. Most pstack skills block model invocation, so read the file instead of waiting for the Skill tool.

pstack is written for Cursor. Before you act on a Cursor-specific instruction, read the matching file in `@PSTACK_ROOT@/harness/` once per session:

- `tools.md`. The `Task` tool, `subagent_type`, `readonly`, `run_in_background`, cloud agents, `AskQuestion`, `/loop`, `create-skill`, `deslop`, `control-ui`, or `control-cli`.
- `models.md`. A model slug, a panel of models, `/setup-pstack`, or `pstack-models.mdc`.
- `history.md`. Reading past chats, `agent-transcripts/`, or `~/.cursor/projects/`.
- `skills.md`. Writing a new skill, `.cursor/skills/`, or looking up installed skills.
</pstack>
