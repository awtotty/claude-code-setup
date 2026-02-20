# Claude Code Settings

Shared Claude Code setup: devcontainer sandbox, custom skills, and settings.

## Quick Start

```bash
git clone <this-repo> ~/programs/claude-code-settings
cd ~/programs/claude-code-settings
./install.sh
```

Re-run with `--force` to overwrite existing skills.

## What's Included

### Devcontainer (sandbox for bypass permissions)

A Docker-based sandbox that lets you run `claude --dangerously-skip-permissions` safely. It uses iptables firewall rules to restrict network access to only:

- GitHub (API, web, git)
- npm registry
- Anthropic API
- VS Code marketplace

Installed to `~/.claude/.devcontainer/`. Requires Docker with `--cap-add=NET_ADMIN` and `--cap-add=NET_RAW`.

### Skills

| Skill | Description |
|-------|-------------|
| `/delegate` | Break work into parallel tasks, each running in an isolated git worktree |
| `/pr-desc` | Generate a PR description from the current branch diff |
| `/pr-review` | Review the current branch like a code reviewer |

Installed to `~/.claude/skills/`.

### Settings

Enables:
- Agent teams (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS`)
- Opus as default model
- Always-on extended thinking
- Skip bypass-permissions confirmation prompt

Merged into `~/.claude/settings.json` (won't overwrite your existing settings).

## Customizing

- **Add allowed domains**: Edit `devcontainer/init-firewall.sh`, add entries to the domain loop
- **Add skills**: Create a new directory under `skills/` with a `SKILL.md` file
- **Change settings**: Edit `settings.json` — values here win during merge
