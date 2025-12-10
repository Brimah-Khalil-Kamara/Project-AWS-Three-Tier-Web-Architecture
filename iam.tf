# IAM Role for EC2 (Trusted Entity = ec2.amazonaws.com)
resource "aws_iam_role" "ec2_role" {
  name = "ec2_ssm_s3_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach AWS Managed Policies
resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "s3_readonly" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# Instance Profile (required for EC2 instance)
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_ssm_s3_profile"
  role = aws_iam_role.ec2_role.name
}
