# This file defines the AWS GuardDuty configuration for the organization.

resource "aws_guardduty_detector" "main" {
  enable = true

  tags = {
    "ManagedBy" = "Terraform"
  }
}

resource "aws_guardduty_organization_configuration" "main" {
  detector_id = aws_guardduty_detector.main.id
  auto_enable = true
}

# Note: To complete the GuardDuty setup, you will need to accept the GuardDuty
# invitation in each member account. This can be done by creating an
# `aws_guardduty_invite_accepter` resource in each member account.
# We will address this in a later step.
