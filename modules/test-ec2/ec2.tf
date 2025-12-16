//EC2 RESOURCE


resource "aws_instance" "architecture_instance" {
  ami           = var.ami_value  # Replace with a valid AMI ID
  instance_type = var.instance_type

  iam_instance_profile = var.iam_instance_profile  # use the variable

  tags = {
    Name: "${var.env_prefix}-ec2"               

  }
}
