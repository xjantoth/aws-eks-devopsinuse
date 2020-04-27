provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

data "aws_vpc" "default" {
  default = "true"
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_availability_zones" "default" {
  state = "available"
}

module "aws_s3" {
  source         = "./modules/aws_s3"
  s3_bucket_name = var.s3_bucket_name
  custom_tags    = var.custom_tags
}

module "aws_hosted_zone" {
  source      = "./modules/aws_hosted_zone"
  custom_tags = var.custom_tags
  hosted_zone = var.hosted_zone
}


