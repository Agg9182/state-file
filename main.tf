terraform {
  required_version = ">= 1.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  # Remote state in Azure Storage (Blob). tfstate.ps1 writes tfstate.backend.hcl; init with:
  #   terraform init -backend-config=tfstate.backend.hcl
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${var.project_name}-rg"
  location = var.location
}
