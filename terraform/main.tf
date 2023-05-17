#create vpc
resource "aws_vpc" "intuitive_vpc" {
  cidr_block = "10.10.0.0/16"
}

#create subnet

resource "aws_subnet" "intuitive_subnet" {
  vpc_id     = aws_vpc.intuitive_vpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "intuitive_subnet"
  }
}

#create igw

resource "aws_internet_gateway" "intuitive_igw" {
  vpc_id = aws_vpc.intuitive_vpc.id

  tags = {
    Name = "intuitive_igw"
  }
}

#route table

resource "aws_route_table" "intuitive_rt" {
  vpc_id = aws_vpc.intuitive_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.intuitive_igw.id
  }

  tags = {
    Name = "intuitive_rt"
  }
}

#subnet association
resource "aws_route_table_association" "intuitive_subnet_rt" {
  subnet_id      = aws_subnet.intuitive_subnet.id
  route_table_id = aws_route_table.intuitive_rt.id
}

#create security group

resource "aws_security_group" "intuitive_sg" {
  name   = "intuitive_sg"
  vpc_id = aws_vpc.intuitive_vpc.id

  ingress {

    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {

    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "intuitive_server" {
    ami = "ami-XXXX"
    key_name = "test123"
    instance_type = "t2.micro"    
    subnet_id = aws_subnet.intuitive_subnet.id
    vpc_security_group_ids = [aws_security_group.intuitive_sg.id]
}

resource "aws_instance" "intuitive_web" {
    ami = "ami-yyyy"
    key_name = "test123"
    instance_type = "t2.micro"    
    subnet_id = aws_subnet.intuitive_subnet.id
    vpc_security_group_ids = [aws_security_group.intuitive_sg.id]
}

resource "aws_ebs_volume" "ebs_server" {
  availability_zone = aws_instance.intuitive_server.availability_zone
  size              = 2

  tags = {
    Name = "ebs_server"
  }
}

resource "aws_ebs_volume" "ebs_web" {
  availability_zone = aws_instance.intuitive_web.availability_zone
  size              = 2

  tags = {
    Name = "ebs_web"
  }
}

resource "aws_s3_bucket" "intuitive_bucket" {
  bucket = "intuitive-bucket"

  tags = {
    Name        = "intuitive_bucket"    
  }
}
