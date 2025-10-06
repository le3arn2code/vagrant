# Interview Q&A: Ansible Basics

**Q1: What is Ansible?**  
A configuration management and orchestration tool that uses YAML-based playbooks to automate infrastructure provisioning and application deployment.

**Q2: What are Ansible modules?**  
Reusable units of code that perform specific system operations (e.g., installing packages, copying files, managing users).

**Q3: How does Ansible connect to remote systems?**  
Using SSH for Linux hosts and WinRM for Windows hosts.

**Q4: What is an inventory file in Ansible?**  
A file that defines managed hosts and groups with connection details.

**Q5: What is an ad-hoc command?**  
A one-line Ansible command for quick task execution without writing a full playbook.

**Q6: How can we handle SSH password authentication in Ansible?**  
By installing `sshpass` and specifying `ansible_user` and `ansible_password` in the inventory.

**Q7: What does `ansible-playbook` do?**  
Executes tasks defined in a playbook YAML file.

**Q8: What are facts in Ansible?**  
Facts are system properties automatically gathered from target nodes.

**Q9: What is idempotence in Ansible?**  
The ability to apply the same playbook multiple times without changing the final state.

**Q10: How do you verify Ansible connectivity?**  
Using the ping module: `ansible all -m ping`.
