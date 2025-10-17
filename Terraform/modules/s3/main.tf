###########
# Defaults
##########
terraform {
  required_version = ">= 0.15.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.68"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "~> 0.13.0"
    }
  }
}
provider "aws" {
  region = var.region
}

################
## S3 bucket
################

resource "aws_s3_bucket" "front" {
  bucket = var.s3_name
}

resource "aws_s3_bucket_ownership_controls" "s3_front" {
  bucket = aws_s3_bucket.front.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "front" {
  bucket = aws_s3_bucket.front.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_acl" "front" {
  bucket = aws_s3_bucket.front.id
  acl    = "public-read"
  depends_on = [
    aws_s3_bucket_ownership_controls.s3_front,
    aws_s3_bucket_public_access_block.front
    ]
}


resource "aws_s3_bucket_website_configuration" "front_conf" {
  bucket = aws_s3_bucket.front.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }

}

resource "aws_s3_bucket_policy" "front" {
  bucket = aws_s3_bucket.front.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
     {
        Sid       = "${var.s3_name}"
        Effect    = "Allow"
       Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.front.arn}/*"
      }
    ]
  })

  depends_on = [
    aws_s3_bucket_ownership_controls.s3_front,
    aws_s3_bucket_public_access_block.front
  ]
}