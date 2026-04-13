#!/bin/bash
# This script outputs Git branch information for your tmux status bar.
# Place this in your PATH, e.g., ~/.local/bin/tmux_git_status
# Remember to make it executable: chmod +x ~/.local/bin/tmux_git_status

# Check if we are inside a Git work tree
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    # Get the current branch name
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    # If branch name is available, display it with an icon.
    #  is a common Git branch icon from Nerd Fonts.
    if [[ -n "$branch" ]]; then
        echo " $branch"
    fi
fi
