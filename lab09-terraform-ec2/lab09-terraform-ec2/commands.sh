#!/usr/bin/env bash
# Lab 09 - Commands Script (creates main.tf and runs terraform init/plan/apply/destroy)
set -e

echo "== Install Terraform prerequisites =="
sudo apt update
sudo apt install -y wget unzip

echo "== Install Terraform 1.3.6 =="
if ! command -v terraform >/dev/null 2>&1; then
  wget -q https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_linux_amd64.zip
  unzip -o terraform_1.3.6_linux_amd64.zip
  sudo mv -f terraform /usr/local/bin/
fi
terraform --version

echo "== Ensure AWS credentials are configured =="
echo "Run 'aws configure' beforehand if not already configured."

echo "== Create working dir and main.tf =="
mkdir -p terraform_vm
cd terraform_vm
cat > main.tf <<'EOF_TF'
# Configure the AWS provider
provider "aws" {
  region = "us-west-2"  # Set the region where you want the VM to be created
}

# Define an AWS EC2 instance resource
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (you can change it based on your region)
  instance_type = "t2.micro" # Free-tier instance type

  tags = {
    Name = "TerraformExampleVM"
  }

  # Specify the security group for the VM
  security_groups = ["default"]

  # Set the key pair for SSH access (you need to create a key pair in AWS beforehand)
  key_name = "my-key-pair"  # Replace with your actual key pair name
}
EOF_TF

echo "== Terraform init/plan/apply (apply is interactive; confirm 'yes') =="
terraform init
terraform plan
echo "About to run 'terraform apply' (you must type 'yes' when prompted)"
terraform apply

echo "== To clean up, run 'terraform destroy' (will prompt 'yes') =="
