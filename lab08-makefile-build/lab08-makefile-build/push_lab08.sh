#!/usr/bin/env bash
# Step 3: Git push automation for Lab 08
set -euo pipefail

LAB_DIR="lab08-makefile-build"
ZIP_REL_PATH="../lab08-makefile-build.zip"

rm -rf "${LAB_DIR}" || true
unzip -o "${ZIP_REL_PATH}" -d .

git add "${LAB_DIR}"
git commit -m "Add Lab 08: Makefile build, test, install, and packaging" || echo "Nothing to commit"
git tag -f lab08
git push origin main
git push -f origin lab08
