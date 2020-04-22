variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_access_key" {
  type        = string
  description = "AWS region"
}
variable "aws_secret_key" {
  type        = string
  description = "AWS region"
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "custom_tags" {
  description = "AWS Custom tags"
  type        = map
}

variable "hosted_zone" {
  description = "AWS Hosted Zone"
  type        = string
}
