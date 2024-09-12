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
  shared_config_files      = ["/Users/nhannguyenh/Documents/myws/terraform/.aws/config"]
  shared_credentials_files = ["/Users/nhannguyenh/Documents/myws/terraform/.aws/credentials"]
  region                   = "ap-southeast-1"
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

# Add dev1 to the developers group
resource "aws_iam_group_membership" "developers_group_membership" {
  name  = "developers_group_membership"
  group = aws_iam_group.developers.name
  users = [aws_iam_user.dev1.name]
}