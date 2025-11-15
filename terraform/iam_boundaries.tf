# This file defines the IAM permission boundaries for the organization.
# These policies are attached to IAM roles to restrict the maximum permissions that can be granted.

resource "aws_iam_policy" "boundary_policy" {
  name        = "EnterpriseBoundaryPolicy"
  description = "This policy defines the permission boundary for all IAM roles in the organization."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "DenySensitiveActions"
        Effect   = "Deny"
        Action = [
          "organizations:DeleteOrganization",
          "organizations:LeaveOrganization",
          "cloudtrail:DeleteTrail",
          "cloudtrail:StopLogging",
          "config:DeleteConfigurationRecorder",
          "config:StopConfigurationRecorder"
        ]
        Resource = "*"
      },
    ]
  })
}
