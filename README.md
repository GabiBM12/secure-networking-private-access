# Secure Networking & Private Access (Azure)

This repository implements a **secure, private-by-default Azure networking foundation** using Terraform.

It is designed as a **platform layer** that application teams can consume without managing networking, identity, or security guardrails themselves.

---

## What this repository provides

- Azure Virtual Network with clear subnet segmentation  
- **Private-only access** to Azure PaaS services using Private Endpoints  
- **Private DNS** for correct name resolution of Azure service FQDNs  
- Centralized **RBAC** for platform and workload access  
- **Azure Policy guardrails** enforcing private access and security standards  
- Reusable Terraform modules with environment separation (dev / stage / prod)

---

## Why this exists (real problem it solves)

This platform addresses common enterprise risks and operational pain points:

- Prevents accidental **public exposure of Storage Accounts and Key Vaults**
- Eliminates ad-hoc networking decisions by application teams
- Ensures Azure SDKs and TLS certificates continue to work by preserving **official Azure FQDNs**
- Centralizes security enforcement instead of relying on manual reviews
- Provides a repeatable, auditable baseline for multiple workloads

---

## Architecture overview

The platform follows a **private-by-default** design:

- Azure PaaS services are reachable **only via Private Endpoints**
- Public network access is disabled at the service level
- Standard Azure service FQDNs resolve to **private IPs** through Private DNS zones
- Identity, networking, and guardrails are clearly separated

### Traffic flow example
Workload
→ Azure Service FQDN
→ Private DNS Zone
→ Private Endpoint (Private IP)
→ PaaS Service


## Repository structure
envs/
dev/
stage/
prod/

modules/
network-core/
private-dns/
private-endpoint/
keyvault-private/
storage-private/
iam-rbac/
policy-guardrails/

docs/
architecture.md
decisions/

- `envs/` – Environment wiring and composition  
- `modules/` – Reusable, single-responsibility platform modules  
- `docs/` – Architecture documentation and design decisions  

---

## Security model

- **Network access**  
  Private Endpoints only (no public service exposure)

- **Name resolution**  
  Azure Private DNS zones linked to the VNet

- **Authorization**  
  Azure RBAC with least privilege  
  *(Bootstrap access granted to the current operator for validation)*

- **Guardrails**  
  Azure Policy assignments at Resource Group scope enforcing:
  - No public network access for Storage Accounts
  - No public network access for Key Vaults

---

## Deployment model

This repository represents a **platform foundation**.

- No application workloads are deployed here
- Workloads live in separate repositories
- Applications consume this platform via:
  - VNet integration
  - VNet peering
  - Private Endpoint connections

---

## Verification & validation

After deployment, the following conditions are verified:

- Private Endpoints are created for Storage and Key Vault
- Corresponding **A records exist in Private DNS zones**
- Public network access is disabled on PaaS services
- RBAC roles are correctly assigned
- Azure Policy assignments are active at Resource Group scope

---

## Design decisions

Key architectural decisions and trade-offs are documented in:
docs/decisions/
Examples include:
- Why Private DNS is required with Private Link
- Why RBAC bootstrap is applied to the current operator
- Why policies are scoped at the Resource Group level

---

## Out of scope / future improvements

- Hub-and-spoke networking
- Azure Firewall or NVA integration
- Private workloads (VMs / App Service / Container Apps)
- CI/CD policy enforcement

---

## Summary

This repository demonstrates a **production-style Azure platform foundation** focused on:
- Secure-by-default networking
- Clear separation of concerns
- Reusable Terraform modules
- Explicit architectural decisions

It is intended to be consumed by multiple workloads while maintaining strong security and governance guarantees.