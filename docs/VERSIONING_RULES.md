<!-- doc-version: 0.2.0 -->
# Versioning Rules - termux-client

## Version Format

This repo uses Semantic Versioning: `MAJOR.MINOR.PATCH`

## Where Versions Live

| File | Marker |
|------|--------|
| `VERSION` | plain version string |
| `CHANGELOG.md` | `## [X.Y.Z]` section |
| `README.md` | `<!-- doc-version: X.Y.Z -->` |
| `LLM_START_HERE.md` | `<!-- doc-version: X.Y.Z -->` |
| `docs/PROJECT_CONTEXT.md` | `<!-- doc-version: X.Y.Z -->` |
| `docs/STRUCTURE.md` | `<!-- doc-version: X.Y.Z -->` |
| `docs/VERSIONING_RULES.md` | `<!-- doc-version: X.Y.Z -->` |
| `docs/llm/HANDOFF.md` | `<!-- doc-version: X.Y.Z -->` |

Tracked targets are listed in `docs/version-sync-manifest.yml`.

## Bump Guidelines

### Patch

- Bug fixes
- README or handoff corrections
- Non-breaking maintenance

### Minor

- New client features
- New setup or diagnostics capabilities
- Backward-compatible changes to how mobile entry works

### Major

- Breaking changes to configuration
- Removing supported entry flows
- Replacing the current mobile workflow in a way that requires operator action

## Update Process

1. Decide patch/minor/major impact
2. Run `scripts/bump-version.sh <new_version>`
3. Update `CHANGELOG.md`
4. Update `docs/llm/HANDOFF.md`
5. Append to `docs/llm/HISTORY.md`
6. Run `scripts/check-version-sync.sh`

## Rule For Product Code Changes

Any commit that changes:

- `install.sh`
- files in `bin/`
- future config or code files

must include a version bump.
