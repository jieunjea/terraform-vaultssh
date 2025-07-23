terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    vault = {
        source  = "hashicorp/vault"
        version = "~> 5.0.0"
      }
  }

  required_version = "> 1.2.0"
}
