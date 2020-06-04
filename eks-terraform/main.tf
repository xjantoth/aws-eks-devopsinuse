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

## EKS_CLUSTER_START
## ---------------------------------------------------------------------
##      Kubernetes AWS EKS cluster (Kubernetes control plane)
## ---------------------------------------------------------------------
#
## Uncomment to create AWS EKS cluster (Kubernetes control plane) - start
#resource "aws_eks_cluster" "this" {
#  name     = var.eks-cluster-name
#  role_arn = aws_iam_role.diu-eks-cluster.arn
#  version  = var.kubernetes-version
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
#
## Uncomment to create AWS EKS cluster (Kubernetes control plane) - start
## EKS_CLUSTER_END
###
###
## EKS_NODE_GROUP_START
### ---------------------------------------------------------------------
###      Kubernetes AWS EKS node group (Kubernetes nodes)
### ---------------------------------------------------------------------
#
## Uncomment to create SSH key pair in AWS - start
#resource "aws_key_pair" "this" {
#  key_name   = "aws-eks-ssh-key"
#  public_key = templatefile("${var.ssh_public_key}", {})
#}
## Uncomment to create SSH key pair in AWS - end
#
#
## Uncomment to create AWS EKS cluster - node group - start
#resource "aws_eks_node_group" "this" {
#  cluster_name    = aws_eks_cluster.this.name
#  node_group_name = "${var.eks-cluster-name}-node-group"
#  node_role_arn   = aws_iam_role.diu-eks-cluster-node-group.arn
#  subnet_ids      = [for subnet in [for value in aws_subnet.this : value] : subnet.id]
#
#  instance_types = ["t3.micro"]
#  tags           = var.custom_tags
#
#  scaling_config {
#    desired_size = var.desired_number_nodes
#    max_size     = var.max_number_nodes
#    min_size     = var.min_number_nodes
#  }
#
#  remote_access {
#    ec2_ssh_key               = aws_key_pair.this.key_name
#    source_security_group_ids = list(aws_security_group.eks_cluster_node_group.id)
#  }
#
#  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#  depends_on = [
#    # aws_eks_cluster.this,
#    # aws_key_pair.this,
#    # aws_security_group.eks_cluster_node_group,
#    aws_iam_role_policy_attachment.diu-eks-cluster-node-group-AmazonEKSWorkerNodePolicy,
#    aws_iam_role_policy_attachment.diu-eks-cluster-node-group-AmazonEKS_CNI_Policy,
#    aws_iam_role_policy_attachment.diu-eks-cluster-node-group-AmazonEC2ContainerRegistryReadOnly,
#  ]
#}
## Uncomment to create AWS EKS cluster (Kubernetes control plane) - end
#
#
## Uncomment to create Security Group rule for Kubernetes SSH port 22, NodePort 30111 - start
#
#resource "aws_security_group_rule" "this" {
#  for_each = toset(var.tcp_ports)
#
#  type              = "ingress"
#  from_port         = each.value
#  to_port           = each.value
#  protocol          = "tcp"
#  cidr_blocks       = list("0.0.0.0/0")
#  security_group_id = aws_eks_node_group.this.resources[0].remote_access_security_group_id
#
#  depends_on = [
#    aws_eks_node_group.this
#
#  ]
#}
### Uncomment to create Security Group rule for Kubernetes NodePort 30111 - start
## EKS_NODE_GROUP_END
