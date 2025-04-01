terraform {
  required_version = ">= 1.2.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.1"
    }

    remote = {
      source  = "tenstad/remote"
      version = "0.1.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
  }
}
