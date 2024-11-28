# Main entry point for Terraform configuration
# Specifies the AWS provider

provider "aws" {
  region = var.region # Region is defined in variables.tf
}

# Terraform will automatically pick up all resources defined in network.tf, compute.tf, and load_balancer.tf
# Ensure all resources are correctly defined in the relevant .tf files in the same directory
