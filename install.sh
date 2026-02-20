#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
FORCE=false

if [[ "${1:-}" == "--force" ]]; then
    FORCE=true
fi

# 1. Install skills
echo "Installing skills..."
mkdir -p "$CLAUDE_DIR/skills"
for skill in "$SCRIPT_DIR"/skills/*/; do
    name=$(basename "$skill")
    if [ -d "$CLAUDE_DIR/skills/$name" ] && [ "$FORCE" = false ]; then
        echo "  Skill '$name' already exists, skipping (use --force to overwrite)"
    else
        cp -r "$skill" "$CLAUDE_DIR/skills/$name"
        echo "  Installed skill: $name"
    fi
done

# 2. Merge settings (additive — won't blow away user's existing config)
echo "Merging settings..."
if command -v jq &>/dev/null; then
    if [ -f "$CLAUDE_DIR/settings.json" ]; then
        jq -s '.[0] * .[1]' "$CLAUDE_DIR/settings.json" "$SCRIPT_DIR/settings.json" \
            > "$CLAUDE_DIR/settings.json.tmp" \
            && mv "$CLAUDE_DIR/settings.json.tmp" "$CLAUDE_DIR/settings.json"
        echo "  Merged into existing settings.json"
    else
        cp "$SCRIPT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
        echo "  Created settings.json"
    fi
else
    echo "  WARNING: jq not found, cannot merge settings."
    echo "  Install jq or manually copy settings.json to $CLAUDE_DIR/settings.json"
fi

# 3. Install devcontainer
echo "Installing devcontainer..."
mkdir -p "$CLAUDE_DIR/.devcontainer"
cp "$SCRIPT_DIR"/devcontainer/* "$CLAUDE_DIR/.devcontainer/"
chmod +x "$CLAUDE_DIR/.devcontainer/init-firewall.sh"
echo "  Installed to $CLAUDE_DIR/.devcontainer/"

echo ""
echo "Done! To use the sandbox with bypass permissions:"
echo "  claude --dangerously-skip-permissions"
