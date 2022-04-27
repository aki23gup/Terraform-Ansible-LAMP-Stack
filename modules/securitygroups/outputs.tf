output "dbsgid" {
  description = "Database Security Group ID"
  value = aws_security_group.dbsg.id
}

output "websgid" {
  description = "Web Server Security Group ID"
  value = aws_security_group.websg.id
}

output "lbsgid" {
  description = "Load Balancer Security Group ID"
  value = aws_security_group.lbsg.id
}

