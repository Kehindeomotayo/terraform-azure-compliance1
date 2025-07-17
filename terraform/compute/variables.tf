# compute/variables.tf

variable "resource_group_name" {
  description = "The resource group name for compute resources"
  type        = string
}

variable "location" {
  description = "The Azure location for compute resources"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
  default     = "Standard_B1s"
}

# Add other variables as needed by your compute resources