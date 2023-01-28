terraform {
  required_version = ">=0.13.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.51.0"
    }
    local = ">=2.1.0"
  }
}

provider "aws" {
  region = "sa-east-1"

  default_tags {
    tags = {
      owner      = "montesan"
      managed-by = "terraform"
    }
  }
}