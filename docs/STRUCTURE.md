<!-- doc-version: 0.2.0 -->
# Repository Structure

```
termux-client/
+- README.md
+- VERSION
+- CHANGELOG.md
+- LLM_START_HERE.md
+- install.sh
+- bin/
|  +- op
|  +- np
|  +- vscode-web
|  +- bootstrap-phone
|  '- doctor-phone
+- docs/
|  +- PROJECT_CONTEXT.md
|  +- STRUCTURE.md
|  +- VERSIONING_RULES.md
|  +- version-sync-manifest.yml
|  '- llm/
|     +- README.md
|     +- HANDOFF.md
|     +- HISTORY.md
|     '- DECISIONS.md
'- scripts/
   +- bump-version.sh
   +- check-version-sync.sh
   '- pre-commit-hook.sh
```

## Notes

- Product code lives in `bin/` plus `install.sh`
- Governance and working-memory docs live under `docs/` and `docs/llm/`
- This repo currently has no automated tests
