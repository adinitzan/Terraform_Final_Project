resource "aws_eks_cluster" "eks_AT" {
  name     = "eks-cluster-AT"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_AT.name
}

