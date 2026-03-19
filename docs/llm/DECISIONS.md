# Architectural Decisions - termux-client

## D-001: termux-client is a client layer, not the workspace authority

- **Status**: accepted
- **Decision**: Treat `termux-client` as the Android/mobile entry layer for the
  wider `devenv` stack, not as the owner of project-workspace semantics.
- **Context**: The core workspace semantics live in `tmux-workspace` / `devenv`.
  This repo historically triggered a parallel `proj_*` flow. That was drift, not
  the desired long-term ownership model.
- **Rationale**: Keeping workspace ownership in one place is the only way to
  avoid client-specific behavior splitting the product into multiple systems.
- **Implications**: Future convergence work should make this repo consume the
  core interface instead of growing more workspace logic locally.

## D-002: governance before convergence

- **Status**: accepted
- **Decision**: Add versioning, handoff, history, and sync scripts before
  changing the current mobile workflow.
- **Context**: This repo had working scripts and ongoing local changes, but no
  comparable governance layer to the other repos in the stack.
- **Rationale**: Functional cleanup without history/handoff/versioning would
  create more drift, not less.
- **Implications**: Legacy workspace behavior elsewhere in the stack must now be
  documented and versioned instead of remaining implicit.

## D-003: keep repo/bootstrap in `newproj`, but workspace entry in `devenv`

- **Status**: accepted
- **Decision**: Use `newproj` only for repo creation/bootstrap from the phone,
  and use `devenv open <repo>` for entering the actual workspace.
- **Context**: The previous mobile flow asked `newproj --agents` to create
  `proj_*` tmux sessions, which made the Android client a second workspace
  manager next to the core `devenv` system.
- **Rationale**: Repo/bootstrap work and workspace entry are different concerns.
  `dev-tools` can keep owning repo creation while `tmux-workspace` / `devenv`
  remains the only owner of project-workspace semantics.
- **Implications**: `bin/op` and `bin/np` now target `devenv`, the canonical
  mobile session model becomes `dev_*`, `bootstrap-phone` now seeds the
  canonical `~/src` remote root, and `newproj` can remain bootstrap-only
  without owning tmux behavior.

## D-004: keep `termux-client` Termux-only

- **Status**: accepted
- **Decision**: Treat `termux-client` as a Termux/Android client only. Do not
  support the repo as a generic desktop or local-shell launcher.
- **Context**: Local modifications had introduced dual-mode behavior where
  `op`, `np`, and `install.sh` could also run outside Termux. That behavior was
  not part of the documented product and created renewed ambiguity about repo
  boundaries.
- **Rationale**: The stack already has supported non-Android entry paths:
  plain SSH for the general `ssh-*` menu and `tmux-workspace` desktop clients
  for convenience. Reusing `termux-client` outside Termux would blur the
  product boundary again.
- **Implications**: `op`, `np`, and `install.sh` must fail clearly outside
  Termux; docs must point desktop users to `tmux-workspace` or plain SSH; future
  widening of scope would require an explicit new decision and docs update.
