variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "vpc_id" {
  description = "VPC id for EKS"
  type        = string
  default     = "vpc-0b774a1400ccd754c"
}
variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
  default     = ["subnet-0f88e23a9b6225edc", "subnet-03a9c5a916a0059c7"]
}


variable "common_tags" {
  description = "Common tags to be applied to all resources"
  type = map(string)
  default = {
    "owner" = "toharbarazi"
    "Owner" = "adibeker"
  }
}
