variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment tag (e.g., poc, dev, prod)"
  type        = string
  default     = "poc"
}

variable "bucket_prefix" {
  description = "Prefix for the S3 bucket name (must be lowercase, globally unique)"
  type        = string
  default     = "harness-tf-poc-"
}
