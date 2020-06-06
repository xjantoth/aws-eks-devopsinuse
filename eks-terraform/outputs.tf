output "vpc_id" {
  description = "AWS vpc id"
  value       = data.aws_vpc.default.id
}

output "aws_availability_zones" {
  description = "AWS availability zones"
  value       = { for i, j in data.aws_availability_zones.default : i => j }
}

# -----------------------------------------------------
# Uncomment "particular parts" of this file if executing
# this code partially - otherwise uncommnet all at once
# -----------------------------------------------------

# Uncomment  for "iam.tf" lecture - start
output "aws_iam_role_diu_eks_cluster" {
  description = "AWS IAM role for diu-eks-cluster eks cluster"
  value       = aws_iam_role.diu-eks-cluster.id
}

output "aws_iam_role_diu_eks_cluster_node_group" {
  description = "AWS IAM role for diu-eks-cluster-node-group eks cluster"
  value       = aws_iam_role.diu-eks-cluster-node-group.id
}
# Uncomment  for "iam.tf" lecture - end

#
# Uncomment  for "sg.tf" lecture - start
output "aws_sg_diu_eks_cluster_node_group" {
  description = "AWS Security Group for diu-eks-cluster-node-group eks cluster"
  value       = aws_security_group.eks_cluster_node_group.name
}
# Uncomment  for "sg.tf" lecture - end

#
# Uncomment  for "subnets.tf" lecture - start
output "aws_subnet_list_of_ids" {
  description = "AWS subnet ids"
  value       = [for subnet in [for value in aws_subnet.this : value] : subnet.id]
}
# Uncomment  for "subnets.tf" lecture - end


# Uncomment  for "main.tf" aws_eks_cluster resource lecture - start
output "endpoint" {
  description = "AWS EKS cluster (Kubernetes control plane) endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "kubeconfig-certificate-authority-data" {
  description = "AWS EKS cluster (Kubernetes control plane) kubeconfig"
  value       = aws_eks_cluster.this.certificate_authority.0.data
}
# Uncomment  for "main.tf" aws_eks_cluster resource lecture - end


# Uncomment  for "main.tf" aws_eks_node_group resource lecture - start
output "aws_key_pair" {
  description = "AWS ssh key pair to be used when SSH to Kubernetes nodes"
  value       = aws_key_pair.this.key_name
}

output "aws_eks_node_group" {
  description = "AWS EKS node group (Kubernetes nodes) kubeconfig"
  value       = aws_eks_node_group.this.id
}
# Uncomment  for "main.tf" aws_eks_cluster resource lecture - start

