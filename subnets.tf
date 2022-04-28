//Deploying Subnets in the VPC

resource "aws_subnet" "websubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.lamp_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.lamp_vpc.cidr_block, 2, count.index)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]
  tags                 = {"Name" : "WebSubnet"}

}

resource "aws_subnet" "dbsubnets" {
  count                = var.az_count
  vpc_id               = aws_vpc.lamp_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.lamp_vpc.cidr_block, 2, count.index + 2)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]
  tags = {"Name" : "DatabaseSubnet"}

}

resource "aws_db_subnet_group" "databasegroup" {
  name       = "lampdb"
  subnet_ids = aws_subnet.dbsubnets.*.id
  tags = {"Name" : "DatabaseSubnetGroup"} 
  }