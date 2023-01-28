resource "aws_subnet" "subnet-app-a" {
  availability_zone       = data.aws_availability_zones.azs.names[0]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.1.0.0/22"
  map_public_ip_on_launch = true
  tags = {
    Name = "APP-A"
  }
}

resource "aws_subnet" "subnet-infra-a" {
  availability_zone       = data.aws_availability_zones.azs.names[0]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.1.12.0/22"
  map_public_ip_on_launch = true
  tags = {
    Name = "INFRA-A"
  }
}

resource "aws_subnet" "subnet-dba-a" {
  availability_zone       = data.aws_availability_zones.azs.names[0]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.1.24.0/22"
  map_public_ip_on_launch = true
  tags = {
    Name = "DBA-A"
  }
}

resource "aws_route_table" "rtb-a" {
  vpc_id = aws_vpc.new-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-a.id
  }

  tags = {
    "Name" = "rtb-a"
  }
}

resource "aws_route_table_association" "rtb-association-app-a" {
  route_table_id = aws_route_table.rtb-a.id
  subnet_id      = aws_subnet.subnet-app-a.id
}

resource "aws_route_table_association" "rtb-association-infra-a" {
  route_table_id = aws_route_table.rtb-a.id
  subnet_id      = aws_subnet.subnet-infra-a.id
}

resource "aws_route_table_association" "rtb-association-dba-a" {
  route_table_id = aws_route_table.rtb-a.id
  subnet_id      = aws_subnet.subnet-dba-a.id
}