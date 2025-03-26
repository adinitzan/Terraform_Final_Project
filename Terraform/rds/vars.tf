variable "vpc_id" {
  description = "The VPC ID where the RDS instance will be launched."
  type        = string
}


variable "subnet_ids" {
  description = "List of subnet IDs where the RDS instance will reside."
  type        = list(string)
}

variable "db_username" {
  description = "The database username."
  type        = string
  default     = "status-page"
}

variable "db_password" {
  description = "The database password."
  type        = string
  sensitive   = true
  default     = "abcdefgh1234567"
}

variable "db_name" {
  description = "The name of the database."
  type        = string
  default     = "status-page"
}

variable "db_engine" {
  description = "The database engine (e.g., mysql, postgres, etc.)."
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "The database engine version."
  type        = string
  default     = "17"
}

variable "db_allocated_storage" {
  description = "Allocated storage for the RDS instance."
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "The storage type for the RDS instance."
  type        = string
  default     = "gp2"
}

variable "multi_az" {
  description = "Whether to enable Multi-AZ for the RDS instance."
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags for all resources."
  type        = map(string)
}

variable "eks_security_group_id" {
  description = "The security group ID of the EKS cluster"
  type        = string
}