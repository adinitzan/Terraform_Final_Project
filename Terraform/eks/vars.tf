variable "vpc_id" {
  description = "VPC id for EKS"
  type        = string
  default     = "vpc-0b774a1400ccd754c"
}
variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "role_arn" {
  description = "IAM Role ARN for EKS"
  type        = string
}

variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type        = map(string)
}

variable "node_role_arn" {
  description = "IAM Role ARN for EKS Node Group"
  type        = string
}