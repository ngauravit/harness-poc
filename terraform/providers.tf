terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Using local state for the initial POC.
  # Before moving to Harness, uncomment and run: terraform init -migrate-state
  # backend "s3" {
  #   bucket         = "REPLACE-my-tf-state-bucket"
  #   key            = "harness-poc/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "tf-state-locks"
  #   encrypt        = true
  # }
}

provider "aws" {
  region = var.aws_region
}
