# Troubleshooting

## Terraform not installed / wrong path
Reinstall and check version:
```bash
sudo apt update && sudo apt install -y wget unzip
wget https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_linux_amd64.zip
unzip terraform_1.3.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version
```

## Credentials / region issues
- Run `aws configure` and ensure the region matches your chosen AMI.
- For `InvalidAMIID.NotFound`, pick an AMI valid in that region or change the provider region.

## Key pair not found
Create a key pair in the **same region** and update `key_name` in `main.tf`.

## Default security group missing
Some accounts/regions don’t have a default VPC/SG. Create a VPC and a security group and reference it instead of `"default"`.

## Permissions
Use an IAM user/role with EC2 permissions to create/terminate instances.

## Cleanup reminders
Always destroy when done:
```bash
terraform destroy
# type: yes
```
