#variable region {}
#variable instance_type {}
#variable env_prefix {}
#variable subnet_cidr_block {}

variable "region" {
  type        = string
  description = "The AWS region to deploy resources in"
}


variable "instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}


variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR block"
}


variable "availability_zones" {
  type        = list(string)
  description = "AZs to deploy subnets in (2 AZs)"
}

variable "env_prefix" {
  type        = string
  description = "Environment prefix to include in subnet and VPC names"
}