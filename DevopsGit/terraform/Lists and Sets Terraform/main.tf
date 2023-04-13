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

variable "names" {
  default =   ["king","zak","mzk" , "ranga" ,"udemy"]  #it compares and changes and adds udemy here 
  # default = ["mzk" , "ranga" ,"udemy"]
  
}

resource "aws_iam_user" "my_iam_user" {
  # count = length(var.names)
  # name = var.names[count.index]
 # name = "${var.iam_user_name_variable}_${count.index}"

 for_each =  toset(var.names)       //we cannot do for_each on list so convert it into sets
 name = each.value                 //in .tf state keys were number before now it is zak , ranga etc next if we add new things it will add one not entire thing it wilkl modify
}
