#!/usr/bin/env bash
# Lab 07 - Commands Script (recreates all three scripts and runs them)
set -e

echo "== Step 1: create_users.sh =="
cat > create_users.sh <<'EOS'
#!/bin/bash

# List of users to create
users=("user1" "user2" "user3")

# Loop through the user list and create each user
for user in "${users[@]}"; do
  # Create the user
  sudo useradd -m "$user"
  
  # Set a default password for the user
  echo "$user:password123" | sudo chpasswd
  
  # Provide feedback
  echo "User $user created successfully!"
done
EOS
chmod +x create_users.sh
sudo ./create_users.sh
cat /etc/passwd | grep "user" || true

echo "== Step 2: delete_users.sh ==""
cat > delete_users.sh <<'EOS2'
#!/bin/bash

# List of users to delete
users=("user1" "user2" "user3")

# Loop through the user list and delete each user
for user in "${users[@]}"; do
  # Check if the user exists
  if id "$user" &>/dev/null; then
    # Delete the user
    sudo userdel -r "$user"
    
    # Provide feedback
    echo "User $user deleted successfully!"
  else
    echo "User $user does not exist!"
  fi
done
EOS2
chmod +x delete_users.sh
sudo ./delete_users.sh
cat /etc/passwd | grep "user" || true

echo "== Step 3: check_user_existence.sh =="
cat > check_user_existence.sh <<'EOS3'
#!/bin/bash

# Ask for the username to check
read -p "Enter username to check: " username

# Check if the user exists
if id "$username" &>/dev/null; then
  echo "User $username exists!"
else
  echo "User $username does not exist!"
fi
EOS3
chmod +x check_user_existence.sh
# Interactive: ./check_user_existence.sh

echo "Lab 07 scripts created. Run ./check_user_existence.sh to test."
