# This file defines the AWS accounts that are part of the organization.

variable "account_email_audit" {
  description = "The email address for the audit account. Must be a unique email address."
  type        = string
}

variable "account_email_log_archive" {
  description = "The email address for the log archive account. Must be a unique email address."
  type        = string
}

resource "aws_organizations_account" "audit" {
  name      = "Audit"
  email     = var.account_email_audit
  parent_id = aws_organizations_organizational_unit.security.id
  role_name = "OrganizationAccountAccessRole"

  tags = {
    "ManagedBy" = "Terraform"
    "OU"        = "Security"
  }
}

resource "aws_organizations_account" "log_archive" {
  name      = "Log-Archive"
  email     = var.account_email_log_archive
  parent_id = aws_organizations_organizational_unit.security.id
  role_name = "OrganizationAccountAccessRole"

  tags = {
    "ManagedBy" = "Terraform"
    "OU"        = "Security"
  }
}
