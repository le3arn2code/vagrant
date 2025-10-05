# 💬 Interview Q&A – Vagrant & Shell Scripting Basics

| # | Question | Answer |
|:-:|:----------|:-------|
| 1 | What is Vagrant used for? | Automating the creation of reproducible development environments. |
| 2 | Why can’t we use VirtualBox inside EC2? | EC2 doesn’t support nested hardware virtualization. |
| 3 | How does Vagrant work with Docker? | It treats Docker containers as lightweight virtual machines. |
| 4 | Command to start and destroy a Vagrant container? | `vagrant up --provider=docker` and `vagrant destroy -f` |
| 5 | What file controls the Vagrant environment? | The `Vagrantfile`. |
| 6 | How do you enter a Docker container from the host? | `docker exec -it <container_name> bash` |
| 7 | Purpose of `chmod +x` | Makes a file executable. |
| 8 | What does `df -h` display? | Human-readable disk usage for each filesystem. |
| 9 | Why use Docker over VirtualBox here? | Docker is lightweight and works without nested virtualization. |
| 10 | How to verify Docker service is running? | `systemctl status docker` or `./prelab-check.sh`. |
