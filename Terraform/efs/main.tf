
resource "aws_efs_file_system" "efs-at" {
  creation_token = "at-token"
  performance_mode = "generalPurpose"  # או "maxIO"
  encrypted = true

  tags = merge(var.common_tags, {
    Name = "EFS-AT"
  })
}

resource "aws_efs_mount_target" "at-mount-target" {
  file_system_id = aws_efs_file_system.efs-at.id
  subnet_id      = "subnet-06e81eeb7fbdd3c99"  # החלף ב-ID של הסאבנט שלך
  security_groups = ["sg-0c68c9b31332160f9"]   # החלף ב-ID של קבוצת האבטחה שלך
}
