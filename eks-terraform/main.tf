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

#resource "aws_key_pair" "this" {
#  key_name   = "aws-eks-ssh-key"
#  public_key = templatefile("${var.ssh_public_key}", {})
#}
#
#resource "aws_eks_cluster" "this" {
#  name     = var.eks-cluster-name
#  role_arn = aws_iam_role.diu-eks-cluster.arn
#
#  vpc_config {
#    # subnet_ids = ["${aws_subnet.example1.id}", "${aws_subnet.example2.id}"]
#    # security_group_ids = list(aws_security_group.eks_cluster.id)
#    subnet_ids = [for subnet in [for value in aws_subnet.this : value] : subnet.id]
#  }
#
#  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
#  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
#  depends_on = [
#    aws_iam_role_policy_attachment.diu-eks-cluster-AmazonEKSClusterPolicy,
#    aws_iam_role_policy_attachment.diu-eks-cluster-AmazonEKSServicePolicy,
#  ]
#}
#
#resource "aws_eks_node_group" "this" {
#  cluster_name    = var.eks-cluster-name
#  node_group_name = "${var.eks-cluster-name}-node-group"
#  node_role_arn   = aws_iam_role.diu-eks-cluster-node-group.arn
#  subnet_ids      = [for subnet in [for value in aws_subnet.this : value] : subnet.id]
#
#  instance_types = ["t3.micro"]
#  tags           = var.custom_tags
#
#  scaling_config {
#    desired_size = 2
#    max_size     = 3
#    min_size     = 1
#  }
#
#  remote_access {
#    ec2_ssh_key = aws_key_pair.this.key_name
#    source_security_group_ids = list(aws_security_group.eks_cluster_node_group.id)
#  }
#
#  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#  depends_on = [
#    aws_eks_cluster.this,
#    aws_iam_role_policy_attachment.diu-eks-cluster-node-group-AmazonEKSWorkerNodePolicy,
#    aws_iam_role_policy_attachment.diu-eks-cluster-node-group-AmazonEKS_CNI_Policy,
#    aws_iam_role_policy_attachment.diu-eks-cluster-node-group-AmazonEC2ContainerRegistryReadOnly,
#  ]
#}

