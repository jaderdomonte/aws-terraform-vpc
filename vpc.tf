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