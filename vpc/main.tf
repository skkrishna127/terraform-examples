resource "aws_vpc" "main" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support =  true
    enable_dns_hostnames =  true

    tags = {
       Name = "saii"
       Terraform = "true"
       Environment = "Dev"
    }
}


resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
 
 tags = {
    Name = "saii"
    Terraform = "true"
    Environment = "Dev"
    }
 
}

 resource "aws_subnet" "public_subnet"{ 
    vpc_id   = aws_vpc.main.id
     cidr_block = "10.0.1.0/24"
    
     tags = {
      Name = "saii_my_subnet"
       Terraform = "true"
     Environment = "Dev"
  }
 } 

 resource "aws_route_table" "public_route_table"{
    vpc_id = aws_vpc.main.id
    route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.main.id
  }

  tags = {
      Name = "saii_public_route_table"
       Terraform = "true"
     Environment = "Dev"
  }
 }   
 resource "aws_route_table_association" "public"{ 
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
 }





 resource "aws_subnet" "private_subnet"{       
    vpc_id   = aws_vpc.main.id
     cidr_block = "10.0.11.0/24"
    
     tags = {
      Name = "saii_my_subnet private"
       Terraform = "true"
     Environment = "Dev"
  }

 }
   