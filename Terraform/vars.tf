<<<<<<< HEAD
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

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "common_tags" {
  type = map(string)
  default = {
    "owner" = "toharbarazi"
    "Owner" = "adibeker"
  }
}g
=======
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

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "common_tags" {
  type = map(string)
  default = {
    "owner" = "toharbarazi"
    "Owner" = "adibeker"
  }
}g
>>>>>>> 9bf27428c31fceaf8d84424467a4a7a3f819af38
