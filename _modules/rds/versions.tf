terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.65"
    }

    postgresql = {
      source = "cyrilgdn/postgresql"
      version = "1.21.1-beta.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.17.0"
    }   
        
  }
}
