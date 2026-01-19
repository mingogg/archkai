# Workspaces Launcher Guide

This guide explains how to use the **Workspaces Launcher** (via the `ow` alias) and organize your workspace scripts.

---

## 1. Overview

The `openWorkspace` function helps you quickly run predefined workspace scripts using the `ow` alias. It works by:

- Scanning a specific directory for scripts.
- Listing them in an interactive menu.
- Executing the selected script in a new terminal.

It is useful for automating repetitive tasks like opening editors, TMUX sessions, Docker containers, or backend/frontend environments.

---

## 2. Directory Structure

Scripts should be placed in:

`~/workspaces/ow/`

- Only scripts inside `ow/` will be detected.  
- Example scripts (e.g., `ws_example.sh` and `tmux_example.sh`) are in the parent folder.  
  - To run them, **copy or move them into `ow/`**.  
- You can organize subfolders, but all executable scripts must follow the naming convention below.

---

## 3. Script Naming Convention

Scripts must follow:

`ws_<script_name>.sh`

- `ws_` prefix is required.  
- `<script_name>` can be descriptive (e.g., `ws_example.sh`, `ws_api.sh`).  
- This ensures scripts appear in the launcher menu.

---

## 4. How to Use the Launcher

1. Open a terminal.  
2. Run the `ow` alias.  
3. The launcher scans `~/workspaces/ow/` for scripts matching `ws_*`.  
4. A numbered menu displays all detected scripts.  
5. Enter the index of the script to execute.  
6. The script runs in a new terminal.
7. Examples show how to:
    - Open NVIM in one workspace.  
    - Launch a TMUX session with backend/frontend panes.  
    - Auto-close TMUX sessions after demonstration.

**Example output:**  
Select the script to execute:  
1) ws_example.sh  
2) ws_api.sh  

Select index: 1  
Executing: ws_example.sh  

---

## 5. Recommendations

- Use clear, descriptive names for easy identification.  
- Create as many scripts as needed to automate your workflow.  
- Scripts can open editors, TMUX sessions, Docker containers, virtual environments, logs, etc.  
