<!-- doc-version: 0.2.0 -->
# LLM Start Guide - termux-client

## Read This First

Recommended order:
1. This file
2. `README.md`
3. `docs/PROJECT_CONTEXT.md`
4. `docs/VERSIONING_RULES.md`
5. `docs/llm/HANDOFF.md`
6. `docs/llm/DECISIONS.md`

## Critical Rules

### Language Policy

- Code, comments, and docs: English
- Conversation with the user: Spanish

### Documentation Rules

- Update `docs/llm/HANDOFF.md` when the repo state or focus changes
- Append a session entry to `docs/llm/HISTORY.md` whenever you do work here
- Put durable rationale in `docs/llm/DECISIONS.md`
- Keep this file's Current Focus aligned with `docs/llm/HANDOFF.md`

### Versioning Rules

- `VERSION` is the source of truth
- Use `scripts/bump-version.sh <new_version>` for version bumps
- Validate with `scripts/check-version-sync.sh`
- Any commit that changes product code/config should include a version bump

## Current Focus

Source of truth: `docs/llm/HANDOFF.md`.

- Last Updated: 2026-03-18 - GPT-5 Codex
- Working on: first functional convergence slice so mobile entry uses the canonical `devenv` interface
- Status: v0.2.0; `op` and `np` now enter work through `devenv`, while `newproj` remains repo/bootstrap tooling

## Current Risk To Keep In Mind

This repo currently has local modified files in:

- `bin/op`
- `bin/np`
- `install.sh`

Treat them as active local state. Do not overwrite them casually while adding
governance or planning convergence work.

## Checklist

- Read `README.md`
- Read `docs/PROJECT_CONTEXT.md`
- Read `docs/VERSIONING_RULES.md`
- Read `docs/llm/HANDOFF.md`
- Do the work
- Update `docs/llm/HANDOFF.md`
- Append to `docs/llm/HISTORY.md`
- If version changes, run `scripts/bump-version.sh`

## Quick Navigation

- Overview: `README.md`
- Project context: `docs/PROJECT_CONTEXT.md`
- Repo structure: `docs/STRUCTURE.md`
- Version rules: `docs/VERSIONING_RULES.md`
- Handoff: `docs/llm/HANDOFF.md`
- History: `docs/llm/HISTORY.md`
- Decisions: `docs/llm/DECISIONS.md`

---

Do not use this repo as a second source of workspace truth. It is a client layer.
