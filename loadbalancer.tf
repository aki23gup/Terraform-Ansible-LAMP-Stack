// This file deploys the application load balancer

resource "aws_lb" "lampalb" {
  name               = "lamp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lbsg.id]
  subnets            = aws_subnet.websubnets.*.id
  enable_deletion_protection = false

  tags = { "Name" : "ApplicationLoadBalancer"}
}

// Pick and deploy target group for the loadbalancer
resource "aws_alb_target_group" "lamptg" {
  name        = "lamp-alb-target"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.lamp_vpc.id
  target_type = "instance"

  health_check { // health check parameters for the load balancer
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "200"
    path                = "/"
    port                = "80"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
  }
}

// Deploy an HTTP Listener
resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_lb.lampalb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.lamptg.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "ipattachment" {
  count            = var.az_count
  target_group_arn = aws_alb_target_group.lamptg.arn
  target_id        = aws_instance.lampsetup[count.index].id
  port             = 80
}

// Once Loadbalancer is deployed, an output is produced to provide URL of the loadbalancer
output "loadbalancerurl" {
  value = aws_lb.lampalb.dns_name
}