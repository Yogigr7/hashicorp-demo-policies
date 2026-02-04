terraform {
  required_version = "1.5.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.34.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "tagging" {
  source = "./modules/tagging"

  business_contact = "andrew.hill@rate.com"
  business_owner   = "andrew hill"
  tech_contact     = "cpe@rate.com"
  tech_owner       = "cpe-team"
  code_repo        = "https://github.com/Guaranteed-Rate/test-terraform-repo-v2"
  compliance       = "none"
  criticality      = "high"
  environment      = "nonprod"
  product          = "cloud networking and guardrails"
  public_facing    = "no"
  retirement_date  = "2036-12-31"
}

resource "random_integer" "test_bucket" {
  min = 1000
  max = 9999
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "tfc-poc-yogi-policies${random_integer.test_bucket.result}"

  tags = merge(module.tagging.value, {
    "PermissionsBoundary" = "JuniorCPE_PermissionsBoundary"
  })
}
