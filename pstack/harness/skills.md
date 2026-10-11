# Writing and finding skills

## New skills

pstack writes new skills to `.cursor/skills/<name>/`. Write them to `.agents/skills/<name>/` instead, which Codex reads. Then link the skill into the other two harnesses with relative symlinks:

```shell
mkdir -p .claude/skills .cursor/skills
ln -s ../../.agents/skills/<name> .claude/skills/<name>
ln -s ../../.agents/skills/<name> .cursor/skills/<name>
```

For a user-level skill, do the same under `~/.agents/skills/`, `~/.claude/skills/`, and `~/.cursor/skills/`. Commit the links with the skill.

## Installed skills

Where pstack looks in `~/.cursor/skills/` or `~/.cursor/plugins/`, also check:

- Claude Code. `.claude/skills/`, `~/.claude/skills/`, `~/.claude/plugins/`.
- Codex. `.agents/skills/`, `~/.agents/skills/`, `~/.codex/skills/`, `~/.codex/plugins/`.
