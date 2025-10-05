#!/bin/bash
# ==========================================
# Lab 02: File and Directory Permissions Script
# ==========================================

echo "Creating directories..."
mkdir -p ~/lab2/directory1
mkdir -p ~/lab2/directory2

echo "Creating files..."
touch ~/lab2/directory1/file1.txt
touch ~/lab2/directory2/file2.txt

echo "Setting permissions and ownership..."
chmod 744 ~/lab2/directory1/file1.txt
chmod 744 ~/lab2/directory2/file2.txt
chmod 755 ~/lab2/directory1
chmod 755 ~/lab2/directory2

USER_NAME=$(whoami)
chown $USER_NAME:$USER_NAME ~/lab2/directory1/file1.txt
chown $USER_NAME:$USER_NAME ~/lab2/directory2/file2.txt

echo "Permissions and ownership updated:"
ls -l ~/lab2
