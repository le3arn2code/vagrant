#!/usr/bin/env bash
# Step 3: Git push automation for Lab 07
set -euo pipefail

LAB_DIR="lab07-user-management-bash"
ZIP_REL_PATH="../lab07-user-management-bash.zip"

rm -rf "${LAB_DIR}" || true
unzip -o "${ZIP_REL_PATH}" -d .

git add "${LAB_DIR}"
git commit -m "Add Lab 07: Automating user management with Bash (create/delete/check) + screenshot" || echo "Nothing to commit"
git tag -f lab07
git push origin main
git push -f origin lab07
