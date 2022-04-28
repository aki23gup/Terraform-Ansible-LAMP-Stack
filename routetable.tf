resource "aws_route_table" "webroute" {
  vpc_id = aws_vpc.lamp_vpc.id
  tags = {Name = "OutWebRoute"}
}


resource "aws_route_table" "dbroute" {
  vpc_id = aws_vpc.lamp_vpc.id
  tags = {Name = "RouteDatabase"}
}


