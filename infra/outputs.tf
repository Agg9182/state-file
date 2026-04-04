output "resource_group_name" {
  description = "Set GitHub secret TFSTATE_RESOURCE_GROUP to this value after bootstrap."
  value       = azurerm_resource_group.tfstate.name
}

output "storage_account_name" {
  description = "Set GitHub secret TFSTATE_STORAGE_ACCOUNT to this value after bootstrap."
  value       = azurerm_storage_account.tfstate.name
}

output "container_name" {
  description = "Set GitHub secret TFSTATE_CONTAINER to this value after bootstrap."
  value       = azurerm_storage_container.tfstate.name
}

output "state_blob_key" {
  description = "Backend key= and optional secret TFSTATE_KEY (must match terraform init -backend-config)."
  value       = local.state_blob_key
}
