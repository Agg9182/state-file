variable "location" {
  type        = string
  description = "Azure region for the state storage resources."
  default     = "eastus"
}

variable "project_name" {
  type        = string
  description = "Short name used in resource group naming (lowercase, no spaces)."
  default     = "statefile-learning"
}
