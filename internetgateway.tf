// This file deploys an Internet Gateway for the infrastructure
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lamp_vpc.id
  tags = {Name = "igw"}
}
