variable "subscription_id" {
  description = "The subscription ID for policy assignments"
  type        = string
}

variable "rg_development" {
  description = "Development resource group object"
  type = object({
    id       = string
    name     = string
    location = string
  })
}

variable "rg_storage" {
  description = "Storage resource group object"
  type = object({
    id       = string
    name     = string
    location = string
  })
}

variable "rg_enterprise" {
  description = "Enterprise resource group object"
  type = object({
    id       = string
    name     = string
    location = string
  })
}
