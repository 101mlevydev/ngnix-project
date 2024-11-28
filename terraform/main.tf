# Specify the AWS region
provider "aws" {
  region = "eu-north-1" 
}

# Upload SSH Public Key
resource "aws_key_pair" "nginx_key" {
  key_name   = "nginx-key"
  public_key = file("~/.ssh/id_rsa.pub") # (Path to public SSH key)
}

# Security Group allowing ssh, http, https
resource "aws_security_group" "nginx_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Allow SSH from any IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open SSH access
  }

  ingress {
    description = "Allowing HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allowing HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-sg"
  }
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "nginx-vpc"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "nginx-public-subnet"
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "nginx-private-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "nginx-igw"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "nginx-public-route-table"
  }
}

# Associate Public Subnet with Route Table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# EC2 Instance
resource "aws_instance" "nginx" {
  ami           = "ami-08eb150f611ca277f" # Ubuntu 20.04 LTS AMI for eu-north-1
  instance_type = "t3.micro"
  key_name      = aws_key_pair.nginx_key.key_name # Associate key pair
  subnet_id     = aws_subnet.private.id
  security_groups = [aws_security_group.nginx_sg.id]

  user_data = <<-EOT
    #!/bin/bash
    sudo apt update -y
    sudo apt install -y docker.io
    sudo systemctl start docker
    sudo docker run -d -p 80:80 nginx:latest

    # Harden SSH
    sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
  EOT

  tags = {
    Name = "nginx-instance"
  }
}
