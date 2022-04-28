# This file deploys a security group for our database

resource "aws_security_group" "dbsg" {
  name        = "dbsg"
  description = "Security group for access to the Database"
  vpc_id      = aws_vpc.lamp_vpc.id // Pulls VPC ID
  tags =  { "Name" : "DatabaseSecurityGroup"}
}

// Security Group  for TCP Port 3306
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





