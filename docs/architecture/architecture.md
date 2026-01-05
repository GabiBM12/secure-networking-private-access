# Architecture Overview

This document describes the architecture implemented by this repository and how its components interact to provide secure, private access to Azure PaaS services.

---

## High-level architecture

The platform establishes a **private-by-default networking baseline** for Azure workloads.

Key principles:
- No public access to PaaS services
- Official Azure service FQDNs are preserved
- Network, identity, and governance are treated as separate concerns

---

## Core components

### Virtual Network

- Single Virtual Network per environment
- Subnet separation by responsibility:
  - **Workload subnet** – for VMs, App Services, Container Apps, etc.
  - **Private Endpoint subnet** – dedicated subnet for Private Endpoints

This separation avoids address conflicts and allows future policy or routing controls.

---

### Private Endpoints

Private Endpoints are used to expose Azure PaaS services privately inside the VNet.

Current services:
- Azure Storage (Blob)
- Azure Key Vault

Characteristics:
- Each Private Endpoint receives a private IP from the VNet
- Public network access is disabled on the service
- Traffic never leaves the Microsoft backbone network

---

### Private DNS

Azure Private DNS zones are used to ensure correct name resolution.

Examples:
- `privatelink.blob.core.windows.net`
- `privatelink.vaultcore.azure.net`

The zones are:
- Linked to the Virtual Network
- Associated with Private Endpoints via DNS zone groups

This allows workloads to resolve **standard Azure FQDNs** to private IPs while maintaining TLS and SDK compatibility.

---

### Identity and access (RBAC)

Authorization is handled using Azure RBAC:

- Key Vault uses RBAC (not access policies)
- Storage access is controlled via data-plane RBAC roles
- Initial access is bootstrapped to the deploying identity for validation

Workloads are expected to use **Managed Identities** in downstream repositories.

---

### Governance and guardrails

Azure Policy is used to enforce preventive guardrails at Resource Group scope.

Current policies enforce:
- Key Vault public network access disabled
- Storage Account public network access disabled

These guardrails prevent accidental misconfiguration through the portal or CLI.

---

## Traffic flow example
Workload
→ Azure Service FQDN
→ Private DNS zone
→ Private Endpoint private IP
→ Azure PaaS service

At no point does traffic traverse the public internet.

---

## Platform boundaries

This repository provides **infrastructure foundations only**.

It intentionally does not:
- Deploy application workloads
- Configure CI/CD pipelines
- Manage application-level secrets or identities

Those responsibilities belong to downstream workload repositories.