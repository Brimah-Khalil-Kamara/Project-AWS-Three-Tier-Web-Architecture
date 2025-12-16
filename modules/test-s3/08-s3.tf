# -----------------------
# S3 Bucket
# -----------------------
resource "aws_s3_bucket" "architecture_bucket" {
  bucket = "3-tier-bucket-18102" # must be globally unique
}