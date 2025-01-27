environment = "development"
region      = "us-east-1"

vpc_id  = "vpc-0cea85cacd50bef7b"
subnets = [
  "subnet-02e0cec57d2bfd656", # Public Subnet 1
  "subnet-089da4942a3e5b824", # Public Subnet 2
  "subnet-0754acc0f96fd56e8", # Private Subnet 1
  "subnet-07b153f3e8a41d9ec"  # Private Subnet 2
]

ami_id = "ami-04b4f1a9cf54c11d0" # Valid Ubuntu AMI ID

lb_security_group = "sg-0828135a2bc32ac6a" # Replace with your Security Group ID
instance_type     = "t2.micro"

asg_desired_capacity = 2
asg_max_size         = 4
asg_min_size         = 1
