provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-083654bd07b5da81d"
  instance_type = "t2.micro"
  key_name = "LAMP"
}

resource "aws_eip" "elastic_ip" {
  instance = aws_instance.ubuntu.id
}

resource "aws_security_group" "allow_tls" {
name = "allow_tls"
description = "Allow TLS inbound traffic"
vpc_id = aws_vpc.main.id



ingress {
description = "TLS from VPC"
from_port = 443
to_port = 443
protocol = "tcp"
cidr_blocks = [aws_vpc.main.cidr_block]
ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
}



egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
ipv6_cidr_blocks = ["::/0"]
}



tags = {
Name = "allow_tls"
}
}





output "EIP" {
  value = aws_eip.elastic_ip.public_ip
}




