resource "aws_security_group" "dbsg" {
  name        = "dbsg-${terraform.workspace}"
  description = "controls access to the LB"
  vpc_id      = var.vpc_id
  tags = merge(
    {
      "Name" : "dbsg-${terraform.workspace}"
    }, var.default_tags
  )
}


resource "aws_security_group_rule" "web_to_db" {
  security_group_id        = aws_security_group.dbsg.id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.websg.id

}


resource "aws_security_group_rule" "db_egress" {
  security_group_id = aws_security_group.dbsg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}


