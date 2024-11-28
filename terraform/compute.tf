# EC2 instance and security group setup
# Includes instance configuration and inbound/outbound traffic rules

# Security Group for EC2
resource "aws_security_group" "nginx_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow traffic from ALB to EC2 on port 8080"
    from_port   = 8080
    to_port     = 8080
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

# EC2 Instance to run the app
resource "aws_instance" "nginx" {
  ami           = "ami-08eb150f611ca277f" # Ubuntu 20.04 LTS AMI for eu-north-1
  instance_type = var.instance_type      # Instance type defined in variables.tf
  key_name      = "devops_project"      # Existing key pair in AWS
  subnet_id     = aws_subnet.private.id
  security_groups = [aws_security_group.nginx_sg.id]

  # Optional: User data script to bootstrap the instance
  user_data = file("${path.module}/installer.sh")

  tags = {
    Name = "nginx-instance"
  }
}
