# Exclude these directories from the search in functions like openFile, openDirectory
EXCLUDED=(
  -path '*/v/*' -prune -o
  -path '*/venv' -prune -o
  -path '*/.git' -prune -o
  -path '*/.nvm' -prune -o
  -path '*/.npm' -prune -o
  -path '*/.tmux' -prune -o
  -path '*/.venv' -prune -o
  -path '*/Cache' -prune -o
  -path '*/.local' -prune -o
  -path '*/.cache' -prune -o
  -path '*/Coding' -prune -o
  -path '*/.cfigs' -prune -o
  -path '*/Typora/*' -prune -o
  -path '*/.eclipse' -prune -o
  -path '*/.mozilla' -prune -o
  -path '*/.vscode/*' -prune -o
  -path '*/chromium/*' -prune -o
  -path '*/node_modules' -prune -o
  -path '*/node_modules/*' -prune -o
  -path '*/.config/Postman' -prune -o
  -path '*/.config/discord' -prune -o
  -path '*/microsoft-edge-dev' -prune -o
  -path '*/.config/libreoffice' -prune -o
  -path '*/.config/BraveSoftware/*' -prune -o
)

# This function is a 'replacement' for 'nvim fileName'
# Searchs for a file, in the system/current folder and returns a index if there is more than 1 match
# else it opens it in nvim, you do not have to use the full name for it to work.
# If you have a file named 'dotfiles', you can search for 'dot'.
# usage: in terminal write 'of fileName'
function openFile() {
    local search="$1"
    local results
    IFS=$'\n' read -d '' -r -a results < <(
        command find . "${EXCLUDED[@]}" -type f -iname "*$search*" -print 2>/dev/null
    )
    local count=${#results[@]}

    echo
    if [[ $count -eq 0 ]]; then
        echo "  Unable to find files relative to '$search'"
        return
    elif [[ $count -eq 1 ]]; then
        echo "  Opening: ${results[0]}"
        nvim "${results[0]}"
        return
    fi

    BLUE=$(tput setaf 4)
    GRAY=$(tput setaf 8)
    RESET=$(tput sgr0)

    echo "  Found files:"
    echo
    for i in "${!results[@]}"; do
        rel_path=$(realpath --relative-to="$PWD" "${results[$i]}")
        base_name=$(basename "${results[$i]}")

        if [[ $base_name == .* ]]; then
            symbol=" "
            color=$GRAY
        else
            symbol=" "
            color=$BLUE
        fi
        printf " %2d) %b %s%b\n" "$i" "$color$symbol" "./$rel_path" "$RESET"
    done

    echo
    read -p "Select file: " choice
    echo
    if [[ "$choice" =~ ^[0-9]+$ ]] && [[ $choice -lt $count ]]; then
        nvim "${results[$choice]}"
    else
        echo "  Invalid choice"
    fi
}

# This function is a 'replacement' for 'cd'
# Searchs for a folder, in the system and returns a index if there is more than 1 match
# else it opens it, you do not have to use the full name for it to work.
# If you have a folder named 'dotfiles', you can search for 'dot'.
# usage: in terminal write 'od folderName'
function openDirectory() {
    local search="$1"
    local dirs
    IFS=$'\n' read -d '' -r -a dirs < <(
        command find "$HOME" "${EXCLUDED[@]}" -type d -iname "*$search*" -print 2>/dev/null
    )
    local count=${#dirs[@]}

    echo
    if [[ $count -eq 0 ]]; then
        echo "  No directories found matching '$search'"
        return
    elif [[ $count -eq 1 ]]; then
        echo "  Moving to: $(realpath --relative-to="$HOME" "${dirs[0]}")"
        cd "${dirs[0]}"
        echo
        ls
        return
    fi

    local display_paths=()
    for dir in "${dirs[@]}"; do
        rel_path=$(realpath --relative-to="$HOME" "$dir")
        IFS='/' read -ra parts <<< "$rel_path"
        # Show at least the last two leves of path
        display_path="${parts[-2]}/${parts[-1]}"
        display_paths+=("$display_path")
    done

    local changed=1
    while [[ $changed -eq 1 ]]; do
        changed=0
        local tmp_paths=()
        for i in "${!display_paths[@]}"; do
            local count_same
            count_same=$(printf "%s\n" "${display_paths[@]}" | grep -c "^${display_paths[$i]}$")
            if [[ $count_same -gt 1 ]]; then
                # Adds an extra level of path if there is more parts available
                IFS='/' read -ra parts <<< "$(realpath --relative-to="$HOME" "${dirs[$i]}")"
                if [ ${#parts[@]} -gt 2 ]; then
                    display_paths[$i]="${parts[-3]}/${display_paths[$i]}"
                    changed=1
                else
                    # If there is no more levels, it leaves the full path
                    # No hay más niveles, dejamos la ruta completa
                    display_paths[$i]=$(realpath --relative-to="$HOME" "${dirs[$i]}")
                fi
            fi
        done
    done

    BLUE=$(tput setaf 4)
    GRAY=$(tput setaf 8)
    RESET=$(tput sgr0)

    echo "  Found directories:"
    echo
    for i in "${!dirs[@]}"; do
        base_name=$(basename "${dirs[$i]}")
        if [[ $base_name == .* ]]; then
            symbol=" "
            color=$GRAY
        else
            symbol=" "
            color=$BLUE
        fi
        printf " %2d) %b %s%b\n" "$i" "$color$symbol" "${display_paths[$i]}" "$RESET"
    done

    echo
    read -p "Select folder: " choice
    echo
    if [[ "$choice" =~ ^[0-9]+$ ]] && [[ $choice -lt $count ]]; then
        cd "${dirs[$choice]}"
        echo "  Moved to: $(realpath --relative-to="$HOME" "${dirs[$choice]}")"
        echo
        ls
    else
        echo "  Invalid choice"
    fi
}

# Easy cmd to add staged files
function gitAdd() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "⛔ Error: You are not in a Git repository."
        return 1
    fi

    local unstaged_files
    unstaged_files=$(git status -s | grep -E '^.[^ ]')

    if [[ -z "$unstaged_files" ]]; then
        echo "💤 Everything is added or your worktree is clean."
        return 0
    fi

    echo "$unstaged_files" | fzf -m | awk '{print $2}' | xargs -r git add
}


# Easy cmds to commit in git
function gitCommit() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "⛔ Error: You are not in a Git repository."
        return 1
    fi

    if [[ $# -eq 0 ]]; then
        echo "⛔ Error: Provide a commit message."
        echo "Usage: gm My commit message here"
        return 1
    fi
    
    git commit -m "$*"
}

# Git info in prompt
PRIMARY_BASH="\e[38;2;23;147;209m"
GIT_CLEAN_BASH="\e[38;2;245;176;65m"
GIT_DIRTY_BASH="\e[38;2;217;102;102m"
parse_git_info() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local branch status added modified untracked
        local start=$'\001'
        local end=$'\002'
        
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
        status=$(git status --porcelain 2>/dev/null)

        if [[ -n "$status" ]]; then
            added=$(echo "$status" | grep '^A' | wc -l)
            modified=$(echo "$status" | grep '^ M' | wc -l)
            untracked=$(echo "$status" | grep '^??' | wc -l)

            printf " | git:%s ${start}${GIT_DIRTY_BASH}${end}✘ ${start}${FG}${end}" "$branch"
            [[ $modified -gt 0 ]] && printf " ~$modified"
            [[ $untracked -gt 0 ]] && printf " ?$untracked"
        else
            printf " | git:%s ${start}${PRIMARY_BASH}${end}✔ ${start}${FG}${end}" "$branch"
        fi
    fi
}
