locals {
  s3_origin_id   = "${var.bucket_id}-origin"
  s3_domain_name = "${var.bucket_name}.s3-website-${var.region}.amazonaws.com"
}