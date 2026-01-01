# ADR 0001 — Naming conventions

## Decision
We standardize names using:
- project_name (short id, e.g. gb)
- environment (dev|stage|prod)

Computed:
- name_prefix = {project_name}-{environment}

Examples:
- Resource group: rg-{name_prefix}-core
- VNet: vnet-{name_prefix}-core
- Subnets:
  - snet-workloads
  - snet-private-endpoints

## Rationale
Consistent naming improves operations, reduces mistakes, and makes environments predictable.