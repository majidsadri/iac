#!/bin/bash

# Define the base directory
BASE_DIR="iac-project"

# Create the directory structure
mkdir -p $BASE_DIR/modules/network
mkdir -p $BASE_DIR/modules/compute
mkdir -p $BASE_DIR/modules/monitoring
mkdir -p $BASE_DIR/modules/security
mkdir -p $BASE_DIR/environments/development
mkdir -p $BASE_DIR/environments/staging
mkdir -p $BASE_DIR/environments/production

# Create the files in modules
touch $BASE_DIR/modules/network/{main.tf,variables.tf,outputs.tf}
touch $BASE_DIR/modules/compute/{main.tf,variables.tf,outputs.tf}
touch $BASE_DIR/modules/monitoring/{main.tf,variables.tf,outputs.tf}
touch $BASE_DIR/modules/security/{main.tf,variables.tf,outputs.tf}

# Create the files in environments
touch $BASE_DIR/environments/development/{main.tf,variables.tf,backend.tf}
touch $BASE_DIR/environments/staging/{main.tf,variables.tf,backend.tf}
touch $BASE_DIR/environments/production/{main.tf,variables.tf,backend.tf}

# Create root-level files
touch $BASE_DIR/{terraform.tfvars,versions.tf,README.md}

# Print success message
echo "Directory structure and files created successfully in $BASE_DIR"
