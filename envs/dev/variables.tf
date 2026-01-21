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
variable "rbac_principal_object_ids" {
  description = "Principals to grant bootstrap access (e.g., your user + GitHub OIDC SP)."
  type        = list(string)
  default     = []
}