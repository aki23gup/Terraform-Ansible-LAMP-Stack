resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.lamp_vpc.id
  tags = {Name = "ig-lamp-${terraform.workspace}"}
}
