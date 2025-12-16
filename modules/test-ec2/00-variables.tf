# modules/ec2/variables.tf

variable "vpc_id" {
  type = string
  description = "VPC ID where EC2 will be launched"
}

variable "subnet_id" {
  type = string
  description = "Subnet ID for EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "ami_value" {
  type        = string
  description = "AMI ID for EC2 instance"
}

variable "my_public_ip" {
  type        = string
  description = "Your public IP for SSH access"
}

variable "env_prefix" {
  type        = string
  description = "Prefix for EC2 resource names"
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile name for EC2 instances"
}
