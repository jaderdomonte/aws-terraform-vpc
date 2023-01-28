resource "aws_subnet" "subnet_c" {
  for_each = var.subnets_c_config

  availability_zone       = each.value.availability_zone
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

resource "aws_route_table" "rtb_c" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_c.id
  }


  tags = {
    "Name" = "rtb-c"
  }
}

resource "aws_route_table_association" "rtb_association_c" {
  for_each = var.subnets_c_config

  route_table_id = aws_route_table.rtb_c.id
  subnet_id      = aws_subnet.subnet_c[each.key].id
}