# 🧰 Vagrant & DevOps Labs (Labs 01–10)

A hands‑on collection of **DevOps mini‑labs** you can run locally. The early labs use **Vagrant (with Docker provider)** to spin up disposable environments; others focus on **Linux automation, Ansible, Nginx, Makefiles, Terraform on AWS EC2,** and a **CI/CD packaging lab**. Everything follows a consistent, GitHub‑ready structure so you can learn fast and showcase real work.

> **Repo:** `le3arn2code/vagrant`  •  **Status:** Active  •  **Scope:** Labs 01–10

---

## 📌 Table of Contents
- [Why this repo?](#-why-this-repo)
- [Prerequisites](#-prerequisites)
- [Quick Start](#-quick-start)
- [Lab Index (01–10)](#-lab-index-0110)
- [Repository Structure](#-repository-structure)
- [Conventions](#-conventions)
- [Common Run Paths](#-common-run-paths)
  - [Vagrant (Docker provider)](#vagrant-docker-provider)
  - [Linux / Bash automation](#linux--bash-automation)
  - [Ansible](#ansible)
  - [Nginx automation](#nginx-automation)
  - [Makefile](#makefile)
  - [Terraform on AWS EC2](#terraform-on-aws-ec2)
  - [CI/CD package (Lab 10)](#cicd-package-lab-10)
- [Troubleshooting](#-troubleshooting)
- [Roadmap](#-roadmap)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Why this repo?

- **Practice by doing**: Each lab is a bite‑sized, realistic task (with deliverables).
- **Reproducible**: All labs follow a consistent structure—`README.md`, `commands.sh`, `troubleshooting.md`, and where relevant `interview_qna.md` and config files.
- **Production‑adjacent**: Uses the same tools you’ll meet in real teams: Vagrant, Docker, Ansible, Nginx, Makefiles, Terraform, and CI/CD packaging.

---

## 🧱 Prerequisites

> You don’t need everything for every lab—refer to the lab’s own README for specifics.

- **Git** ≥ 2.40
- **Linux shell** (WSL/Ubuntu, macOS, or a Linux VM)
- **Vagrant** ≥ 2.3 (with **Docker** ≥ 24 if using the Docker provider)
- Optional (per lab):
  - **Ansible** ≥ 2.14
  - **Terraform** ≥ 1.6 and an **AWS account** with IAM credentials
  - **Nginx** (installed inside a lab VM or on a host)
  - **Make** (GNU make)

---

## ⚡ Quick Start

```bash
# 1) Clone
git clone https://github.com/le3arn2code/vagrant.git
cd vagrant

# 2) Pick a lab directory
cd lab01-vagrant-intro/lab01-vagrant-intro-final

# 3) Read the lab's README, then run its commands
nano README.md
bash commands.sh   # or run the steps manually
```

> Each lab is self‑contained. Always read the lab‑level README first.

---

## 📚 Lab Index (01–10)

- **Lab 01 — Introduction to Vagrant (Docker provider)**  
  Provision a containerized dev environment quickly with Vagrant + Docker.
- **Lab 02 — Linux Filesystem Permissions**  
  Practice `chmod`, `chown`, `umask`, and permission strategy.
- **Lab 03 — Automating System Updates with Bash**  
  Script updates, logs, idempotency, and cron‑friendly patterns.
- **Lab 04 — Ansible Intro**  
  Inventory, basic playbook, ad‑hoc commands, and YAML structure.
- **Lab 05 — Networking Scripts**  
  Small utilities for IP checks, routes, and connectivity verification.
- **Lab 06 — Nginx Automation**  
  Install, configure, and validate Nginx with repeatable steps.
- **Lab 07 — User Management with Bash**  
  Create/delete/check users and groups safely; log/rollback patterns.
- **Lab 08 — Makefile Build/Test/Install/Package**  
  Encapsulate workflows with make targets like `build`, `test`, `install`, `package`.
- **Lab 09 — Terraform EC2 Provisioning**  
  `init/plan/apply/destroy` for a minimal EC2; variables and outputs.
- **Lab 10 — CI/CD Pipeline Package**  
  Deliverables bundle (README, `commands.sh`, `deploy.yml`, `inventory.ini`, screenshots) to simulate a real pipeline handoff.

> New labs will continue this structure so your portfolio stays consistent.

---

## 🗂 Repository Structure

```
vagrant/
├── lab01-vagrant-intro/
│   └── lab01-vagrant-intro-final/
├── lab02-linux-filesystem-permissions/
│   └── lab02-linux-filesystem-permissions/
├── lab03-automating-system-updates/
│   └── lab03-automating-system-updates/
├── lab04-ansible-intro/
│   └── lab04-ansible-intro/
├── lab05-networking-scripts/
├── lab06-nginx-automation/
├── lab07-user-management-bash/
├── lab08-makefile-build/
├── lab09-terraform-ec2/
└── lab10-cicd-pipeline-package/
```

> Inside each lab you’ll typically find:  
> `README.md`, `commands.sh`, `troubleshooting.md`, `interview_qna.md`, plus any configs (e.g., `deploy.yml`, `inventory.ini`), and a `screenshots/` folder.

---

## 🔖 Conventions

- **Folder & ZIP name:** `labXX-<topic>`  
- **Files:**  
  - `README.md` — objectives, steps, outputs, and conclusion  
  - `commands.sh` — copy‑paste friendly commands (nano‑friendly, commented)  
  - `troubleshooting.md` — real errors and fixes captured during the lab  
  - `interview_qna.md` — ~10 practical Q&A per lab (where relevant)  
  - `screenshots/` — actual images proving the result  
- **Tags:** Git tags like `lab01`, `lab02`, … for clean history

---

## 🧪 Common Run Paths

### Vagrant (Docker provider)
```bash
# From a lab with a Vagrantfile
vagrant up --provider=docker
vagrant status
vagrant ssh
vagrant destroy -f
```

### Linux / Bash automation
```bash
bash commands.sh
# or step-by-step as described in the lab README
```

### Ansible
```bash
ansible -i inventory.ini all -m ping
ansible-playbook -i inventory.ini deploy.yml
```

### Nginx automation
```bash
sudo nginx -t
sudo systemctl restart nginx
curl -I http://localhost
```

### Makefile
```bash
make help
make build
make test
make install
make package
```

### Terraform on AWS EC2
```bash
export AWS_PROFILE=<your-profile>   # or set AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY
terraform init
terraform plan -out=tfplan
terraform apply tfplan
terraform destroy -auto-approve
```

### CI/CD package (Lab 10)
Deliverables include `README.md`, `commands.sh`, `deploy.yml`, `inventory.ini`, and screenshots to simulate an end‑to‑end pipeline handoff.

---

## 🛠 Troubleshooting

- **Vagrant + Docker provider**
  - Ensure Docker is running and your user can run Docker commands (on Linux, add user to `docker` group).
  - Use `vagrant destroy -f && vagrant up` to reset a broken environment.
- **Terraform on AWS**
  - Check credentials and region: `aws sts get-caller-identity`, `aws configure list`.
  - Destroy leftover state if a plan fails; keep an eye on quotas and free‑tier limits.
- **General**
  - Capture exact error logs in each lab’s `troubleshooting.md` so you (and reviewers) see real fixes.

---

## 🧭 Roadmap

- [ ] Standardize `Makefile` targets across labs where applicable
- [ ] Add GitHub Actions CI for lint/validate on PRs
- [ ] Expand Terraform examples (VPC, SGs, ASG) with cost‑safe defaults
- [ ] Add Ansible hardening roles and idempotency checks
- [ ] Add blue/green or canary deploy demo (Nginx/Ansible/TF combo)

---

## 🤝 Contributing

1. Fork the repo & create a feature branch: `feat/<short-name>`  
2. Keep the lab structure consistent (README, commands, troubleshooting, Q&A, screenshots).  
3. Open a PR with screenshots and a concise description.

---

## 📄 License

Unless otherwise noted, this repository is released under the **MIT License**.
