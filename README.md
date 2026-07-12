# ARCH KAI
![Presentation PIC](https://i.imgur.com/IEeFqoj.jpeg)

## Description

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
- What gets installed (by default, it comes with my curated set of personal apps)
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

### 1. Create Partitions
#### Small guide example — adapt it to your needs.

- Execute ```cfdisk```
- Select partition table type: `gpt`

##### Select the disk you want to partition
- Create a new partition of `512M`
- Set type as `EFI System`

##### Select the disk again
- Select the remaining space (or the size you prefer)
- Set type as `Linux filesystem`
- Write changes and quit

---

### 2. Format Partitions
**⚠️ WARNING: This will erase all data on the selected partitions**

Assume the following mapping:
- `EFI  → /dev/sda1`
- `ROOT → /dev/sda2`

#### Execute:
- ```mkfs.fat -F32 /dev/sda1```
- ```mkfs.ext4 /dev/sda2```

---

### 3. Mount Partitions
Using the same partition examples as above, execute:

- ```mount /dev/sda2 /mnt```
- ```mkdir -p /mnt/boot```
- ```mount /dev/sda1 /mnt/boot```

###### Note: You need to activate your internet connection at this point.
---

### 4. Clone the Repository from the Live ISO

#### Execute the following commands:
- ```pacman -Sy```
- ```pacman -S git```
- ```git clone https://github.com/mingogg/archkai```
- ```cd archkai/bootstrap```
- ```./0_install.sh```

#### During execution, you will be prompted for:
- `HOSTNAME`
- `USERNAME`
- **ROOT** password (with confirmation)
- **USER** password (with confirmation)

#### If the installation succeeds, you will see:
**LEVEL 0 PROCESS IS FINISHED**  
**Host set as:** *HOSTNAME*  
**User set as:** *USERNAME*  
**You can now execute:** `umount -R /mnt && reboot`

Follow the instruction above.  
After rebooting without the ISO, you will be able to log in with your user.

---

### 5. Post-Install (User Environment Setup)

After logging in, execute the following commands one last time:

###### Note: You need to activate your internet connection at this point.

- ```git clone https://github.com/mingogg/archkai```
- ```cd archkai/bootstrap```
- ```./archkai.sh```

##### Note:
You will be asked for your user password multiple times during this process.

Once the installation finishes, reboot and enjoy your new system.

###### Note: After rebooting, the Ly login manager may default to 'Hyprland (uwsm-managed)'. Please select 'Hyprland' manually the first time.

### Bootstrap Handles
##### Application installation | Desktop setup | Themes | Utilities | Optional helpers

This step is fully editable.

---

#### Installed Applications
This installer includes a curated set of applications.

##### To review or modify them:
Open `bootstrap/install_apps.sh`

Each package group is explicitly declared.  
You can add or remove packages freely.  
###### Nothing is hidden. Nothing is auto-installed without being listed.

---

### Built-in Bash Utilities

This project includes several helper functions designed around real usage, divided into system navigation and version control.

#### Navigation & Workflows
- `od` → **OpenDirectory**: searches for directories by partial match and opens them.  
  Example: `od kai` → opens `archKai` if found.  
  If multiple matches exist, you can select one via an index.  
  **Note:** always searches from `/home`, so you can use it from anywhere.
- `of` → **OpenFile**: same as OpenDirectory but for files.  
  **Note:** searches from the *root of your current folder*.  
  Best used from `/home` for predictable behavior.
- `OpenWorkspace` → launches predefined workspace scripts located in `~/workspaces` using `ALT+O` binding.  
  It lists all executable scripts in an interactive Walker menu, showing clean names without the `.sh` extension.  
  Scripts can launch NVIM, TMUX sessions, Docker containers, backend/frontend environments, or any custom workflow commands.  

#### Git Utilities
- `gs` → executes `git status`.
- `gp` → executes `git push`.
- `ga` → **Interactive Git Add**: checks for unstaged or modified files and opens an interactive `fzf` menu.  
  Allows you to visually select exactly which files to stage.  
  **Note:** You can select multiple files at once using `TAB` before pressing `ENTER`.
- `gc` → **Git Commit**:
  If run without arguments, executes `git commit`.  
  If run with arguments, it acts as `git commit -m`.  
  Example: `gc 'feat(core): update & fix logic'` (use quotes if your message contains special symbols).

---

#### Safe Power Functions
- `safeBravePoweroff` & `safeBraveReboot`

These are integrated with all menus and available as aliases for `poweroff` and `reboot`.  
When used, they:
- Detect if Brave is running
- Close it cleanly before shutdown or reboot
###### This allows Brave to restore all tabs automatically on next startup, avoiding manual “Restore Pages” prompts and session corruption.

---

#### Update Utilities (TUI, integrated in Waybar)
- `updates`
- `updatesAll`

Provide a simple TUI wrapper around `yay -Syu`:
- Clears package lists before upgrading
- Reduces friction compared to manual command execution
- Fully optional and removable

This makes system updates fast while keeping full control.

---

### Theming System
Themes are modular and fully reproducible.

#### Creating a New Theme
- Copy an existing theme directory into `~/.config/theme`
- Rename it and update the `color.sh` settings for each app to maintain consistency (or not, depends on you, lol)
- To change the wallpaper, simply replace it with your own image named `wpp.jpg`
- **Remember to keep these colors configs/variables intact.** The scripts use sed to modify the colors, which isn’t very robust, but it makes creating new themes easier. As long as you don’t modify the variables used by sed in `~/.local/change-theme`, everything should work fine and you can add your own configurations in every app without problems.

**Goal:**  
- No scattered config files  
- No global overrides  
- Everything traceable to one directory

---

### Disclaimers

##### Scripts

This project is intended to be executed **once per system**.  
The following scripts are **idempotent** and safe to re-run if needed:
- `archkai.sh`
- `enable.sh`
- `install_apps.sh`
- `links.sh`

⚠️ `0_install.sh` must **not** be re-run.  
It is intended to run **once during base installation**. Re-executing it on an existing system may overwrite user accounts, configuration files, bootloader settings, and mount points, potentially breaking the system.

Once the base installation is complete and you start using `archkai.sh`, the system is considered fully set up.

From that point forward, the system is yours to understand, maintain, and modify.  
Re-running `archkai.sh` is only intended to install missing packages, not to reset the system.

##### Localization defaults

This system is configured with predefined localization settings.
Timezone is set to America/Asuncion as this is my timezone, and the default locale is en_US.UTF-8.

If your region or language differs, you are expected to adjust these settings manually after installation.

##### Graphics drivers
This system does not automatically install graphics drivers.
Depending on your GPU, you may need to install proprietary or open-source drivers manually.

⚠️ For example, on my system I had to install NVIDIA drivers (`nvidia`, `nvidia-utils`, etc.).
Other GPUs (AMD, Intel) may require different packages or configuration.
Please consult your hardware documentation to ensure proper setup.

##### Inspiration

I studied Omarchy in depth and learned a lot from its design.  
This project is not a copy—it is my personal system built with control and understanding in mind.  
While you may notice similarities, all credit for inspiration goes to the original (*and amazing*) Omarchy engineering.  

---

### Project Status
- Current version: 2.0.10  
- Actively evolving  
- Features added incrementally and deliberately  
- Stability prioritized over novelty

---

## Who This Is For
- Users who want to understand their system  
- Developers who prefer transparency over abstraction  
- Arch users who want structure without losing control  
- Anyone who believes a system should be theirs

---

## Final Notes

### **This. Is. Yours.**
You. Own. Your. System.  
This is a system ownership framework, not a general-purpose installer.

#### So be aware: "With great power comes great responsibility."

After installation:
- This repository becomes your system reference  
- You are encouraged to fork it, remove it, or evolve it into something entirely your own  

### **That is the intended outcome.**
