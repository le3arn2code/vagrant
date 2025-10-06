
# Interview Q&A (10)
1) Why use deploy keys? — Least-privilege, repo-scoped access.
2) How does Ansible ensure idempotency? — Modules converge state; repeated runs don't re-apply unchanged tasks.
3) How to avoid storing tokens on the VM? — Use SSH deploy keys, not HTTPS with PAT.
4) How to trigger on commit instead of cron? — Webhooks or GitHub Actions that SSH/rsync to the VM.
5) How to roll back quickly? — Checkout a previous commit/tag and re-run the play.
6) How to deploy to multiple hosts? — Add hosts to inventory; Ansible runs tasks in parallel.
7) How to secure secrets? — Ansible Vault or external secret managers.
8) Why accept_hostkey in git task? — Ensures first-time trust of GitHub host key non-interactively.
9) How to handle nginx config changes? — Test with `nginx -t`; use `state: reloaded` for zero-downtime where possible.
10) How to separate envs (dev/stage/prod)? — Different inventories/vars; separate cron or CI jobs per env.
