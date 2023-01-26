resource "aws_subnet" "subnet-app-b" {
    availability_zone = "sa-east-1b" 
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.1.4.0/22"
    map_public_ip_on_launch = true
    tags = {
        Name = "APP-B"
    }
}

resource "aws_subnet" "subnet-infra-b" {
    availability_zone = "sa-east-1b" 
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.1.16.0/22"
    map_public_ip_on_launch = true
    tags = {
        Name = "INFRA-B"
    }
}

resource "aws_subnet" "subnet-dba-b" {
    availability_zone = "sa-east-1b" 
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.1.28.0/22"
    map_public_ip_on_launch = true
    tags = {
        Name = "DBA-B"
    }
}

resource "aws_subnet" "subnet-dmz-b" {
    availability_zone = "sa-east-1b" 
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.1.40.0/22"
    map_public_ip_on_launch = true
    tags = {
        Name = "DMZ-B"
    }
}

resource "aws_route_table" "rtb-b" {
  vpc_id = aws_vpc.new-vpc.id
  tags = {
      "Name" = "rtb-b"
  }
}

resource "aws_route_table_association" "rtb-association-app-b" {
    route_table_id = aws_route_table.rtb-b.id
    subnet_id = aws_subnet.subnet-app-b.id 
}

resource "aws_route_table_association" "rtb-association-infra-b" {
    route_table_id = aws_route_table.rtb-b.id
    subnet_id = aws_subnet.subnet-infra-b.id 
}

resource "aws_route_table_association" "rtb-association-dba-b" {
    route_table_id = aws_route_table.rtb-b.id
    subnet_id = aws_subnet.subnet-dba-b.id 
}

resource "aws_route_table_association" "rtb-association-dmz-b" {
    route_table_id = aws_route_table.rtb-b.id
    subnet_id = aws_subnet.subnet-dmz-b.id 
}
