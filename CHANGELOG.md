## [0.2.0] - 2026-03-18

### Added

### Changed

### Fixed

## [0.2.0] - 2026-03-18

### Added

- Clear host-side dependency checks in `op` and `np` for `devenv` and `newproj`

### Changed

- `op` now opens existing repos through the canonical `devenv open <repo>` flow
- `np` now uses `newproj` only for repo creation/bootstrap, then enters the canonical `devenv` workspace with `devenv open <repo>`
- Mobile project entry no longer asks `newproj` to create `proj_*` tmux sessions
- `bootstrap-phone` now seeds the canonical remote workspace root at `~/src` and describes the new `devenv`-based mobile flows

### Fixed

- Removed the biggest current workflow drift in the Android client by aligning project entry with the core `dev_*` model

## [0.1.0] - 2026-03-18

### Added

- Governance and versioning scaffold for the existing Android client repo
- LLM handoff/history/decision files for future stack-alignment work

### Changed

- Established `termux-client` as a governed client-layer repo in the wider
  `devenv` stack

### Fixed
