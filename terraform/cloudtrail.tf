# This file defines the AWS CloudTrail configuration for the organization.

# Note: This configuration assumes that an S3 bucket for storing the logs
# has been created in the log-archive account. We will create that bucket
# in a separate step.
resource "aws_cloudtrail" "organization_trail" {
  name                          = "organization-trail"
  s3_bucket_name                = "your-log-archive-bucket" # 👈 Replace with the name of the S3 bucket in the log-archive account
  is_multi_region_trail         = true
  is_organization_trail         = true
  enable_logging                = true
  include_global_service_events = true

  tags = {
    "ManagedBy" = "Terraform"
  }
}
