output "s3_bucket_name" {
  description = "AWS devopsinuse s3_bucket_name"
  value       = module.aws_s3.s3_bucket_name
}


output "hosted_zone" {
  description = "AWS devopsinuse s3_bucket_name"
  value       = module.aws_hosted_zone.hosted_zone
}

