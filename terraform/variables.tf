variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "resource_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "gov-policy"
}

variable "required_tags" {
  description = "Required tags for all resources"
  type        = list(string)
  default = [
    "Environment",
    "Owner",
    "Department",
    "Project",
    "CostCenter",
    "Compliance"
  ]
}

variable "allowed_tag_values" {
  description = "Allowed values for specific tags"
  type        = map(list(string))
  default = {
    Environment = ["Development", "Testing", "Staging", "Production"]
    Compliance  = ["NIST", "FedRAMP", "FISMA", "SOC2"]
    Department  = ["IT", "Finance", "HR", "Operations", "Security"]
  }
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Environment = "Production"
    Owner       = "DevOps Team"
    Department  = "IT"
    Project     = "Governance-Demo"
    CostCenter  = "IT-001"
    Compliance  = "NIST"
  }
}