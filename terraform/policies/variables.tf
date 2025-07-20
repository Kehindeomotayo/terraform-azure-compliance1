variable "subscription_id" {
  description = "The subscription ID for policy assignments"
  type        = string
}

variable "development_rg" {
  description = "Development resource group object"
  type = object({
    id       = string
    name     = string
    location = string
  })
}

variable "storage_rg" {
  description = "Storage resource group object"
  type = object({
    id       = string
    name     = string
    location = string
  })
}

variable "enterprise_rg" {
  description = "Enterprise resource group object"
  type = object({
    id       = string
    name     = string
    location = string
  })
}
