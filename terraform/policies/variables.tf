# policies/variables.tf

variable "subscription_id" {
  description = "The subscription ID for policy assignments"
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "The resource group name for policy assignments"
  type        = string
  default     = null
}

# Add other variables as needed by your policy resources