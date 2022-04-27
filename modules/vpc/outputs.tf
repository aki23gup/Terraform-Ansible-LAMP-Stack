output "vpc_id" {
  description = "VPC ID"
  value = aws_vpc.lamp_vpc.id
}

output "websubnet" {
  description = "Web Server Subnet ID"
  value = aws_subnet.websubnets.id
}

output "websubid" {
  description = "Web Server Subnet ID (for multi az)"
  value = aws_subnet.websubnets[count.index % var.az_count].id
}

output "websubidlb" {
  description = "Web Server Subnet ID (for load balancer)"
  value = aws_subnet.websubnets.*.id
}

output "db_name" {
  description = "Database Subnet Name"
  value = aws_db_subnet_group.databasegroup.name
}

