variable "location" {
  type        = string
  description = "Azure region (e.g. eastus, westeurope)."
  default     = "eastus"
}

variable "project_name" {
  type        = string
  description = "Prefix for resource names (letters, numbers, hyphens)."
  default     = "statefile-learning"
}
