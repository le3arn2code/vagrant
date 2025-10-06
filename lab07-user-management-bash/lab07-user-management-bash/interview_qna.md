# Interview Q&A (10 real-life)

1. **Why automate user management?**  
   Repeatability, speed, and reduced human error, especially across fleets of servers.

2. **What does `useradd -m` do?**  
   Creates the account and a home directory under `/home/<user>`.

3. **How do you set a password non-interactively?**  
   `echo "user:password" | sudo chpasswd` (in production, rotate secrets and force password reset).

4. **How do you ensure a user changes password at next login?**  
   `sudo passwd -e <user>`.

5. **How do you check if a user exists in a script?**  
   `if id "<user>" &>/dev/null; then ... fi`.

6. **How do you safely delete users and their home dirs?**  
   `sudo userdel -r <user>` and ensure they have no running processes.

7. **What’s the difference between `useradd` and `adduser`?**  
   `useradd` is low-level and non-interactive; `adduser` is a friendlier interactive tool on some distros.

8. **How do you handle users still logged in?**  
   List processes `ps -u <user>`, terminate safely, then `userdel -r`. For SSH, you may `pkill -u <user>`.

9. **How would you extend these scripts?**  
   Read from CSV, enforce password policies, logging, idempotency (skip if exists), and error handling.

10. **What compliance considerations apply?**  
    Unique passwords, rotation, audit trails, least privilege, and secure storage of credentials.
