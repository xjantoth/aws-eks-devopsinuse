output "hosted_zone" {
  description = "AWS hosted zone"
  value       = aws_route53_zone.this.id
}

