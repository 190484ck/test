terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.67.0"
    }
  }
  backend "http" {}
}

provider "aws" {
  region     = ""
  access_key = ""
  secret_key = ""
}
