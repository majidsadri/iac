#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Usage: ./deploy.sh <environment>"
  echo "Available environments: development, staging, production"
  exit 1
fi

WORKSPACE=$1

# Navigate to the specific environment directory
cd "environments/$WORKSPACE" || { echo "Environment $WORKSPACE does not exist!"; exit 1; }

# Initialize Terraform with the backend configuration
terraform init -reconfigure \
  -backend-config="bucket=willow-terraform-states-bucket" \
  -backend-config="key=iac-project/$WORKSPACE/terraform.tfstate" \
  -backend-config="region=us-east-1" \
  -backend-config="dynamodb_table=terraform-lock-table" \
  -backend-config="encrypt=true"

# Select or create the workspace
if terraform workspace list | grep -q "$WORKSPACE"; then
  terraform workspace select "$WORKSPACE"
else
  terraform workspace new "$WORKSPACE"
fi

# Plan and apply the Terraform configuration
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars" -auto-approve
