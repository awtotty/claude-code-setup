---
name: delegate
description: "Delegate tasks to a team of agents working in isolated git worktrees."
---

# Orchestrate

Delegate the user's tasks to a team of agents, each working in an isolated git worktree so changes don't conflict.

## Steps

1. **Understand the work**: Read the user's request and break it into independent, parallelizable tasks. Explore the codebase enough to write detailed task descriptions with file paths, patterns to follow, and acceptance criteria.

2. **Create worktrees**: For each task, create a git worktree branching from the current branch:
   ```
   git worktree add ../<worktree-name> -b <branch-name> <current-branch>
   ```

3. **Copy dotfiles**: Check for uncommitted dotfiles in the main worktree that are needed for builds, type-checking, or similar (e.g., `.env.keys`, `.env.local`, `.env`). Copy them to each worktree.

4. **Pick models**: Choose the right model for each agent based on task complexity:
   - **sonnet**: Pattern-following tasks, well-defined changes with clear examples
   - **opus**: Ambiguous tasks, architectural decisions, complex multi-file refactors

5. **Create a team and delegate**: Create a team, create tasks, and spawn agents with `run_in_background: true` and `mode: "bypassPermissions"`. Each agent's prompt must include:
   - Its working directory (the worktree path)
   - Detailed description of what to create/modify, with code examples where helpful
   - Instructions to run validation (`pnpm type-check`, `pnpm lint`, `pnpm format` or equivalent)
   - Instructions to commit changes and message the team lead when done

6. **Monitor and report**: Keep the user posted on progress. When agents finish, verify their commits.

7. **Clean up**: Once all work is done:
   - Shut down all agents
   - Remove worktrees with `git worktree remove` (branches are preserved)
   - Delete the team
   - Report final summary with branch names and commit hashes so the user can test
