resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name
  tags = {
    for a, b in var.custom_tags :
    a => (a == "Name" ? format("%s", var.s3_bucket_name) : b)
  }


  versioning {
    enabled = true
  }
}

