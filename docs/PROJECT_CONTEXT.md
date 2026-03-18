<!-- doc-version: 0.2.0 -->
# Project Context - termux-client

## Vision

Provide a lightweight Android client layer that makes `dev-vm` usable from a
phone without turning the phone into a second development environment.

## Product Role

`termux-client` is not the workspace manager itself.
It is the Android/Termux entry layer for the wider `devenv` stack.

Its responsibilities are:

- make SSH access practical from Android
- provide shortcuts for common entry flows
- optionally expose `code-server` through a tunnel
- reduce friction when creating or opening work from a phone

## Current Reality

The repo is useful today and its main entry flows now align with the core:

- `op` opens existing work through `devenv open`
- `np` uses `newproj` for repo/bootstrap work, then enters `devenv open`
- the old `proj_*` session model is no longer the default mobile path

This repo remains a client layer. Future work should keep reducing local
workflow assumptions rather than rebuilding workspace logic here.

## Objectives

1. Reliable mobile SSH entry to `dev-vm`
2. Fast project selection from Android
3. Optional browser-based editing through `code-server`
4. Minimal setup on a new phone
5. Future convergence with the canonical `devenv` workspace model

## Key Components

| Component | Purpose |
|-----------|---------|
| `install.sh` | Install client commands into the local prefix |
| `bin/np` | Create/open a project flow from the client |
| `bin/op` | Pick and open an existing project |
| `bin/vscode-web` | Open `code-server` through an SSH tunnel |
| `bin/bootstrap-phone` | New-phone bootstrap helper |
| `bin/doctor-phone` | Connectivity and environment diagnostics |

## Current Status (2026-03-18)

- Governance baseline established at `v0.1.0`; first functional convergence slice shipped in `v0.2.0`
- Existing/open project flows now target the canonical `devenv` workspace interface
- Local worktree currently contains modified `bin/op`, `bin/np`, and `install.sh`
- Those local changes appear to support use from both Termux and a normal shell,
  but that behavior is not yet locked as a documented product contract

## Upcoming Milestones

1. Decide whether dual-mode local/Termux execution is part of the product
2. Align the remaining Android/bootstrap docs with the converged workflow
3. Observe the converged workflow in daily use and remove any leftover legacy assumptions

## References

- `~/src/tmux-workspace` - core project workspace manager
- `~/src/ssh-session-menu` - SSH general-session entry layer
- `~/src/home-infra/docs/DEVENV_STACK_MANIFEST.md` - stack source of truth
