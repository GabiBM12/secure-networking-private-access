# ADR 0003: Assign Azure Policy at Resource Group Scope

## Status
Accepted

## Context
Azure Policy can be assigned at:
- Management Group
- Subscription
- Resource Group scope

This repository represents a single platform boundary.

## Decision
Azure Policy assignments are applied at Resource Group scope.

## Consequences
- Guardrails apply only to resources managed by this platform
- No unintended impact on unrelated subscriptions or workloads
- Clear ownership and responsibility boundaries

Higher-level policy enforcement can be layered later if required.