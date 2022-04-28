
// This file deploys a security group for the loadbalancer
resource "aws_security_group" "lbsg" {
  name        = "lbsg"
  description = "Security Group rules for acess to the Load Balancer"
  vpc_id      = aws_vpc.lamp_vpc.id
  tags = { "Name" : "LoadBalancerSecurityGroup" }
}


resource "aws_security_group_rule" "web_to_lb" { // WEB server to Loadbalancer traffic
  security_group_id = aws_security_group.lbsg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp" // Allow http
  cidr_blocks       = ["0.0.0.0/0"] // from anywhere on the web

}


resource "aws_security_group_rule" "lb_egress" { //egress traffic
  security_group_id = aws_security_group.lbsg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
