<!-- doc-version: 0.2.0 -->
# Handoff - termux-client

## Current Status

- **Last updated**: 2026-03-18 - GPT-5 Codex
- **Focus**: First functional convergence slice from mobile entry into the canonical `devenv` interface
- **Status**: v0.2.0 on `main`

## Immediate Context

`termux-client` remains the Android entry layer for `dev-vm`, but the main
project-entry drift was reduced in this slice.

What changed:

- `op` now opens existing projects with `devenv open <repo>`
- `np` now uses `newproj` only for repo/bootstrap work and then enters
  `devenv open <repo>`
- the mobile client no longer asks `newproj` to create `proj_*` tmux sessions

This keeps repo creation in `dev-tools` while moving workspace entry back to the
core owner of workspace semantics.

Important local-state warning:

- the current worktree has modified `bin/op`, `bin/np`, and `install.sh`
- those changes appear to support use outside Termux as well as inside it
- do not overwrite or normalize them blindly; treat them as active local state
  until the user decides whether that behavior should become official

## Active Files

| File | State |
|------|-------|
| `README.md` | Updated - now version-tracked and explicit about current role |
| `CHANGELOG.md` | Updated - records the convergence slice to canonical `devenv` entry |
| `LLM_START_HERE.md` | New - contributor and governance rules |
| `docs/PROJECT_CONTEXT.md` | New - repo role and current drift captured |
| `docs/STRUCTURE.md` | New - repo layout |
| `docs/VERSIONING_RULES.md` | New - version policy |
| `docs/llm/HANDOFF.md` | New - current state |
| `docs/llm/HISTORY.md` | New - append-only session record |
| `docs/llm/DECISIONS.md` | New - stable rationale |
| `scripts/check-version-sync.sh` | New - marker drift validation |
| `scripts/bump-version.sh` | New - atomic version marker updates |
| `scripts/pre-commit-hook.sh` | New - commit guardrail template |
| `bin/op` | Modified - now opens canonical `devenv` workspaces while keeping dual-mode behavior |
| `bin/np` | Modified - now separates repo creation from workspace entry while keeping dual-mode behavior |
| `bin/bootstrap-phone` | Modified - now seeds `~/src` and describes `devenv`-based mobile entry |
| `install.sh` | Locally modified - dual-mode install behavior under evaluation |

## Current Version

- **termux-client**: 0.2.0

## Top Priorities

1. Keep the new `devenv`-based mobile entry stable while evaluating the remaining dual-mode behavior
2. Decide whether the current local/Termux dual-mode execution should be part of the product
3. Keep bootstrap/docs aligned with the converged mobile workflow
4. Keep stack-level docs in `home-infra` aligned with any future change here

## Key Decisions

- D-001: `termux-client` is a client layer, not the owner of workspace semantics
- D-002: establish governance before changing the mobile workflow
- D-003: use `newproj` for repo/bootstrap work, but `devenv` for workspace entry

## Do Not Touch

- The current local modifications in `bin/op`, `bin/np`, and `install.sh` without
  first understanding whether they are user-owned or intended future behavior
- The new `devenv`-based entry flow without coordinating docs/bootstrap changes
- Host/config conventions in `~/.config/termux-client/config` without checking
  docs and bootstrap implications

## Open Questions

- Should dual-mode use from both Termux and a normal shell become an official supported mode?
- Should `op` / `np` keep opening `code-server` automatically, or should project entry and browser entry become separate choices?

## Testing Notes

- No automated tests exist yet
- Syntax validated with `bash -n` for `bin/op`, `bin/np`, and `install.sh`
- Syntax validated with `bash -n` for `bin/op`, `bin/np`, `bin/bootstrap-phone`, and `install.sh`
- Mocked command-capture validation confirms:
  - `op` now builds `devenv open <repo>`
  - `np` now builds `newproj <repo> private && devenv open <repo>`
- Governance validation for this slice should use `scripts/check-version-sync.sh`
