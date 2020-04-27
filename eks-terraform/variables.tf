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

variable "custom_tags" {
  description = "AWS Custom tags"
  type        = map
}

variable "eks-cluster-name" {
  description = "AWS EKS cluster name"
  type        = string
}
