//Deploy VPC 
resource "aws_vpc" "lamp_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = true
  tags = {"Name" : "LAMP_VPC" }
}


// Get the current availability zones 
data "aws_availability_zones" "available" {
  state = "available"
}

