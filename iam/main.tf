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