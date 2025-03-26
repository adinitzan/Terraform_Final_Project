#output "eks_node_role_arn" {
#  value = aws_iam_role.AT_eks_ecr_access.arn
#}

output "eks_role_arn" {
  value = aws_iam_role.eks_role.arn
}

output "eks_security_group_id" {
  value = aws_security_group.eks_sg.id
  description = "The ID of the security group for EKS"
}