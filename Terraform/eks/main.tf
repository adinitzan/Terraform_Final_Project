resource "aws_eks_cluster" "eks_AT" {
  name     = "eks-cluster-AT"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = merge(var.common_tags, {
    "Name" = "EKS-Cluster-AT"
  })
}

# Add the IAM role to EKS worker nodes so they can pull from ECR
resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_AT.name
  node_group_name = "eks-node-group-AT"
  node_role_arn   = aws_iam_role.AT_eks_ecr_access.arn

  subnet_ids      = var.subnet_ids
  instance_types  = ["t3.medium"]
  desired_size    = 2
  max_size        = 3
  min_size        = 1

  tags = merge(var.common_tags, {
    "Name" = "EKS-Node-Group-AT"
  })

  depends_on = [aws_iam_role.AT_eks_ecr_access]  # Ensure role is created before node group
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_AT.name
}
