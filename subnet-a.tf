resource "aws_subnet" "subnet_a" {
  for_each = var.subnets_a_config

  availability_zone       = each.value.availability_zone
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

resource "aws_route_table" "rtb_a" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw_a.id
  }

  tags = {
    "Name" = "rtb-a"
  }
}

resource "aws_route_table_association" "rtb_association_a" {
  for_each = var.subnets_a_config

  route_table_id = aws_route_table.rtb_a.id
  subnet_id      = aws_subnet.subnet_a[each.key].id
}