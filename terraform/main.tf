# Main entry point for Terraform configuration
# Specifies the AWS provider and orchestrates modules for network, load balancer, and compute resources

# Specify the AWS region
provider "aws" {
  region = var.region # Region is defined in variables.tf
}

# Module for network infrastructure (VPC, subnets, NAT Gateway)
module "network" {
  source = "./network"
}

# Module for load balancer and target group setup
module "load_balancer" {
  source = "./load_balancer"
}

# Module for compute resources (EC2 instances and related security groups)
module "compute" {
  source = "./compute"
}
