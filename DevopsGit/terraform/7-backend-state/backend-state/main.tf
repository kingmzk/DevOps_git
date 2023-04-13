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


//S3-Bucket
resource "aws_s3_bucket" "enterprise_backend_state" {
  bucket = "dev-applications-backend-state-mzk"

  lifecycle {
    prevent_destroy = true
  }


  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}


//LOCKING  - Dynamo DB

resource "aws_dynamodb_table" "enterprise_backend_lock" {
  name         = "dev_application_locks"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S" //String

  }

}

