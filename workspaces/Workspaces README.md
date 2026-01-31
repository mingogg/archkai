# Workspaces Launcher Guide

This guide explains how to use the Workspaces Launcher (via the `ALT+O` binding) to quickly launch your project scripts.

---

## 1. Overview

`openWorkspace` scans ~/workspaces for executable scripts, displays them in an interactive Walker menu, and runs the selected script.

It is useful for automatin repetitive tasks like opening editors, TMUX sessions, Docker containers, or backend/frontend environments.

---

## 2. Directory Structure

Place scripts in:
`~/.workspaces`

- Only executable scripts are detected.
- Filenames cna be descriptive (e.g., example.sh, api.sh).
- The launcher automatically trims `.sh` for display.

---

## 3. How to Use the Launcher

1. Execute `ALT+O`.
2. Select the script you want to run from the Walker menu.
3. The script executes in new terminals as defined.

- Example: 
    - Open NVIM in a workspace.  
    - Launch a TMUX session with backend/frontend panes.  
    - Auto-close NVIM and TMUX sessions after demonstration.
---

## 4. Recommendations

- Use clear, descriptive names for easy identification.  
- Scripts can open editors, TMUX sessions, Docker containers, virtual environments, logs, etc.  
- Test scripts first with simulated commands (e.g., echo + sleep) to ensure correct execution.
