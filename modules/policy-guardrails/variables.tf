variable "RG_id" {
  description = " RG id where the policies will be assigned"
  type        = string
}

variable "assignments" {
  description = "Policy assignments keyed by assignment name"
  type = map(object({
    display_name         = string
    policy_definition_id = string
    parameters           = optional(any)
  }))
}