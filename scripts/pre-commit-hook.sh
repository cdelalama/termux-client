#!/bin/sh
# pre-commit-hook.sh -- guardrail for versioned product-code changes.

MANIFEST="docs/version-sync-manifest.yml"
CHECK_SCRIPT="scripts/check-version-sync.sh"
STAGED=$(git diff --cached --name-only 2>/dev/null)

[ -n "$STAGED" ] || exit 0

if echo "$STAGED" | grep -q '^VERSION$'; then
    MISSING=""
    TMPFILE=$(mktemp)
    trap 'rm -f "$TMPFILE"' EXIT
    grep '^- path:' "$MANIFEST" | sed 's/^- path: *\([^ ]*\).*/\1/' > "$TMPFILE"

    while read -r filepath; do
        [ "$filepath" = "VERSION" ] && continue
        [ -f "$filepath" ] || continue
        if ! echo "$STAGED" | grep -q "^${filepath}$"; then
            MISSING="$MISSING  - $filepath"
        fi
    done < "$TMPFILE"

    if [ -n "$MISSING" ]; then
        echo "ERROR: VERSION is staged but these tracked files are not:"
        echo "$MISSING"
        exit 1
    fi
fi

CODE_CHANGED=$(echo "$STAGED" | grep -E '^(install\.sh|bin/.*|.*\.(sh|bash|zsh|ps1|py|json|yaml|yml|cfg|conf))$' | grep -v '^docs/' | grep -v '^scripts/' || true)
if [ -n "$CODE_CHANGED" ]; then
    if ! echo "$STAGED" | grep -q '^VERSION$'; then
        echo "ERROR: Product code/config changed but VERSION not staged."
        echo "Changed: $(echo "$CODE_CHANGED" | tr '\n' ' ')"
        exit 1
    fi
    if ! echo "$STAGED" | grep -q 'docs/llm/HISTORY.md'; then
        echo "WARNING: Product code/config changed but docs/llm/HISTORY.md not staged."
        echo ""
    fi
fi

[ -f "$CHECK_SCRIPT" ] && "$CHECK_SCRIPT"
