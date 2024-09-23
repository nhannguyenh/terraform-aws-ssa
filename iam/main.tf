terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  # shared_config_files      = ["/Users/nhannguyenh/Documents/myws/terraform/.aws/config"]
  # shared_credentials_files = ["/Users/nhannguyenh/Documents/myws/terraform/.aws/credentials"]
  # === Personal ===
  shared_config_files      = ["/Users/nhannguyen/Documents/Workspace/terraform/.aws/config"]
  shared_credentials_files = ["/Users/nhannguyen/Documents/Workspace/terraform/.aws/credentials"]
  # === Personal ===
  region = "ap-southeast-1"
}

# Create a new developers group
resource "aws_iam_group" "developers" {
  name = "developers-group"
}

# Attach IAMReadOnlyAccess policy to the developers group
resource "aws_iam_group_policy_attachment" "iam_read_only_access" {
  group      = aws_iam_group.developers.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

# Create the news developer user
resource "aws_iam_user" "dev1" {
  name = "dev1"
}

resource "aws_iam_user" "dev2" {
  name = "dev2"
}

# Add dev1 to the developers group
resource "aws_iam_group_membership" "developers_group_membership" {
  name  = "developers_group_membership"
  group = aws_iam_group.developers.name
  users = [
    aws_iam_user.dev1.name,
    aws_iam_user.dev2.name
  ]
}

# Create the new custom policy
resource "aws_iam_policy" "iam_get_users_only_policy" {
  name        = "IAMGetUserOnly"
  path        = "/"
  description = "Only get users from IAM service"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "iam:GetUser",
        "Resource" : "*"
      }
    ]
  })
}

# Create a variable to store the list of policy arn
variable "policy_arns" {
  type = list(string)
  default = [
    "arn:aws:iam::aws:policy/IAMReadOnlyAccess",
    "arn:aws:iam::211125338837:policy/IAMGetUserOnly"
  ]
}

# a new testers group
resource "aws_iam_group" "testers" {
  name = "testers-group"
}

# Attach a list policy to the testers group
resource "aws_iam_group_policy_attachment" "multiple_policies_attachment" {
  count = length(var.policy_arns)
  group      = aws_iam_group.testers.name
  policy_arn = var.policy_arns[count.index]
}