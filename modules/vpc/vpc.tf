resource "aws_vpc" "lamp_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  assign_generated_ipv6_cidr_block = true
  tags = merge(
    {
      "Name" : "lamp-vpc-${terraform.workspace}"
  }, var.default_tags)
}

# get the current availability zones 
data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_default_route_table" "defaultroute" {
  default_route_table_id = aws_vpc.lamp_vpc.default_route_table_id

  tags = merge({
    Name = "defaultroute-${terraform.workspace}"
  }, var.default_tags)
}

/* data "aws_subnet_ids" "allsubnets" {
  vpc_id = aws_vpc.lamp_vpc.id
} */


resource "aws_default_network_acl" "defaultnacl" {
  default_network_acl_id = aws_vpc.lamp_vpc.default_network_acl_id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  lifecycle {
    ignore_changes = [subnet_ids]
  }

  tags = merge({
    Name = "defaultroute-${terraform.workspace}"
  }, var.default_tags)
}


resource "aws_default_security_group" "defaultsg" {
  vpc_id = aws_vpc.lamp_vpc.id

  tags = merge({
    Name = "defaultsg-${terraform.workspace}"
  }, var.default_tags)

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lamp_vpc.id
  tags = merge({
    Name = "ig-lamp-${terraform.workspace}"
  }, var.default_tags)
}

/* resource "aws_eip" "gweip" {
  count      = var.nat_count
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
  tags = merge({
    Name = "eip-${count.index}-${terraform.workspace}"
  }, var.default_tags)
}


resource "aws_nat_gateway" "ngw" {
  count         = var.nat_count
  subnet_id     = element(aws_subnet.lbsubnet.*.id, count.index)
  allocation_id = element(aws_eip.gweip.*.id, count.index)
  tags = merge({
    Name = "ngw=${count.index}-${terraform.workspace}"
  }, var.default_tags)
} */


resource "aws_route_table_association" "private_route_db_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.dbsubnets.*.id, count.index)
  route_table_id = aws_route_table.dbroute.id
}


resource "aws_route_table_association" "public_web_route_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.websubnets.*.id, count.index)
  route_table_id = aws_route_table.webroute.id
}

resource "aws_route" "internet_access_web" {
  route_table_id         = aws_route_table.webroute.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_subnet" "websubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.lamp_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.lamp_vpc.cidr_block, 2, count.index)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]

  tags = merge(
    {
      "Name" : "web-subnet-${count.index}-${terraform.workspace}"
  }, var.default_tags)

}

resource "aws_subnet" "dbsubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.lamp_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.lamp_vpc.cidr_block, 2, count.index + 2)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]

  tags = merge(
    {
      "Name" : "db-subnet-${count.index}-${terraform.workspace}"
  }, var.default_tags)

}

resource "aws_db_subnet_group" "databasegroup" {
  name       = "lampdb"
  subnet_ids = aws_subnet.dbsubnets.*.id

  tags = merge(
    {
      "Name" : "db-subnetgroup-${terraform.workspace}"
  }, var.default_tags)
}