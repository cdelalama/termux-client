## [0.2.1] - 2026-03-19

### Added

### Changed

- `op`, `np`, and `install.sh` are now explicitly supported only inside Termux on Android
- README and working-memory docs now point desktop/local-shell users to plain SSH or the `tmux-workspace` desktop client
- Removed the leftover duplicated launch heading in the README

### Fixed

- Closed the remaining product-boundary drift where `termux-client` still behaved like an undocumented second desktop/local-shell client

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
