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

variable "iam_user_name_variable" {
    type=string       #any , number , bool, list, map, set, object, tuple
    default =  "my_iam_user"
  
}

resource "aws_iam_user" "my_iam_user" {
  count = 2
  #name  = "my_iam_user_${count.index}" #supported by hasicorp
  name = "${var.iam_user_name_variable}_${count.index}"
}
