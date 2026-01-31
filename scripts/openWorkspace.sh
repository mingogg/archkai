#!/usr/bin/env bash

PROJECTS_DIR="$HOME/workspaces"

shopt -s nullglob
files=( "$PROJECTS_DIR"/*.sh )
shopt -u nullglob

[ ${#files[@]} -eq 0 ] && exit 0

display=()
real=()

for f in "${files[@]}"; do
  name="${f##*/}"
  name="${name%.sh}"
  display+=("$(echo "$name" | xargs)")
  real+=( "$f" )
done

selected=$(printf "%s\n" "${display[@]}" | walker -d -p "Workspaces")

[ -z "$selected" ] && exit 0

for i in "${!display[@]}"; do
  if [[ "${display[$i]}" == "$selected" ]]; then
    bash "${real[$i]}" &
    disown
    break
  fi
done
