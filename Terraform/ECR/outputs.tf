output "eks_node_role_arn" {
  value = aws_iam_role.AT_eks_ecr_access.arn
}