output "s3_bucket_name" {
  description = "AWS devopsinuse s3_bucket_name"
  value       = aws_s3_bucket.this.id
}

