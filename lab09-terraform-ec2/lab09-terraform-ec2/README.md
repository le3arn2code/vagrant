# Lab 09: Automating Cloud Infrastructure with Terraform (AWS EC2)

## Objective
Use **Terraform** to provision, manage, and destroy a simple virtual machine (AWS EC2).

## Prerequisites
1. Ubuntu VM (Al Nafi-provided), running.
2. Install Terraform (if not already):
   ```bash
   sudo apt update
   sudo apt install -y wget unzip
   wget https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_linux_amd64.zip
   unzip terraform_1.3.6_linux_amd64.zip
   sudo mv terraform /usr/local/bin/
   terraform --version
   ```
3. AWS account + credentials configured:
   ```bash
   aws configure
   ```
   Enter **AWS Access Key ID**, **Secret Access Key**, default **region**, and output format.
4. IAM permissions to create/manage EC2 in your account.

---

## Step-by-Step (nano-friendly)

### 1) Create the Terraform configuration
```bash
mkdir terraform_vm
cd terraform_vm
nano main.tf
```
Paste exactly:
```hcl
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
```
Save (CTRL+O, ENTER) and exit (CTRL+X).

### 2) Initialize, plan, and apply
```bash
terraform init
terraform plan
terraform apply
# When prompted, type: yes
```
Terraform will provision the EC2 instance. Verify it in the AWS Console.

### 3) Destroy to clean up
```bash
terraform destroy
# When prompted, type: yes
```

---

## Layman's Explanation
Terraform is a robot that reads a plan (your `.tf` file) and builds exactly what you describe in the cloud. You tell it which region, which image, and what size VM. It creates it when you run **apply**, and removes it when you run **destroy**. This keeps cloud work repeatable and tidy.

---

## Errors We Might Hit & How We Fix Them
- **`terraform: command not found`**  
  Install Terraform and verify `terraform --version`.
- **`NoCredentialProviders` / credentials errors**  
  Run `aws configure` with correct keys and region.
- **`InvalidAMIID.NotFound`** (AMI not valid in your region)  
  Pick an AMI that exists in your chosen region or switch `provider.aws.region` to the region matching the AMI.
- **`InvalidKeyPair.NotFound`** for `key_name = "my-key-pair"`  
  Create a key pair in EC2 Console (same region) and set `key_name` accordingly.
- **`The security group 'default' does not exist`**  
  Ensure a default VPC exists in that region; if your account doesn’t have one, create a VPC and use a security group from it.
- **Permission / IAM errors**  
  Ensure your IAM user/role has EC2 permissions (Describe/Run/TerminateInstances, etc.).
- **Networking unreachable**  
  If you need SSH, ensure your security group allows inbound SSH (22) from your IP and the instance is in a public subnet with a public IP.

---

## Final Commands (clean run)
```bash
mkdir terraform_vm && cd terraform_vm
nano main.tf
terraform init
terraform plan
terraform apply   # confirm with: yes

# When finished
terraform destroy # confirm with: yes
```
