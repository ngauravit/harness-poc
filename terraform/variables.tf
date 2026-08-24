variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g., poc, dev, prod)"
  type        = string
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name (must be lowercase, globally unique)"
  type        = string
}
