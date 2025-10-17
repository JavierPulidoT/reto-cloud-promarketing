output "bucket_name" {
  description = "Name bucket"
  value       = aws_s3_bucket.front.bucket
}

output "bucket_id" {
  description = "Name bucket"
  value       = aws_s3_bucket.front.id
}