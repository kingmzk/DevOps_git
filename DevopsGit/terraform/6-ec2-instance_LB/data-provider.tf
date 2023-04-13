data "aws_subnet_ids" "default_subnets" {
  vpc_id = aws_default_vpc.default.id
}


data "aws_ami" "aws_linux-2-latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

# data "aws_ami" "aws_linux-2-latest" {
#   most_recent = true
#   owners = ["amazon"]
#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-2.0.20220128.0-gp2"]
#   }
# }

