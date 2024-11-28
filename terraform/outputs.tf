# Outputs the results of the Terraform deployment for easier access to important information

# DNS name of the Application Load Balancer
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.nginx_alb.dns_name
}

# Private IP address of the EC2 instance
output "ec2_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.nginx.private_ip
}
