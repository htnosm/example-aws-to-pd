terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }

  required_version = ">= 1.1.7"

  required_providers {
    pagerduty = {
      source  = "pagerduty/pagerduty"
      version = ">= 2.3"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.5"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.1"
    }
  }
}

# Configure the PagerDuty Provider
provider "pagerduty" {
  token = var.pagerduty_token
}

# Configure the AWS Provider
provider "aws" {
  default_tags {
    tags = {
      CreatedBy = "Terraform"
    }
  }
}

/*
# Configure the AWS Provider
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "aws_region" {
  value = data.aws_region.current.name
}
*/
