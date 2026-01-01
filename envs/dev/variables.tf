variable "project_name" {
  description = "Short project identifier used in naming (e.g., gb)"
  type        = string
}

variable "environment" {
  description = "Environment name (dev|stage|prod)"
  type        = string
}

variable "location" {
  description = "Azure region (e.g., uksouth)"
  type        = string
}

variable "tags" {
  description = "Base tags applied to all resources"
  type        = map(string)
  default     = {}
}