#!/bin/bash
GREEN="\033[32m"
RESET="\033[0m"

SCRIPTS_DIR="$HOME/workspaces/ow"
PATTERN="ws_*"

# Habilitar nullglob para que los patrones vacíos no aparezcan literal
shopt -s nullglob
scripts=( "$SCRIPTS_DIR"/$PATTERN )
shopt -u nullglob  # opcional: deshabilitar nullglob después

if [ ${#scripts[@]} -eq 0 ]; then
  echo "Scripts not found!"
  exit 1
fi

echo
echo "Select the script to execute:"
for i in "${!scripts[@]}"; do
  printf "%d) ${GREEN}%s${RESET}\n" $((i+1)) "$(basename "${scripts[i]}")"
done

read -p "Select index: " choice

if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt ${#scripts[@]} ]; then
  echo "Invalid selection"
  exit 1
fi

selected_script="$(basename "${scripts[$((choice-1))]}")"
execute_script="${scripts[$((choice-1))]}"
echo
echo -e "Executing: ${GREEN}$selected_script${RESET}"
bash "$execute_script"
