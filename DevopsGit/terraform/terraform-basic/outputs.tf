output "my_s3_bucket_versioning" {                      #output name
   value = aws_s3_bucket.my_s3_bucket.versioning[0]
   # value = aws_s3_bucket.my_s3_bucket.versioning[0].enabled
  
}

output "my_s3_bucket_full_details" {                      #output name

   value = aws_s3_bucket.my_s3_bucket
  
}

output "my_iam_user_full_details" {                      #output name

   value = aws_iam_user.my_iam_user
  
}