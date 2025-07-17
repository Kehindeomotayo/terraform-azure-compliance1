# storage/variables.tf

variable "resource_group_name" {
  description = "The resource group name for storage resources"
  type        = string
}

variable "location" {
  description = "The Azure location for storage resources"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

# Add other variables as needed by your storage resources