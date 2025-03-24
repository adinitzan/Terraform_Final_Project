resource "aws_eks_cluster" "eks_AT" {
  name     = "eks-cluster-AT"
  role_arn = var.role_arn

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
  #role_arn   = var.role_arn
  node_role_arn = var.node_role_arn

  subnet_ids      = var.subnet_ids
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  tags = merge(var.common_tags, {
    "Name" = "EKS-Node-Group-AT"
  })

  depends_on = [var.node_role_arn]  # Ensure role is created before node group
}



