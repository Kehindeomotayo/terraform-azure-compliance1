# storage/variables.tf

variable "enterprise_rg" {
  description = "The resource group name for storage resources"
  type        = string
}

variable "location" {
  description = "The Azure location for storage resources"
  type        = string
}

variable "storage_rg" {
  description = "The name of the storage account"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

variable "resource_prefix" {
  description = "Prefix for resource names"
  type        = string
}
# Add other variables as needed by your storage resources