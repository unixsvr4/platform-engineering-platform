# This file defines the SSO/OIDC integration for the organization.

variable "oidc_provider_url" {
  description = "The URL of the OIDC provider."
  type        = string
}

variable "oidc_client_id" {
  description = "The client ID of the OIDC application."
  type        = string
}

resource "aws_iam_openid_connect_provider" "main" {
  url             = var.oidc_provider_url
  client_id_list  = [var.oidc_client_id]
  thumbprint_list = ["a031c46782e6e6c662c2c87c76da9aa624f196ed"] # Replace with the thumbprint of your OIDC provider's root CA
}

resource "aws_iam_role" "oidc_role" {
  name = "oidc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.main.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${var.oidc_provider_url}:sub" = "users" # This condition may need to be adjusted based on your IdP's claims
          }
        }
      },
    ]
  })
}
