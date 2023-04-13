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

variable "users" {
  default = {
    # zak = "Germany",
    # mzk = "Australia" ,
    # ranga = "india",

    zak : { country : "Netherlands", Department : "abc" }, #map os string
    mzk : { country : "Australia", Department : "mzk" },
    ranga : { country : "india", Department : "izk" },
  }


}

resource "aws_iam_user" "my_iam_user" {
  for_each = var.users
  name     = each.key
  tags = {
    # country : each.value
    # country : each.value.country 
    Department : each.value.Department
  }
}
