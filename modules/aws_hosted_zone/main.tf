resource "aws_route53_zone" "this" {
  name = var.hosted_zone

  tags = {
    for a, b in var.custom_tags :
    a => (a == "Name" ? format("%s", var.hosted_zone) : b)
  }
}




