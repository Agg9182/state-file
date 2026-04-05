terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Remote state in Azure Storage (Blob). After `terraform init -backend-config=tfstate.backend.hcl`,
  # the state file lives in the storage account created by tfstate.ps1 — not as a local terraform.tfstate.
  # tfstate.ps1 writes tfstate.backend.hcl (gitignored) with container + blob key + use_azuread_auth.
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}
