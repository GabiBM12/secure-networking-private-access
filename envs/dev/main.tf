locals {
  name_prefix = "${var.project_name}-${var.environment}"

  tags = merge(
    var.tags,
    {
      project     = var.project_name
      environment = var.environment
      managed_by  = "terraform"
      repo        = "repo-02"
    }
  )
}

module "rg" {
  source = "../../modules/resource-group"

  name     = "rg-${local.name_prefix}-core"
  location = var.location
  tags     = local.tags
}