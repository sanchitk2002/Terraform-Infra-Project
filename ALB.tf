# Target Group
resource "aws_lb_target_group" "app1_tg" {
  name     = "app1-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.VPC.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# Attach EC2 to Target Group
resource "aws_lb_target_group_attachment" "ec2_attach_1" {
  target_group_arn = aws_lb_target_group.app1_tg.arn
  target_id        = aws_instance.terraformEC2.id
  port             = 80
}



# Load Balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public-subnet1.id, aws_subnet.public-subnet2.id]

  tags = {
    Name = "App Load Balancer"
  }
}

# Listener with path-based routing
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app1_tg.arn
  }
}

#Rule for app1
resource "aws_lb_listener_rule" "app1_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority = 10

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app1_tg.arn
  }

  condition {
    path_pattern {
      values = ["/app1"]
    }
  }
}


#Rule for app2
resource "aws_lb_listener_rule" "app2_rule" {
  listener_arn = aws_lb_listener.http_listener.arn
  priority = 20

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app1_tg.arn
  }

  condition {
    path_pattern {
      values = ["/app2"]
    }
  }
}