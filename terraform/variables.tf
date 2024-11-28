# Defines variables for AWS region, key pair, and EC2 instance configuration
# This allows customization of the Terraform deployment without changing the code directly

# AWS region to deploy the resources
variable "region" {
  description = "AWS region to deploy the resources"
  default     = "eu-north-1"
}

# SSH key pair name
variable "key_name" {
  description = "SSH key pair name for EC2 instances"
  default     = "nginx-key"
}

# EC2 instance type
variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t3.micro"
}
