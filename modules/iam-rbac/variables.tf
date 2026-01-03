variable "assignments" {
  description = "RBAC role assignments keyed by a stable name"
  type = map(object({
    scope                = string
    role_definition_name = string
    principal_id         = string
  }))
  default = {}
}