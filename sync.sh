#!/usr/bin/env bash
set -euo pipefail

SOURCE="/Users/neeldhara/repos/nm-obsidian/teaching/problems/"
TARGET="/Users/neeldhara/repos/nm-apps/problems/"

rsync -av --delete --exclude='.git' --exclude='sync.sh' "$SOURCE" "$TARGET"

cd "$TARGET"
git add -A
if [ -n "$(git status --porcelain)" ]; then
  git commit -m "sync $(date -u +%Y-%m-%dT%H:%M:%S)"
  git push
  echo "Pushed changes."
else
  echo "Nothing changed."
fi
