<!-- doc-version: 0.2.1 -->
# Handoff - termux-client

## Current Status

- **Last updated**: 2026-03-19 - GPT-5 Codex
- **Focus**: Close the remaining termux-client contract drift by making the repo explicitly Termux-only
- **Status**: v0.2.1 on `main`

## Immediate Context

`termux-client` remains the Android entry layer for `dev-vm`.
The main project-entry drift was reduced in the previous slice, and the remaining
runtime-boundary drift is closed here.

What changed:

- `op` now opens existing projects with `devenv open <repo>`
- `np` now uses `newproj` only for repo/bootstrap work and then enters
  `devenv open <repo>`
- the mobile client no longer asks `newproj` to create `proj_*` tmux sessions
- `op`, `np`, and `install.sh` now fail clearly outside Termux instead of acting
  as an undocumented second client mode

This keeps repo creation in `dev-tools` while moving workspace entry back to the
core owner of workspace semantics.

## Active Files

| File | State |
|------|-------|
| `README.md` | Updated - explicit that the repo is Termux/Android-only and points desktop users elsewhere |
| `CHANGELOG.md` | Updated - records canonical `devenv` convergence and the boundary clarification |
| `LLM_START_HERE.md` | New - contributor and governance rules |
| `docs/PROJECT_CONTEXT.md` | Updated - repo role and runtime boundary clarified |
| `docs/STRUCTURE.md` | New - repo layout |
| `docs/VERSIONING_RULES.md` | New - version policy |
| `docs/llm/HANDOFF.md` | Updated - current state and boundary decisions |
| `docs/llm/HISTORY.md` | New - append-only session record |
| `docs/llm/DECISIONS.md` | Updated - stable rationale |
| `scripts/check-version-sync.sh` | New - marker drift validation |
| `scripts/bump-version.sh` | New - atomic version marker updates |
| `scripts/pre-commit-hook.sh` | New - commit guardrail template |
| `bin/op` | Modified - Termux-only wrapper for project selection and `devenv open` |
| `bin/np` | Modified - Termux-only wrapper for repo bootstrap then `devenv open` |
| `bin/bootstrap-phone` | Modified - now seeds `~/src` and describes `devenv`-based mobile entry |
| `install.sh` | Modified - Termux-only installer with explicit failure on unsupported environments |

## Current Version

- **termux-client**: 0.2.1

## Top Priorities

1. Keep the new `devenv`-based mobile entry stable inside the supported Termux runtime
2. Keep bootstrap/docs aligned with the supported Termux-only workflow
3. Validate the converged flow on a real Android device
4. Keep stack-level docs in `home-infra` aligned with any future change here

## Key Decisions

- D-001: `termux-client` is a client layer, not the owner of workspace semantics
- D-002: establish governance before changing the mobile workflow
- D-003: use `newproj` for repo/bootstrap work, but `devenv` for workspace entry
- D-004: `termux-client` is Termux-only; desktop/local-shell use belongs elsewhere

## Do Not Touch

- The new `devenv`-based entry flow without coordinating docs/bootstrap changes
- Host/config conventions in `~/.config/termux-client/config` without checking
  docs and bootstrap implications
- The Termux-only runtime boundary unless the product scope is explicitly widened

## Open Questions

- Should `op` / `np` keep opening `code-server` automatically, or should project entry and browser entry become separate choices?

## Testing Notes

- No automated tests exist yet
- Syntax validated with `bash -n` for `bin/op`, `bin/np`, `bin/bootstrap-phone`, and `install.sh`
- Negative-path validation should confirm `op`, `np`, and `install.sh` now reject non-Termux execution
- Mocked command-capture validation should confirm:
  - `op` now builds SSH -> `devenv open <repo>`
  - `np` now builds SSH -> `newproj <repo> private && devenv open <repo>`
- Governance validation for this slice should use `scripts/check-version-sync.sh`
