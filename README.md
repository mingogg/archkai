# Custom Arch Linux Installer  
**Version: 1.0**

A minimal, opinionated Arch Linux installer focused on **full system ownership, transparency, and control**, without sacrificing usability or visual consistency.

This project provides a **structured but flexible installation flow**, inspired by Arch principles and reverse-engineered concepts from Omarchy, while keeping **all logic, configuration, and customization inside a single repository**.

---

## Philosophy

This installer is not designed to automate decisions for you.

Instead, it provides:
- A **clean baseline** Arch system
- A **controlled installation flow** (step-by-step, inspectable)
- Centralized configuration in one repository
- Opinionated defaults that you can **remove, replace, or extend**
- A stylized system **without hiding how things work**

You decide:
- What gets installed
- What stays minimal
- What gets themed
- What evolves over time

Just like Arch should be.

---

## How It Works (High-Level Flow)

**Input → Process → Output**

1. You boot from an official Arch ISO  
2. You manually prepare the system (disk, network, base install)
3. You run **Executable 0** to initialize the system layout and configs
4. You reboot into your new system
5. You run the **Bootstrap** to install apps, themes, and utilities

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

```bash
ping archlinux.org
