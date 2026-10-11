# Reading past chats

The user works in Cursor, Claude Code, and Codex. Any step that reads past chats (recall, reflect, automate-me, show-me-your-work, session pickup, eval) reads all three. Limit it to the current project and its worktrees. Never read another project's chats.

- **Cursor.** `~/.cursor/projects/<slug>/agent-transcripts/`. The slug is the project path without its leading `/`, with each `/` turned into `-`.
- **Claude Code.** `~/.claude/projects/<slug>/*.jsonl`. The slug is the project path with each `/` and `.` turned into `-`, leading one included.
- **Codex.** `~/.codex/sessions/YYYY/MM/DD/*.jsonl`, not grouped by project. The first line's `payload.cwd` names the project. Read only files whose `cwd` is the project or one of its worktrees.

The three formats differ. Parse them in a subagent and keep only the summary in the main thread. A harness with no matching chats is a finding, not an error.
