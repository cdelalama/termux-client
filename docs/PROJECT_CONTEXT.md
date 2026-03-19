<!-- doc-version: 0.2.1 -->
# Project Context - termux-client

## Vision

Provide a lightweight Android client layer that makes `dev-vm` usable from a
phone without turning the phone into a second development environment.
This product is specifically the Termux/Android client path.

## Product Role

`termux-client` is not the workspace manager itself.
It is the Android/Termux entry layer for the wider `devenv` stack.

Its responsibilities are:

- make SSH access practical from Android
- provide shortcuts for common entry flows
- optionally expose `code-server` through a tunnel
- reduce friction when creating or opening work from a phone

It is not responsible for:

- desktop/local-shell convenience outside Termux
- general SSH entry on laptops or desktops

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
5. Stable convergence with the canonical `devenv` workspace model without adding a second client contract

## Key Components

| Component | Purpose |
|-----------|---------|
| `install.sh` | Install client commands into the local prefix |
| `bin/np` | Create/open a project flow from the client |
| `bin/op` | Pick and open an existing project |
| `bin/vscode-web` | Open `code-server` through an SSH tunnel |
| `bin/bootstrap-phone` | New-phone bootstrap helper |
| `bin/doctor-phone` | Connectivity and environment diagnostics |

## Current Status (2026-03-19)

- Governance baseline established at `v0.1.0`; first functional convergence slice shipped in `v0.2.0`
- Runtime-boundary cleanup shipped in `v0.2.1`
- Existing/open project flows now target the canonical `devenv` workspace interface
- Supported runtime is now explicitly Termux on Android only
- `op`, `np`, and `install.sh` now fail clearly outside Termux instead of behaving as an undocumented second client

## Upcoming Milestones

1. Validate the converged Android flow on a real device
2. Keep Android/bootstrap docs aligned with the supported Termux-only contract
3. Observe the converged workflow in daily use and remove any leftover legacy assumptions

## References

- `~/src/tmux-workspace` - core project workspace manager
- `~/src/ssh-session-menu` - SSH general-session entry layer
- `~/src/home-infra/docs/DEVENV_STACK_MANIFEST.md` - stack source of truth
