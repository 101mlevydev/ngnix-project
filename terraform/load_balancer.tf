# Load Balancer setup for routing traffic to the EC2 instance
# Includes ALB, target group, and listener configuration

# Application Load Balancer
resource "aws_lb" "nginx_alb" {
  name               = "nginx-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx_sg.id]
  subnets            = [aws_subnet.public.id]

  tags = {
    Name = "nginx-app-alb"
  }
}

# Target group for ALB to route traffic to the EC2 instance
resource "aws_lb_target_group" "nginx_tg" {
  name     = "nginx-target-group"
  port     = 8080  # Forwards traffic to port 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/"  # Health check path
    port                = "8080"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "nginx-target-group"
  }
}

# Attach EC2 instance to the target group
resource "aws_lb_target_group_attachment" "nginx_attachment" {
  target_group_arn = aws_lb_target_group.nginx_tg.arn
  target_id        = aws_instance.nginx.id
  port             = 8080
}

# Listener to forward traffic from ALB to the target group
resource "aws_lb_listener" "nginx_listener" {
  load_balancer_arn = aws_lb.nginx_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}
