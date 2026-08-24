# Sample resource for the POC — replace with your actual resources.
resource "aws_s3_bucket" "poc" {
  bucket_prefix = var.bucket_prefix

  tags = {
    Environment = var.environment
    ManagedBy   = "harness-terraform"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.poc.bucket
}
