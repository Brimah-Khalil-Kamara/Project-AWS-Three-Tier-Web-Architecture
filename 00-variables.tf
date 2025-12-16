

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

variable "ami_value" {
  description = "Value for the ami"
}




variable "env_prefix" {
  type        = string
  description = "Environment prefix to include in subnet and VPC names"
}

variable "my_public_ip" {
  description = "Your public IP address for access"
  type        = string
}



variable "public_subnets" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

variable "private_subnets" {
  type = map(object({
    cidr_block = string
    az         = string
  }))
}
