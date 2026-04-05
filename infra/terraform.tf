terraform {
  required_version = ">= 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Default: local state (terraform.tfstate in this directory).
  # Add backend "azurerm" { ... } or partial backend + terraform init -backend-config when using remote state in Azure Storage.
}
