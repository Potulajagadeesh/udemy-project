terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# creating instance
resource "aws_instance" "demo-ec2" {
  ami             = "ami-06ca3ca175f37dd66" # Amazon Linux
  instance_type   = "t2.micro"
  key_name        = "virginia"
  security_groups = ["demo-sg"]

  tags = {
    Name = "HelloWorld"
  }

}

# security group creation
resource "aws_security_group" "allow-ssh" {
  name        = "demo-sg"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "allow-ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-demo-server"
  }
}

# vpc creation
resource "aws_vpc" "myvpc1" {
    cidr_block = "192.168.0.0/16"

    tags = {
        Name = "vpc1"
    }
  
}