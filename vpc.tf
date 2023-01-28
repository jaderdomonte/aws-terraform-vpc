resource "aws_vpc" "vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    "Name" = "vpc-${var.company}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "igw-${var.company}"
  }
}

resource "aws_route_table" "rtb_external" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "rtb_external"
  }
}

resource "aws_subnet" "subnet_dmz" {
  for_each = var.subnets_dmz_config

  availability_zone       = each.value.availability_zone
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = each.key
  }
}

resource "aws_route_table_association" "rtb_association_dmz" {
  for_each = var.subnets_dmz_config

  route_table_id = aws_route_table.rtb_external.id
  subnet_id      = aws_subnet.subnet_dmz[each.key].id
}

resource "aws_eip" "nat_gateway_1" {
  vpc = true
}

resource "aws_eip" "nat_gateway_2" {
  vpc = true
}

resource "aws_eip" "nat_gateway_3" {
  vpc = true
}

resource "aws_nat_gateway" "ngw_a" {
  allocation_id = aws_eip.nat_gateway_1.id
  subnet_id     = aws_subnet.subnet_dmz["DMZ-A"].id

  tags = {
    Name = "ngw-a"
  }
}

resource "aws_nat_gateway" "ngw_b" {
  allocation_id = aws_eip.nat_gateway_2.id
  subnet_id     = aws_subnet.subnet_dmz["DMZ-B"].id

  tags = {
    Name = "ngw-b"
  }
}

resource "aws_nat_gateway" "ngw_c" {
  allocation_id = aws_eip.nat_gateway_3.id
  subnet_id     = aws_subnet.subnet_dmz["DMZ-C"].id

  tags = {
    Name = "ngw-c"
  }
}