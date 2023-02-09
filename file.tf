provider "aws" {
  region = "us-east-1"
  access_key = "AKIAQWZLHV6Z55LMGAWJ"
  secret_key = "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"
}

resource "aws_vpc" "class_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "class-vpc"
  }
}

resource "aws_subnet" "class_subnet" {
  vpc_id            = aws_vpc.class_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "class-subnet"
  }
}

resource "aws_network_interface" "class" {
  subnet_id   = aws_subnet.class_subnet.id
  private_ips = ["10.0.0.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "class" {
  ami           = "ami-0aa7d40eeae50c9a9" 
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.class.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}