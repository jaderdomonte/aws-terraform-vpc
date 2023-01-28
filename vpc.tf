data "aws_availability_zones" "azs" {}

resource "aws_vpc" "new-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    "Name" = "vpc-${var.company}"
  }
}

resource "aws_internet_gateway" "new-igw" {
  vpc_id = aws_vpc.new-vpc.id
  tags = {
    "Name" = "igw-${var.company}"
  }
}

resource "aws_route_table" "rtb-external" {
  vpc_id = aws_vpc.new-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new-igw.id
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-a.id
  }

  tags = {
    "Name" = "rtb-external"
  }
  depends_on = [
    aws_internet_gateway.new-igw
  ]
}

resource "aws_subnet" "subnet-dmz-a" {
  availability_zone       = data.aws_availability_zones.azs.names[0]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.1.36.0/22"
  map_public_ip_on_launch = true
  tags = {
    Name = "DMZ-A"
  }
}

resource "aws_subnet" "subnet-dmz-b" {
  availability_zone       = data.aws_availability_zones.azs.names[1]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.1.40.0/22"
  map_public_ip_on_launch = true
  tags = {
    Name = "DMZ-B"
  }
}

resource "aws_subnet" "subnet-dmz-c" {
  availability_zone       = data.aws_availability_zones.azs.names[2]
  vpc_id                  = aws_vpc.new-vpc.id
  cidr_block              = "10.1.44.0/22"
  map_public_ip_on_launch = true
  tags = {
    Name = "DMZ-C"
  }
}

resource "aws_route_table_association" "rtb-association-dmz-a" {
  route_table_id = aws_route_table.rtb-external.id
  subnet_id      = aws_subnet.subnet-dmz-a.id
}

resource "aws_route_table_association" "rtb-association-dmz-b" {
  route_table_id = aws_route_table.rtb-external.id
  subnet_id      = aws_subnet.subnet-dmz-b.id
}

resource "aws_route_table_association" "rtb-association-dmz-c" {
  route_table_id = aws_route_table.rtb-external.id
  subnet_id      = aws_subnet.subnet-dmz-c.id
}

resource "aws_eip" "nat-gateway-1" {
  vpc = true
}

resource "aws_eip" "nat-gateway-2" {
  vpc = true
}

resource "aws_eip" "nat-gateway-3" {
  vpc = true
}

resource "aws_nat_gateway" "ngw-a" {
  allocation_id = aws_eip.nat-gateway-1.id
  subnet_id     = aws_subnet.subnet-dmz-a.id

  tags = {
    Name = "ngw-a"
  }

  depends_on = [aws_internet_gateway.new-igw]
}

resource "aws_nat_gateway" "ngw-b" {
  allocation_id = aws_eip.nat-gateway-2.id
  subnet_id     = aws_subnet.subnet-dmz-b.id

  tags = {
    Name = "ngw-b"
  }

  depends_on = [aws_internet_gateway.new-igw]
}

resource "aws_nat_gateway" "ngw-c" {
  allocation_id = aws_eip.nat-gateway-3.id
  subnet_id     = aws_subnet.subnet-dmz-c.id

  tags = {
    Name = "ngw-c"
  }

  depends_on = [aws_internet_gateway.new-igw]
}