variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnets" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  description = "Map of public subnets"
}

variable "private_subnets" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
  description = "Map of private subnets"
}

variable "env_prefix" {
  type        = string
  description = "Environment prefix for naming VPC and subnets"
}
