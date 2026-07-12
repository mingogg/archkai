PRIMARY_BASH="\e[38;2;23;147;209m"
ACCENT_BASH="\e[38;2;102;217;255m"

RESET_BASH="\e[0m"

BG_BASH="\e[48;2;30;30;30m"
FG_BASH="\e[38;2;138;138;141m"

if [ -f ~/.local/bin/bash-functions ]; then
  source ~/.local/bin/bash-functions
fi

# Aliases to open files, directories & workspaces
alias of=openFile
alias od=openDirectory
alias ow=openWorkspace
alias reboot=safeBraveReboot
alias poweroff=safeBravePoweroff
alias gs='git status'
alias gp='git push'
alias ga=gitAdd
alias gc=gitCommit

PS1="\n[\[${RESET_BASH}\]\u@\h \[${FG_BASH}\]\w\[${RESET_BASH}\]\$(parse_git_info)\[${RESET_BASH}\]]\n\[${PRIMARY_BASH}\] 󰣇 \[${RESET_BASH}\] "

export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$HOME/.local/bin:$PATH"
