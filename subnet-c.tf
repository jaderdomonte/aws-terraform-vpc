resource "aws_subnet" "subnet-app-c" {
  availability_zone       = data.aws_availability_zones.azs.names[2]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.1.8.0/22"
  map_public_ip_on_launch = true
  tags = {
    Name = "APP-C"
  }
}

resource "aws_subnet" "subnet-infra-c" {
  availability_zone       = data.aws_availability_zones.azs.names[2]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.1.20.0/22"
  map_public_ip_on_launch = true
  tags = {
    Name = "INFRA-C"
  }
}

resource "aws_subnet" "subnet-dba-c" {
  availability_zone       = data.aws_availability_zones.azs.names[2]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.1.32.0/22"
  map_public_ip_on_launch = true
  tags = {
    Name = "DBA-C"
  }
}

resource "aws_route_table" "rtb-c" {
  vpc_id = aws_vpc.new-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-c.id
  }


  tags = {
    "Name" = "rtb-c"
  }
}

resource "aws_route_table_association" "rtb-association-app-c" {
  route_table_id = aws_route_table.rtb-c.id
  subnet_id      = aws_subnet.subnet-app-c.id
}

resource "aws_route_table_association" "rtb-association-infra-c" {
  route_table_id = aws_route_table.rtb-c.id
  subnet_id      = aws_subnet.subnet-infra-c.id
}

resource "aws_route_table_association" "rtb-association-dba-c" {
  route_table_id = aws_route_table.rtb-c.id
  subnet_id      = aws_subnet.subnet-dba-c.id
}