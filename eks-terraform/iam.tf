# IAM AWS role for EKS control plane
resource "aws_iam_role" "diu-eks-cluster" {
  name = "diu-EksClusterIAMRole-tf"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "diu-eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.diu-eks-cluster.name
}

resource "aws_iam_role_policy_attachment" "diu-eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.diu-eks-cluster.name
}

# IAM AWS role for Node Group

resource "aws_iam_role" "diu-eks-cluster-node-group" {
  name = "diu-EksClusterNodeGroup-tf"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "diu-eks-cluster-node-group-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.diu-eks-cluster-node-group.name
}

resource "aws_iam_role_policy_attachment" "diu-eks-cluster-node-group-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.diu-eks-cluster-node-group.name
}

resource "aws_iam_role_policy_attachment" "diu-eks-cluster-node-group-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.diu-eks-cluster-node-group.name
}


