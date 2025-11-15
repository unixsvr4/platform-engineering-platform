# This file configures the Terraform backend, which is where Terraform stores its state.
# We are using the S3 backend to store the state in an S3 bucket.
#
# ‼️ IMPORTANT ‼️
# You will need to create an S3 bucket and a DynamoDB table for locking in your AWS management account.
# Replace the placeholders below with your actual bucket name, key, region, and DynamoDB table name.

terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket" # 👈 Replace with your S3 bucket name
    key            = "platform-engineering-platform/terraform.tfstate"
    region         = "us-east-1"                   # 👈 Replace with your desired AWS region
    dynamodb_table = "your-terraform-lock-table" # 👈 Replace with your DynamoDB table name
    encrypt        = true
  }
}
