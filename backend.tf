terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Remote state only: tfstate.ps1 creates the RG, storage account, and container, then writes tfstate.backend.hcl.
  # Run: terraform init -backend-config=tfstate.backend.hcl
  # This root module does not create a resource group or storage account.
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
