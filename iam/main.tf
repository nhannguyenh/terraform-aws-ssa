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