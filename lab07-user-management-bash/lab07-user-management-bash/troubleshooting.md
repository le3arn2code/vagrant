# Troubleshooting

- **useradd: user '<name>' already exists**  
  Delete first or change names:
  ```bash
  sudo userdel -r <name>
  ```

- **userdel: user <name> is currently used by process <PID>**  
  The user is logged in / running a process:
  ```bash
  ps -u <name>
  sudo kill -9 <PID>
  sudo userdel -r <name>
  ```

- **Mail spool not found** (e.g., `/var/mail/user1`)  
  Harmless—proceed; deletion still works.

- **Permission denied** running scripts  
  Make them executable: `chmod +x *.sh` and use `sudo` where needed.

- **`id: user does not exist`**  
  Expected if the user hasn’t been created or was deleted.

- **Tool mismatch (`adduser` vs `useradd`)**  
  On Ubuntu, `useradd` is available. On other distros, prefer the available tool or install it.
