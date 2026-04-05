terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # tfstate.ps1 writes tfstate.backend.hcl (gitignored). CI runs: terraform init -backend-config=tfstate.backend.hcl
  # State file is stored as a blob in the new storage account (see key= in that file).
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = "eastus"
}
