provider "aws" {                                       
    region = var.region        
}

# VPC / Network Module
module "vpc" {
  source = "./modules/test-vpc"

  vpc_cidr_block  = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  env_prefix      = var.env_prefix
}

module "ec2" {
  source = "./modules/test-ec2"

  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_ids[0] # launch in first public subnet
  instance_type = var.instance_type
  ami_value     = var.ami_value
  my_public_ip  = var.my_public_ip
  env_prefix    = var.env_prefix
  iam_instance_profile  = module.iam.ec2_instance_profile_name  # <-- pass output here
}
 
module "s3" {
  source = "./modules/test-s3"
}

module "iam" {
  source = "./modules/test-iam"
}