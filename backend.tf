terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Values come from tfstate.ps1 → tfstate.backend.hcl (storage_account_name matches $STORAGE_ACCOUNT_NAME there).
  # Run: terraform init -backend-config=tfstate.backend.hcl
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = "eastus"
}
