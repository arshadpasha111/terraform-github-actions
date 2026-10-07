terraform {
  required_version = ">= 1.0.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "local" {}

# AWS Provider configured for LocalStack
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3 = "http://localhost:4566"
  }
}

# Your local file resource
resource "local_file" "example" {
  filename = "${path.module}/hello.txt"
  content  = "Hello from Terraform and GitHub Actions!"
}

# Your new S3 bucket resource
resource "aws_s3_bucket" "second_bucket" {
  bucket = "my-second-local-bucket"
}

# Output for the S3 bucket
output "second_bucket_arn" {
  value       = aws_s3_bucket.second_bucket.arn
  description = "The ARN of the second locally created S3 bucket"
}






















