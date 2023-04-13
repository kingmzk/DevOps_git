variable "environment" {
    default = "default"
  
}
#template
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
 
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  # VERSION IS NOT NEEDED HERE
}


#state DESIRED - KNOWN - ACTUAL 



resource "aws_iam_user" "my_iam_user" {
  # name = "my_iam_user_mzk_${var.environment}"
   name = "${local.iam_user_extension}_${var.environment}"
  
}

locals {             //using local so that it cannot be overriden
  iam_user_extension ="my_iam_user_abc"
}



