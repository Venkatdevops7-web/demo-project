terraform {
  required_version = ">= 1.3"

  required_providers {
    kubectl = {
      source          = "gavinbunney/kubectl"
      version         = "1.9.1"    
  }
}
}
