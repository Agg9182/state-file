locals {
  # Deterministic suffix so a re-run without remote state targets the same names (fails if resources already exist).
  name_suffix = substr(sha256("${var.project_name}-${data.azurerm_client_config.current.subscription_id}"), 0, 8)

  resource_group_name  = "rg-${var.project_name}-${local.name_suffix}"
  storage_account_name = substr("tf${local.name_suffix}", 0, 24)
  container_name       = "tfstate"
  state_blob_key       = "statefile-learning/terraform.tfstate"
}
