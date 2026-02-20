---
name: pr-review
description: "Review the current branch as if reviewing a PR. Writes the review to a file."
---

# PR Review

Review the current branch as a thorough code reviewer would review a pull request.

## Steps

1. Determine the base branch (usually `main`) and the current branch name
2. Run `git diff main...HEAD` to see all changes on this branch
3. Run `git log main..HEAD --oneline` to understand the commit history
4. Read any files that need fuller context to understand the changes
5. Write a detailed review to `pr-review.md` in the repo root

## Review Format

The review file should include:

- **Branch**: current branch name
- **Summary**: What the changes do overall
- **File-by-file review**: For each changed file, note what changed and any concerns
- **Issues found**: Bugs, logic errors, security concerns, style problems, missing edge cases
- **Suggestions**: Improvements, simplifications, or alternatives
- **Verdict**: Approve, request changes, or comment-only

Be direct and specific. Reference file paths and line numbers. Focus on things that matter — correctness, security, maintainability — not nitpicks.
