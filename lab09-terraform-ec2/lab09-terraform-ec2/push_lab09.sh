#!/usr/bin/env bash
# Step 3: Git push automation for Lab 09
set -euo pipefail

LAB_DIR="lab09-terraform-ec2"
ZIP_REL_PATH="../lab09-terraform-ec2.zip"

rm -rf "${LAB_DIR}" || true
unzip -o "${ZIP_REL_PATH}" -d .

git add "${LAB_DIR}"
git commit -m "Add Lab 09: Terraform EC2 provisioning (init/plan/apply/destroy)" || echo "Nothing to commit"
git tag -f lab09
git push origin main
git push -f origin lab09
