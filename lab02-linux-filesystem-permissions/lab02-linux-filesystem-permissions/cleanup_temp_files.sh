#!/bin/bash
# ==========================================
# Lab 02: Cleanup Temporary Files Script
# ==========================================

temp_dir=~/lab2

echo "Cleaning up files older than 7 days in $temp_dir..."
find $temp_dir -type f -mtime +7 -exec rm -f {} \;

echo "Cleanup complete."
