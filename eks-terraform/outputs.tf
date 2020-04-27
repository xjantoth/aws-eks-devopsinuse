output "vpc_id" {
  description = "AWS vpc id"
  value       = data.aws_vpc.default.id
}

output "aws_subnet_ids" {
  description = "AWS subnet ids"
  value       = { for i, j in data.aws_subnet_ids.default : i => j }
}

output "aws_subnet_list_of_ids" {
  description = "AWS subnet ids"
  value       = [for subnet in [for value in aws_subnet.this : value] : subnet.id]
}

output "aws_availability_zones" {
  description = "AWS availability zones"
  value       = { for i, j in data.aws_availability_zones.default : i => j }
}

output "aws_iam_role_diu_eks_cluster" {
  description = "AWS IAM role for diu-eks-cluster eks cluster"
  value       = aws_iam_role.diu-eks-cluster.id
}

output "aws_iam_role_diu_eks_cluster_node_group" {
  description = "AWS IAM role for diu-eks-cluster-node-group eks cluster"
  value       = aws_iam_role.diu-eks-cluster-node-group.id
}


output "aws_eks_nodes_subnes" {
  description = "AWS subnets for diu-eks-cluster"
  value       = { for i, j in aws_subnet.this : i => j }
}

output "endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.this.certificate_authority.0.data
}

