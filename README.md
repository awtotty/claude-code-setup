# Claude Code Setup

Shared Claude Code setup: devcontainer sandbox, custom skills, and settings.

## Quick Start

```bash
git clone <this-repo> ~/programs/claude-code-setup
cd ~/programs/claude-code-setup
./install.sh
```

Re-run with `--force` to overwrite existing skills.

## Usage

### Prerequisites

Install the devcontainer CLI if you don't have it:

```bash
npm install -g @devcontainers/cli
```

### Start the sandbox

After running `install.sh`, start a devcontainer for any project:

```bash
# Start the container (uses ~/.claude/.devcontainer config)
devcontainer up --workspace-folder /path/to/your/project

# Run Claude inside the container with bypass permissions
devcontainer exec --workspace-folder /path/to/your/project claude --dangerously-skip-permissions

# Or open a shell in the container
devcontainer exec --workspace-folder /path/to/your/project zsh
```

Your `~/.claude` directory is bind-mounted into the container, so skills, settings, and auth all carry over.

## What's Included

### Devcontainer

A Docker-based sandbox for running Claude Code with `--dangerously-skip-permissions`. Based on `node:20` with zsh, git-delta, gh CLI, and Claude Code pre-installed.

Installed to `~/.claude/.devcontainer/`.

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

- **Add skills**: Create a new directory under `skills/` with a `SKILL.md` file
- **Change settings**: Edit `settings.json` — values here win during merge
- **Modify the container**: Edit `devcontainer/Dockerfile`, then re-run `install.sh` and rebuild
