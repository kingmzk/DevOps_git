
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

}

#Http server ->Security Group
# Security group -> 80 , 22 TCP , CIDR ["0.0.0.0/0"]

resource "aws_security_group" "http_server_sg" {
  name = "http_server_sg"
  # vpc_id = "vpc-063d7f60c3d1c515a"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    name = "http_server_sg"
  }
}





resource "aws_security_group" "elb_sg" {
  name = "elb_sg"
  # vpc_id = "vpc-063d7f60c3d1c515a"
  vpc_id = aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "elb" {
  name            = "elb"
  subnets         = data.aws_subnet_ids.default_subnets.ids
  security_groups = [aws_security_group.elb_sg.id]
  instances       = values(aws_instance.http_servers).*.id //format

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}





resource "aws_default_vpc" "default" {

}



resource "aws_instance" "http_servers" {
  # ami                    = "ami-0aa7d40eeae50c9a9"
  ami                    = data.aws_ami.aws_linux-2-latest.id
  key_name               = "second-key-pair"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.http_server_sg.id]
  #subnet_id              = "subnet-0a0110ed432498d99"

  #updated code #for_each = toset(data.aws_subnets.default_subnet.ids)  
  # for_each = data.aws_subnet_ids.default_subnets.ids
  for_each  = data.aws_subnet_ids.default_subnets.ids #remove .ids and add other to -target=data.aws_subnet_ids.default_subnets after that terraform apply
  subnet_id = each.value
  tags = {
    name : "http_servers_${each.value}"
  }


  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)

  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",                                                                                           //install httpd
      "sudo service httpd start",                                                                                            //start
      "echo Welcome to the club of millionoires - virtual server at ${self.public_dns} | sudo tee /var/www/html/index.html", //copy a file
    ]

  }

}
