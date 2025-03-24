resource "aws_ecr_repository" "AT_ecr" {
  name = "at-status-page-repository"

  image_tag_mutability = "MUTABLE"

  tags = merge(var.common_tags, {
    "Name" = "at-status-page-repository"
  })
}

resource "aws_iam_role" "AT_eks_ecr_access" {
  name = "AT-eks-ecr-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          Service = [
            "eks.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        }
      }
    ]
  })
}
resource "aws_iam_policy" "AT_eks_ecr_policy" {
  name        = "AT-eks-ecr-policy"
  description = "Allow EKS nodes to pull images from ECR"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ],
        Resource = aws_ecr_repository.AT_ecr.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "AT_eks_ecr_policy_attachment" {
  policy_arn = aws_iam_policy.AT_eks_ecr_policy.arn
  role       = aws_iam_role.AT_eks_ecr_access.name

  depends_on = [aws_iam_policy.AT_eks_ecr_policy, aws_iam_role.AT_eks_ecr_access]
}
