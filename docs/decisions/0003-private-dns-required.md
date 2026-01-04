# ADR 0001: Use Private DNS with Private Link

## Status
Accepted

## Context
Azure Private Endpoints expose services via private IPs, but Azure PaaS services present TLS certificates and SDK endpoints bound to official public FQDNs.

Using private IPs directly would break:
- TLS certificate validation
- Azure SDK endpoint resolution

## Decision
Azure Private DNS zones are used to override public DNS resolution inside the Virtual Network.

Private DNS zones are:
- Linked to the VNet
- Associated with Private Endpoints via DNS zone groups

## Consequences
- Workloads continue using official Azure service FQDNs
- TLS and SDK compatibility are preserved
- Traffic remains private and deterministic

This approach aligns with Azure recommended practices for Private Link.