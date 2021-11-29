
terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    helm = {
      source = "hashicorp/helm"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}
