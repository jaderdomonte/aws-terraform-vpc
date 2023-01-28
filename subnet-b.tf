resource "aws_subnet" "subnet_b" {
  for_each = var.subnets_b_config

  availability_zone       = each.value.availability_zone
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

resource "aws_route_table" "rtb_b" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_b.id
  }

  tags = {
    "Name" = "rtb-b"
  }
}

resource "aws_route_table_association" "rtb_association_b" {
  for_each = var.subnets_b_config

  route_table_id = aws_route_table.rtb_b.id
  subnet_id      = aws_subnet.subnet_b[each.key].id
}