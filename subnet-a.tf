resource "aws_subnet" "subnet-app-a" {
    availability_zone = "sa-east-1a" 
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.1.0.0/22"
    map_public_ip_on_launch = true
    tags = {
        Name = "APP-A"
    }
}

resource "aws_subnet" "subnet-infra-a" {
    availability_zone = "sa-east-1a" 
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.1.12.0/22"
    map_public_ip_on_launch = true
    tags = {
        Name = "INFRA-A"
    }
}

resource "aws_subnet" "subnet-dba-a" {
    availability_zone = "sa-east-1a" 
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.1.24.0/22"
    map_public_ip_on_launch = true
    tags = {
        Name = "DBA-A"
    }
}

resource "aws_subnet" "subnet-dmz-a" {
    availability_zone = "sa-east-1a" 
    vpc_id = aws_vpc.new-vpc.id
    cidr_block = "10.1.36.0/22"
    map_public_ip_on_launch = true
    tags = {
        Name = "DMZ-A"
    }
}

resource "aws_route_table" "rtb-a" {
  vpc_id = aws_vpc.new-vpc.id
  tags = {
      "Name" = "rtb-a"
  }
}

resource "aws_route_table_association" "rtb-association-app-a" {
    route_table_id = aws_route_table.rtb-a.id
    subnet_id = aws_subnet.subnet-app-a.id 
}

resource "aws_route_table_association" "rtb-association-infra-a" {
    route_table_id = aws_route_table.rtb-a.id
    subnet_id = aws_subnet.subnet-infra-a.id 
}

resource "aws_route_table_association" "rtb-association-dba-a" {
    route_table_id = aws_route_table.rtb-a.id
    subnet_id = aws_subnet.subnet-dba-a.id 
}

resource "aws_route_table_association" "rtb-association-dmz-a" {
    route_table_id = aws_route_table.rtb-a.id
    subnet_id = aws_subnet.subnet-dmz-a.id 
}
