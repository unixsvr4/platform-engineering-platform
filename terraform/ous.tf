# This file defines the Organizational Units (OUs) within the AWS Organization.

# The root of the organization, which is the parent of all other OUs.
data "aws_organizations_organization" "main" {}

# The Security OU is intended to host the security and audit accounts.
resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

# The Infrastructure OU is for shared infrastructure services like networking and CI/CD.
resource "aws_organizations_organizational_unit" "infrastructure" {
  name      = "Infrastructure"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

# The Workloads OU is for your applications and services.
resource "aws_organizations_organizational_unit" "workloads" {
  name      = "Workloads"
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

# Nested OUs for the different environments within the Workloads OU.
resource "aws_organizations_organizational_unit" "dev" {
  name      = "Dev"
  parent_id = aws_organizations_organizational_unit.workloads.id
}

resource "aws_organizations_organizational_unit" "staging" {
  name      = "Staging"
  parent_id = aws_organizations_organizational_unit.workloads.id
}

resource "aws_organizations_organizational_unit" "prod" {
  name      = "Prod"
  parent_id = aws_organizations_organizational_unit.workloads.id
}
