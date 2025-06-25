# Terraform-Infra-Project

**📦 Terraform AWS Infrastructure Project**

This project provisions a fully functional AWS infrastructure using Terraform, including:

Custom VPC

EC2 Instances

Application Load Balancer (ALB)

S3 Bucket

Route53 DNS configuration




**📁 Project Structure**

Terraform/

├── ALB.tf                     # Application Load Balancer configuration

├── ec2.tf                     # EC2 instance definition

├── provider.tf                # AWS provider configuration

├── route53.tf                 # Route53 DNS setup

├── s3.tf                      # S3 bucket provisioning

├── variables.tf               # Input variables

├── vpc.tf                     # Custom VPC setup

├── terraform.tfstate*         # Terraform state files (ignored in .gitignore)


**🚀 Features**
Custom VPC with public/private subnets

EC2 instance provisioning

Internet Gateway and Route Tables

S3 bucket for storage

ALB with listener rules

Route53 DNS record setup

Modular and reusable codebase




**🛠 Prerequisites**

Terraform

AWS CLI configured (aws configure)

IAM user with appropriate permissions



**⚙️ Usage**

Clone this repository

git clone https://github.com/your-username/terraform-aws-infra.git

cd terraform-aws-infra/Terraform



**Initialize Terraform**

terraform init



**Plan the changes**

terraform plan



**Apply the configuration**

terraform apply

