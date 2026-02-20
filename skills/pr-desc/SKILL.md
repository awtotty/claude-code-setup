---
name: pr-desc
description: "Write a short PR description for the current branch to a file."
---

# PR Description

Write a concise pull request description for the current branch.

## Steps

1. Determine the base branch (usually `main`) and the current branch name
2. Run `git diff main...HEAD` to see all changes on this branch
3. Run `git log main..HEAD --oneline` to understand the commit history
4. Read any files that need fuller context to understand the changes

5. Write the PR description to `pr-desc.md` in the repo root

## Description Format

The file should include:

- **Title**: A short PR title (under 70 characters)
- **Summary**: 1-3 bullet points describing what the changes do and why
- **Test plan**: Brief checklist of how to verify the changes

Keep it short and focused on the "why", not the "what". Do not pad with unnecessary detail.
