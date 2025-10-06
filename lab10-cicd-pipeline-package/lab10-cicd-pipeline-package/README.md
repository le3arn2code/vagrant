# Lab 10: Full Automation of Deployment Pipeline (GitHub + Bash + Ansible + Cron)

This package contains the lab deliverables: README, `commands.sh`, `deploy.yml`, `inventory.ini`, `pull_changes.sh`,
`troubleshooting.md`, `interview_qna.md`, and three proof screenshots in `./screenshots/`.

## What this lab implements
- Pull latest code from GitHub using a **deploy key**.
- Deploy locally with **Ansible** and restart **nginx**.
- Automate with **cron** (hourly).

See `commands.sh` for a one-shot setup script. Proof images:
- `./screenshots/01_ansible_ok_changed.png`
- `./screenshots/02_nginx_status_and_curl.png`
- `./screenshots/03_github_index_html.png`
