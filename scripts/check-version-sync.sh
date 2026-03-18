#!/bin/sh
# check-version-sync.sh -- Validate version markers against VERSION.

set -e

MANIFEST="docs/version-sync-manifest.yml"
VERSION_FILE="VERSION"
STAGED_ONLY=false

if [ "$1" = "--staged" ]; then
    STAGED_ONLY=true
fi

EXPECTED=$(head -1 "$VERSION_FILE" | tr -d '[:space:]')
ERRORS=0
CHECKED=0

STAGED_LIST=""
if [ "$STAGED_ONLY" = true ]; then
    STAGED_LIST=$(git diff --cached --name-only 2>/dev/null || echo "")
fi

TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT
grep '^- path:' "$MANIFEST" | sed 's/^- path: *\([^ ]*\) *marker: *\([^ ]*\).*/\1 \2/' > "$TMPFILE"

while read -r filepath markertype; do
    [ -f "$filepath" ] || continue

    if [ "$STAGED_ONLY" = true ]; then
        echo "$STAGED_LIST" | grep -q "^${filepath}$" || continue
    fi

    case "$markertype" in
        version-file)
            FOUND=$(head -1 "$filepath" | tr -d '[:space:]')
            [ "$FOUND" = "$EXPECTED" ] || {
                echo "DRIFT: $filepath has '$FOUND', expected '$EXPECTED'"
                ERRORS=$((ERRORS + 1))
            }
            CHECKED=$((CHECKED + 1))
            ;;
        html-comment)
            FOUND=$(grep -o '<!-- doc-version: [0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]* -->' "$filepath" 2>/dev/null | head -1 | sed 's/<!-- doc-version: \(.*\) -->/\1/')
            if [ -z "$FOUND" ]; then
                echo "DRIFT: $filepath missing <!-- doc-version: --> marker"
                ERRORS=$((ERRORS + 1))
            elif [ "$FOUND" != "$EXPECTED" ]; then
                echo "DRIFT: $filepath has '$FOUND', expected '$EXPECTED'"
                ERRORS=$((ERRORS + 1))
            fi
            CHECKED=$((CHECKED + 1))
            ;;
        changelog)
            grep -q "^## \[$EXPECTED\]" "$filepath" 2>/dev/null || {
                echo "DRIFT: $filepath missing ## [$EXPECTED] section"
                ERRORS=$((ERRORS + 1))
            }
            CHECKED=$((CHECKED + 1))
            ;;
    esac
done < "$TMPFILE"

if [ "$ERRORS" -gt 0 ]; then
    echo ""
    echo "FAILED: $ERRORS file(s) out of sync with VERSION ($EXPECTED). Checked $CHECKED target(s)."
    exit 1
fi

echo "OK: $CHECKED target(s) in sync with VERSION ($EXPECTED)"
