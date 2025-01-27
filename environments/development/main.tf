provider "aws" {
  region = var.region # Ensure this variable is declared in variables.tf
}

# Dynamic values based on the workspace
locals {
  environment = terraform.workspace

  vpc_id = {
    development = "vpc-0cea85cacd50bef7b" # Replace with actual VPC ID
    staging     = "vpc-staging-id"         # Replace with actual VPC ID
    production  = "vpc-production-id"      # Replace with actual VPC ID
  }[terraform.workspace]

  subnets = {
    development = ["subnet-02e0cec57d2bfd65f", "subnet-089da4942a3e5b824"] # Public Subnets for dev
    staging     = ["subnet-stg-1", "subnet-stg-2"]                         # Replace with staging subnets
    production  = ["subnet-prod-1", "subnet-prod-2"]                       # Replace with prod subnets
  }[terraform.workspace]

  ami_id = {
    development = "ami-04b4f1a9cf54c11d0" # Replace with a valid AMI ID for development
    staging     = "ami-staging-id"        # Replace with staging AMI
    production  = "ami-production-id"     # Replace with production AMI
  }[terraform.workspace]
}

# Security Module
module "security" {
  source      = "../../modules/security"
  environment = local.environment
  vpc_id      = local.vpc_id
}

# Compute Module
module "compute" {
  source              = "../../modules/compute"
  environment         = local.environment
  ami_id              = local.ami_id
  instance_type       = "t2.micro" # Instance type
  asg_desired_capacity = var.asg_desired_capacity
  asg_max_size        = var.asg_max_size
  asg_min_size        = var.asg_min_size
  subnets             = local.subnets
  vpc_id              = local.vpc_id
  lb_security_group   = module.security.asg_security_group_id
}

# Monitoring Module
module "monitoring" {
  source      = "../../modules/monitoring"
  environment = local.environment
  region      = var.region
  asg_name    = module.compute.asg_name
}
