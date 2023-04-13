variable "application_name" {
  default = "07-backend-state"
}


variable "project_name" {
  default = "users"
}

variable "environment" {
  default = "dev"
}



terraform {
  backend "s3" {
    bucket = "dev-applications-backend-state-mzk"
    key = "{var.application_name}-{var.project_name}-{var.environment}"            #app-proj-env
    # key = "dev/07-backend-state/users/backend-state"         //creates folder structure
    region = "us-east-1"
    dynamodb_table = "dev_application_locks"
    encrypt = true
    
  }
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
  name = "${terraform.workspace}_my_iam_user_mzk"
  
}



