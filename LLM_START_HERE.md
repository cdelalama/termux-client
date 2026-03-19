<!-- doc-version: 0.2.1 -->
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

- Last Updated: 2026-03-19 - GPT-5 Codex
- Working on: keep the Android client boundary explicit and prevent local-shell drift
- Status: v0.2.1; `op` and `np` enter work through `devenv`, and the supported runtime is Termux on Android

## Current Risk To Keep In Mind

The main risk in this repo is reintroducing a second non-Termux or non-`devenv`
workflow by accident.

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
