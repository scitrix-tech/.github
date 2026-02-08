#!/bin/bash
# Sets up the Scitrix development workspace
# Clones all repos as siblings under a common parent directory
#
# Usage:
#   ./setup-workspace.sh [workspace_dir]
#
# If workspace_dir is not provided, defaults to ./scitrix in the current directory.
# The .github repo itself should be cloned inside the workspace directory.
#
# Expected result:
#   workspace_dir/
#     .github/       <-- this repo (org-level CLAUDE.md, templates, profile)
#     backend/
#     mia/
#     website/
#     scitrix-logger/
#     iac/

set -euo pipefail

ORG="scitrix-tech"
REPOS=(".github" "backend" "mia" "website" "scitrix-logger" "iac")

WORKSPACE_DIR="${1:-$(pwd)/scitrix}"
mkdir -p "$WORKSPACE_DIR"

for repo in "${REPOS[@]}"; do
  if [ ! -d "$WORKSPACE_DIR/$repo" ]; then
    echo "Cloning $repo..."
    git clone "git@github.com:${ORG}/${repo}.git" "$WORKSPACE_DIR/$repo"
  else
    echo "$repo already exists, skipping"
  fi
done

echo ""
echo "Workspace ready at: $WORKSPACE_DIR"
echo "Open Claude Code from any repo - org conventions load automatically via @import"
