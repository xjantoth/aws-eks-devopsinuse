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

variable "kubernetes-version" {
  description = "AWS EKS cluster Kubernetes version"
  type        = string
}

variable "desired_number_nodes" {
  description = "Desired number of Kubernetes nodes in AWS Node Group"
  type        = number
}
variable "max_number_nodes" {
  description = "Max number of Kubernetes nodes in AWS Node Group"
  type        = number
}
variable "min_number_nodes" {
  description = "Min number of Kubernetes nodes in AWS Node Group"
  type        = number
}

variable "tcp_ports" {
  description = "TCP port to be allowed by AWS Security Group"
  type        = list
}

