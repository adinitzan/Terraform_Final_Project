output "vpc_id" {
  value = aws_vpc.VPC_AT.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_AT.name
}
