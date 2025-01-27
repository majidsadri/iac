# Infrastructure as Code (IaC) Project

This project provides a scalable and modular infrastructure deployment using **Terraform**. The goal is to maintain multiple environments (`development`, `staging`, `production`) while managing infrastructure state files, ensuring security, scalability, and monitoring features.

---

## Project Features

- **Multiple Environments**: Separate configurations for `development`, `staging`, and `production`.
- **State Management**: Centralized state files stored in an S3 bucket, ensuring consistency and collaboration.
- **Scalability**: Supports both horizontal and vertical scaling using AWS Auto Scaling Groups (ASG).
- **Monitoring**: Integration with AWS CloudWatch for performance metrics and monitoring.
- **Security**: Secure configurations using VPC, subnets, and security groups.

---

## Codebase Hierarchy

```plaintext
iac-project/
├── modules/
│   ├── compute/               # Manages EC2 instances, ASG, and Load Balancers
│   │   ├── main.tf            # Core compute module logic
│   │   ├── variables.tf       # Input variables for the compute module
│   │   └── outputs.tf         # Output values from the compute module
│   ├── network/               # Manages VPC, subnets, and routing
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security/              # Manages security groups and related rules
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── monitoring/            # Manages monitoring tools (e.g., CloudWatch dashboards)
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── environments/              # Separate environment configurations
│   ├── development/
│   │   ├── main.tf            # Environment-specific main Terraform configuration
│   │   ├── variables.tf       # Environment-specific variables
│   │   ├── backend.tf         # Backend configuration for state file management
│   │   └── terraform.tfvars   # Input variable values for development
│   ├── staging/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── backend.tf
│   │   └── terraform.tfvars
│   └── production/
│       ├── main.tf
│       ├── variables.tf
│       ├── backend.tf
│       └── terraform.tfvars
├── deploy.sh                  # Deployment script for managing environments
├── README.md                  # Documentation for the project
├── terraform.tfvars           # Global variable values (if any)
└── versions.tf                # Terraform version and provider requirements

---

## Using Terraform Workspaces

Terraform workspaces are used to manage multiple environments (e.g., development, staging, production) within a single codebase.

---

##  Key Benefits
Isolated state files per environment.
Simplified management of shared resources.
Enhanced collaboration for teams.

---

## Workspace Setup
The deployment script (deploy.sh) automates the workspace selection or creation.

### List existing workspaces:
terraform workspace list
### Create or select a workspace:
terraform workspace select development || terraform workspace new development
### Workspace-specific state files:
The state file for each workspace is stored in an S3 bucket under:

s3://willow-terraform-states-bucket/iac-project/<workspace>/terraform.tfstate
State File Management

Terraform state files are essential for tracking the current state of the infrastructure.

Backend Configuration
The backend is configured in the backend.tf file for each environment. It uses:

S3 Bucket: Stores the Terraform state files.
DynamoDB Table: Manages state locks to avoid simultaneous changes.
Example backend.tf:

terraform {
  backend "s3" {
    bucket         = "willow-terraform-states-bucket"
    key            = "iac-project/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
Deployment Process

Use the deploy.sh script to initialize, plan, and apply changes to the desired environment.

Steps to Deploy
Run the deployment script for the desired environment:
./deploy.sh <environment>
Replace <environment> with development, staging, or production.
The script will:
Initialize Terraform with the correct backend configuration.
Select or create the specified workspace.
Apply the Terraform configuration using the variables defined for the environment.
Monitor the output for any errors or confirmation prompts.
Development Tips

Adding Modules:
Create a new directory under modules/ for reusable components.
Define main.tf, variables.tf, and outputs.tf.
Environment-Specific Configurations:
Use the environments/ directory to override global variables for specific environments.
Scaling:
Modify the ASG configuration in the terraform.tfvars file to adjust asg_desired_capacity, asg_max_size, and asg_min_size.
Monitoring:
Add new CloudWatch metrics or dashboards in the monitoring/ module.
Requirements

Terraform version: >= 1.3.0
AWS CLI installed and configured
IAM user with the following permissions:
s3:* for the state bucket
dynamodb:* for the lock table
ec2:* for managing instances, launch templates, and security groups
elasticloadbalancing:* for managing load balancers and target groups
