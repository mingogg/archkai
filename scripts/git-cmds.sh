#!/usr/bin/env bash

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "⛔ Error: You are not in a Git repository."
    exit 1
fi

UNSTAGED_FILES=$(git status -s | grep -E '^.[^ ]')

if [[ -z "$UNSTAGED_FILES" ]]; then
    echo "💤 Everything is added or your worktree is clean."
    exit 0
fi

echo "$UNSTAGED_FILES" | fzf -m | awk '{print $2}' | xargs -r git add
