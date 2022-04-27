resource "aws_lb" "lampalb" {
  name               = "lamp-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lbsgid]
  subnets            = var.websubidlb

  enable_deletion_protection = false

  tags = merge(
    {
      "Name" : "alb-${terraform.workspace}"
  }, var.default_tags)
}


resource "aws_alb_target_group" "lamptg" {
  name        = "lamp-alb-target"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
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
  target_id        = var.lampserverid
  port             = 80
}

output "alburl" {
  value = aws_lb.lampalb.dns_name
}