# Models in Claude Code and Codex

pstack's model config lives at `~/.cursor/rules/pstack-models.mdc` in Cursor. Here it lives at `~/.claude/pstack-models.md` in Claude Code and `~/.codex/pstack-models.md` in Codex. `/setup-pstack` writes to that path, and every skill that reads the config reads it there.

Claude Code subagents run Claude models only (`opus`, `sonnet`, `haiku`, `fable`). Codex subagents run OpenAI models only.

For a role assigned to another model family, run it through that family's CLI from the shell when it's installed: `codex exec "<brief>"` from Claude Code, `claude -p "<brief>"` from Codex. Give it the same self-contained brief a subagent would get, and read its output as that role's result.

When the other CLI isn't installed, run the role on the parent model and say so in the reply. A panel then has fewer families than configured. Report that as a gap. Never invent a model slug.

With no config file, every role is `inherit-parent`.
