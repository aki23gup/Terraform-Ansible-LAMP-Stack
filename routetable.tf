
// Route table for web traffic
resource "aws_route_table" "webroute" {
  vpc_id = aws_vpc.lamp_vpc.id
  tags = {Name = "OutWebRoute"}
}

// Route table for database traffic
resource "aws_route_table" "dbroute" {
  vpc_id = aws_vpc.lamp_vpc.id
  tags = {Name = "RouteDatabase"}
}


