provider "aws" {
    region = "us-east-1"
  
}

resource "aws_s3_bucket" "tf-s3" {
    bucket = "tf-remote-s3-bucket-mali-1" 
    force_destroy = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mybackend" {
    bucket = aws_s3_bucket.tf-s3.bucket
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  
}

resource "aws_bucket_versioning" "versioning_backend_s3" {
    bucket = aws_s3_bucket.tf-s3.id
    versioning_configuration {
        status = "Enabled"
    }
  
}

resource "aws_dynamodb_table" "tf-remote-state-lock" {
    hash_key = "LOCKID"
    name = "tf-s3-app-lock"
    attribute {
      name = "LOCKID"
      type = "S"
    }
    billing_mode = "Pay_per_request"
  
}