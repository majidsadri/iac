variable "environment" {
  description = "The environment (e.g., development, staging, production)"
  type        = string
}

variable "region" {
  description = "The AWS region"
  type        = string
}

variable "asg_name" {
  description = "The name of the Auto Scaling Group"
  type        = string
}
