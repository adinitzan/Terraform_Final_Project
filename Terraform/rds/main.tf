resource "aws_db_subnet_group" "eks_rds_subnet_group" {
  name       = "at-eks-rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.common_tags, {
    "Name" = "at-eks-rds-subnet-group"
  })
}

resource "aws_db_instance" "eks_rds" {
  identifier        = "at-statuspage-db"
  instance_class    = "db.t3.medium"
  engine            = var.db_engine
  engine_version    = var.db_engine_version
  allocated_storage = var.db_allocated_storage
  storage_type      = var.db_storage_type
  db_subnet_group_name = aws_db_subnet_group.eks_rds_subnet_group.name

  username          = var.db_username
  password          = var.db_password
  db_name           = var.db_name

  # Use the existing security group (eks_sg) for RDS
  vpc_security_group_ids = [var.eks_security_group_id]   

  multi_az           = var.multi_az
  publicly_accessible = false

  tags = merge(var.common_tags, {
    "Name" = "AT-EKS-RDS-postgresql"
  })

  final_snapshot_identifier = "eks-db-final-snapshot"
  skip_final_snapshot       = true

  #depends_on = [aws_security_group.eks_sg]
}

