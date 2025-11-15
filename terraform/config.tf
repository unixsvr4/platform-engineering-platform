# This file defines the AWS Config configuration for the organization.

# Note: This configuration assumes that an S3 bucket for storing the logs
# has been created in the log-archive account. We will create that bucket
# in a separate step.
resource "aws_config_configuration_recorder" "main" {
  name     = "organization-recorder"
  role_arn = aws_iam_role.config_role.arn

  recording_group {
    all_supported                 = true
    include_global_resource_types = true
  }
}

resource "aws_config_delivery_channel" "main" {
  name           = "organization-channel"
  s3_bucket_name = "your-log-archive-bucket" # 👈 Replace with the name of the S3 bucket in the log-archive account
}

resource "aws_iam_role" "config_role" {
  name = "config-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "config.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "config_role_attachment" {
  role       = aws_iam_role.config_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_ConfigRole"
}

# AWS Config Conformance Pack for SOC 2
resource "aws_config_organization_conformance_pack" "soc2" {
  name = "soc2-conformance-pack"
  template_s3_uri = "s3://aws-config-conformance-packs-us-east-1/templates/AWS-Control-Tower-Detective-Guardrails-for-SOC-2.yaml"
  delivery_s3_bucket = "your-log-archive-bucket" # 👈 Replace with the name of the S3 bucket in the log-archive account
}

# AWS Config Conformance Pack for HIPAA
resource "aws_config_organization_conformance_pack" "hipaa" {
  name = "hipaa-conformance-pack"
  template_s3_uri = "s3://aws-config-conformance-packs-us-east-1/templates/HIPAA-Security.yaml"
  delivery_s3_bucket = "your-log-archive-bucket" # 👈 Replace with the name of the S3 bucket in the log-archive account
}
