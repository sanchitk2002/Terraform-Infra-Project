#Resource for Custom VPC
resource "aws_vpc" "VPC" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "TerraformVPC"
  }
}

#Resource for Internet Gateway
resource "aws_internet_gateway" "internet-gateway" {
    vpc_id = aws_vpc.VPC.id
    tags = {
      Name = "terraformigw"
    }
  
}

#Resource for Secuirity Groups
resource "aws_security_group" "terraform_security_group" {
    name = "terraformSG"
    vpc_id = aws_vpc.VPC.id

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
    }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
    }

    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      security_groups = [aws_security_group.alb_sg.id]
    }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
      Name = "terraformSG"
    }
}

#Security group for ALB

resource "aws_security_group" "alb_sg"{
    name = "alb-sg"
    vpc_id = aws_vpc.VPC.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  tags = {
    name = "ALB Security Group"
  }
}

#Resource for Subnet1
resource "aws_subnet" "public-subnet1" {
    vpc_id = aws_vpc.VPC.id
    cidr_block = "10.0.0.0/20"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true

    tags = {
      Name = "terraformPublicSub1"
    }  
}

#Resource for route table
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.internet-gateway.id
    }

    tags = {
      Name = "TerraformRT"
    }
}

#Resource for associating Route tables to subnet
resource "aws_route_table_association" "public-subnet-route-table-association" {
    subnet_id = aws_subnet.public-subnet1.id
    route_table_id = aws_route_table.public-route-table.id
}

#Resource for Subnet2
resource "aws_subnet" "public-subnet2" {
    vpc_id = aws_vpc.VPC.id
    cidr_block = "10.0.16.0/20"
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = true

    tags = {
      Name = "terraformPublicSub2"
    }  
}


#Resource for associating Route tables to subnet2
resource "aws_route_table_association" "public-subnet-route-table-association2" {
    subnet_id = aws_subnet.public-subnet2.id
    route_table_id = aws_route_table.public-route-table.id
}

#Resource for Subnet3
resource "aws_subnet" "public-subnet3" {
    vpc_id = aws_vpc.VPC.id
    cidr_block = "10.0.32.0/20"
    availability_zone = "ap-south-1c"
    map_public_ip_on_launch = true

    tags = {
      Name = "terraformPublicSub3"
    }  
}


#Resource for associating Route tables to subnet2
resource "aws_route_table_association" "public-subnet-route-table-association3" {
    subnet_id = aws_subnet.public-subnet3.id
    route_table_id = aws_route_table.public-route-table.id
}
