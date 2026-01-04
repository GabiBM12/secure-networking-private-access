# ADR 0002: Bootstrap RBAC to Deploying Identity

## Status
Accepted

## Context
During initial platform bring-up, access is required to validate:
- Private Endpoint connectivity
- Key Vault and Storage access
- Policy enforcement behavior

At this stage, no application workloads exist.

## Decision
RBAC roles are temporarily assigned to the identity executing Terraform.

This provides:
- Validation access
- Operational visibility
- Minimal initial complexity

## Consequences
- Access is intentionally limited and documented
- In production, this access should be replaced by:
  - Managed Identities for workloads
  - Entra ID groups for platform administrators

This approach mirrors real-world platform bootstrapping practices.