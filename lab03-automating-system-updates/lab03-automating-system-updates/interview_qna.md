# Interview Q&A (Unique)

1. **Q:** What is a cron job?  
   **A:** A cron job is a scheduled task that runs automatically.

2. **Q:** Why automate updates?  
   **A:** It improves security and ensures timely patching.

3. **Q:** What does `2>&1` do?  
   **A:** It redirects error messages to the same log as normal output.

4. **Q:** How can we verify cron runs?  
   **A:** Use `grep CRON /var/log/syslog` or check log files.

5. **Q:** How to prevent cron overlap?  
   **A:** Use `flock` to lock execution.

6. **Q:** Why use `sudo` in automation?  
   **A:** To run privileged commands safely.

7. **Q:** Where are apt logs stored?  
   **A:** `/var/log/apt/history.log`.

8. **Q:** How to temporarily disable a cron job?  
   **A:** Comment it out with `#` in crontab.

9. **Q:** Why add `-y` in apt commands?  
   **A:** It auto-confirms installation prompts.

10. **Q:** What’s the difference between `apt update` and `apt upgrade`?  
    **A:** `update` refreshes lists; `upgrade` installs newer versions.
