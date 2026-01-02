# Secure Networking & Private Access (Azure)

This repository implements a secure, private-by-default Azure networking foundation using Terraform.
It is designed as a platform layer that other workloads can consume without managing networking complexity.

## What this repo provides
- Virtual Network with clear subnet segmentation
- Private-only access to Azure PaaS services via Private Endpoints
- Private DNS for correct name resolution
- Centralized RBAC and Azure Policy guardrails
- Reusable Terraform modules with environment separation

## Architecture overview
The platform follows a private-by-default design:
- Workloads never access PaaS services over the public internet
- Standard Azure service FQDNs resolve to private IPs via Private DNS
- Network access, authorization, and guardrails are clearly separated

(Architecture diagram here)

## Repository structure
- `envs/` – Environment wiring (dev, stage, prod)
- `modules/` – Reusable platform modules (network, DNS, private endpoints)
- `docs/` – Architecture documentation and design decisions

## Security model
- **Network access**: Private Endpoints only
- **Name resolution**: Private DNS zones linked to the VNet
- **Authorization**: RBAC with least privilege
- **Guardrails**: Azure Policy at Resource Group scope

## Design decisions
Key architectural decisions are documented in `docs/decisions/` to make trade-offs explicit.

## Deployment
This repository is intended as a platform foundation.
Workloads are deployed in separate repositories and consume this network via VNet integration or peering.