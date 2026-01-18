# ARCH KAI
**Version: 1.0**

A minimal, opinionated Arch Linux installer focused on **full system ownership, transparency, and control**, without sacrificing usability or visual consistency and quality.

This project provides a **structured but flexible installation flow**, inspired by Arch principles and reverse-engineered concepts from Omarchy (yes, the inspiration for this proyect), while keeping **all logic, configuration, and customization inside a single repository**.

---

## Philosophy

This installer is not designed to automate decisions for you.

Instead, it provides:
- A **clean baseline** Arch system
- A **controlled installation flow** (step-by-step, inspectable)
- Centralized configuration in one repository
- Opinionated defaults that you can **remove, replace, or extend**
- A stylized system **without hiding how things work** (or, at least, easy to find how)

You decide:
- What gets installed (by default, it comes with my own personal apps. They're not that many)
- What stays minimal
- What gets themed
- What evolves over time

Just like Arch should be.

---

## How It Works (High-Level Flow)

1. You boot from an official Arch ISO
2. You manually prepare the system disk partitions (so, if you want dual boot, you can have it)
3. You run **0_install.sh** to initialize the system layout and configs
4. You reboot into your new system
5. You run the **archKai.sh** to install apps, themes, and utilities

Each stage is intentionally separated so you can:
- Inspect outputs
- Debug failures
- Modify behavior
- Re-run only what you need

---

## Installation Steps

### Step 1 — Boot the Arch ISO
- Download the official Arch Linux ISO
- Boot it in real hardware or a VM
- Ensure you have network connectivity

### Step 2 — Manual Preparation (Before Executable 0)
You are expected to:
- Partition disks
- Format filesystems
- Mount /mnt

#### This project intentionally does not abstract this step.

### Step 3 — Run Executable 0 (System Initialization)
Executable 0:
Sets up system structure
Applies base configuration
Prepares the environment for user-space bootstrap
Example:
bash executable-0.sh

At this stage:
No heavy applications are installed
The system remains minimal
Errors are easier to trace

Step 4 — Exit ISO and Reboot
exit
reboot


Remove the ISO and boot into your new Arch system.
Step 5 — Run Bootstrap (User Environment)
Once logged into the system:
bash bootstrap.sh

Bootstrap handles:
Application installation
Window manager / desktop setup
Themes
Utilities
Optional helpers (TUI tools, scripts)

This step is fully editable.

Installed Applications

This installer includes a curated set of applications.

To review or modify them:

Open the apps/ or bootstrap/ directory

Each package group is explicitly declared

You can add or remove packages freely

Nothing is hidden.
Nothing is auto-installed without being listed.

Built-in Bash Utilities

This project includes several helper functions designed around real usage.

Safe Power Functions

od → powerOffSafeBrave

of → rebootSafeBrave

These functions:

Detect if Brave is running

Close it cleanly before shutdown or reboot

Allow Brave to restore all tabs automatically on next startup
(no manual “Restore Pages” prompt)

This avoids session corruption and improves continuity.

Update Utilities (TUI)

updates

updatesAll

These provide:

A simple TUI wrapper around yay -Syu

Clear package lists before upgrading

Less friction than manual command execution

They are optional and removable.

Theming System

Themes are modular and reproducible.

Creating a New Theme

Copy an existing theme directory

Rename it

Modify:

Colors

GTK settings

Window manager config

Terminal theme

Register the theme in the theme loader script

The goal is:

No scattered config files

No global overrides

Everything traceable to one directory

Disclaimers

This project is intended to be run once per system

It is not designed for repeated re-install automation

Rollbacks and snapshots are intentionally omitted

You are expected to understand and own the system after installation

This is not a general-purpose installer.
This is a system ownership framework.

Project Status

Current version: 1.0

Actively evolving

Features added incrementally and deliberately

Stability prioritized over novelty

Who This Is For

Users who want to understand their system

Developers who prefer transparency over abstraction

Arch users who want structure without losing control

Anyone who believes a system should be theirs

Final Notes

After installation:

This repository becomes your system reference

You are encouraged to fork it

Remove this repo

Or evolve it into something entirely your own

That is the intended outcome.
