terraform {
  backend "s3" {
    bucket         = "willow-terraform-states-bucket"
    key            = "iac-project/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
