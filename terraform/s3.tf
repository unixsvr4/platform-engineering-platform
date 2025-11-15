# This file defines the S3 configuration for the organization.

# This resource blocks public access to S3 buckets for the entire account.
# Note: This needs to be applied to each member account in the organization.
# We will address this in a later step.
resource "aws_s3_account_public_access_block" "main" {
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}
