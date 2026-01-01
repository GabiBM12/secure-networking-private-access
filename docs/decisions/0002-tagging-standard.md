# ADR 0002 — Tagging standard

## Decision
All taggable resources must receive tags via a shared tags map.

Environment layer merges base tags with mandatory tags:
- project
- environment
- managed_by = terraform
- repo = repo-02

## Rationale
Tags enable cost management, ownership, inventory, and governance.