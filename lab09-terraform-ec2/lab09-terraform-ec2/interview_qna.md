# Interview Q&A (10 real-life)

1. **What is Terraform state and why is it important?**  
   The `terraform.tfstate` file tracks real resources so Terraform can plan changes accurately. Losing/corrupting it breaks drift detection.

2. **Difference between `plan` and `apply`?**  
   `plan` shows what will change; `apply` performs those changes.

3. **How do providers work?**  
   Plugins (like the AWS provider) implement APIs for clouds. `terraform init` downloads them per your configuration.

4. **How do you handle sensitive values (keys/passwords)?**  
   Use environment variables, AWS profiles, or a secrets manager. Avoid committing secrets to VCS.

5. **How do you manage multiple environments (dev/stage/prod)?**  
   Separate workspaces, directories, or variable files; keep state isolated per environment.

6. **What happens if someone changes resources in the console?**  
   Terraform detects drift during `plan`; you can import or re-apply to converge, depending on policy.

7. **How do you prevent accidental deletion?**  
   Use `lifecycle { prevent_destroy = true }` on critical resources and approvals in CI/CD.

8. **How do you share state safely?**  
   Use a remote backend (e.g., S3 + DynamoDB lock) instead of local state for teams.

9. **How to control versions of Terraform/provider?**  
   Use `required_version` and `required_providers` in your configuration; pin versions in code.

10. **What’s the difference between `security_groups` and `vpc_security_group_ids` on `aws_instance`?**  
    `security_groups` is for EC2-Classic or default VPC shorthand; for VPCs use `vpc_security_group_ids` with SG IDs.
