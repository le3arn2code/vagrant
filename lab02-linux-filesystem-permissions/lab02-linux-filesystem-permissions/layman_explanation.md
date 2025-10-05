# 🧠 Layman Explanation - Lab 02: Linux File System Navigation & Permissions

In this lab, we practiced how to manage files and directories using **Bash scripting** in Linux.  
Here’s what we did, in simple terms:

1. **Created directories and files:**  
   We wrote a script (`create_files_and_dirs.sh`) that automatically made folders and files in our home directory.  
   Instead of manually typing `mkdir` and `touch` each time, the script did it for us.

2. **Set permissions and ownership:**  
   We used `chmod` to decide **who can read, write, or execute** files.  
   - `744` → Owner can read/write/execute, others can only read.  
   - `755` → Common for folders — owner can do everything, others can read and execute only.  
   We also used `chown` to make sure files belong to the current user.

3. **Cleaned up old files:**  
   We created another script (`cleanup_temp_files.sh`) that searched for files older than **7 days** and deleted them automatically using the `find` command.

4. **Verified with real output:**  
   - We listed files using `ls -l` to confirm permissions.  
   - Then we changed file timestamps to simulate old files and confirmed the cleanup worked.

This lab teaches **real-world system admin skills** — organizing files, securing access, and automating maintenance.  
These are daily tasks for any **DevOps engineer** or **Linux administrator**.
