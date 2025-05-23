resource "aws_security_group" "eks_sg" {
  vpc_id = var.vpc_id

  # Allow HTTPS traffic (port 443) for EKS nodes
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    security_groups = [
      "sg-0c68c9b31332160f9",  # קבוצת האבטחה שמורשית להתחבר
    ]
    self             = false
  }

  # Allow PostgreSQL traffic (port 5432) for RDS
  ingress {
    from_port   = 5432  # PostgreSQL port
    to_port     = 5432
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"] 
    cidr_blocks = ["10.0.1.0/24"]  # CIDR ספציפי של ה-VPC
    self        = false
  }


  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_iam_role" "eks_role" {
  name = "eks-cluster-role-AT"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
