#!/bin/sh
# bump-version.sh -- Update all version-synced files to a new version.

set -e

NEW_VERSION="$1"
if [ -z "$NEW_VERSION" ]; then
    echo "Usage: $0 <new_version>" >&2
    exit 1
fi

echo "$NEW_VERSION" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+$' || {
    echo "ERROR: version must be in X.Y.Z format (got: $NEW_VERSION)" >&2
    exit 1
}

MANIFEST="docs/version-sync-manifest.yml"
VERSION_FILE="VERSION"
SCRIPT_DIR=$(dirname "$0")

OLD_VERSION=$(head -1 "$VERSION_FILE" 2>/dev/null | tr -d '[:space:]' || echo "unknown")
DATE=$(date +%Y-%m-%d)

echo "Bumping version: $OLD_VERSION -> $NEW_VERSION"

TMPFILE=$(mktemp)
trap 'rm -f "$TMPFILE"' EXIT
grep '^- path:' "$MANIFEST" | sed 's/^- path: *\([^ ]*\) *marker: *\([^ ]*\).*/\1 \2/' > "$TMPFILE"

while read -r filepath markertype; do
    [ -f "$filepath" ] || continue

    case "$markertype" in
        version-file)
            TMPOUT=$(mktemp)
            echo "$NEW_VERSION" > "$TMPOUT"
            tail -n +2 "$filepath" >> "$TMPOUT"
            mv "$TMPOUT" "$filepath"
            ;;
        html-comment)
            TMPOUT=$(mktemp)
            sed "s/<!-- doc-version: [0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]* -->/<!-- doc-version: $NEW_VERSION -->/" \
                "$filepath" > "$TMPOUT"
            mv "$TMPOUT" "$filepath"
            ;;
        changelog)
            if ! grep -q "^## \[$NEW_VERSION\]" "$filepath"; then
                TMPOUT=$(mktemp)
                awk -v ver="$NEW_VERSION" -v dt="$DATE" '
                    /^## \[/ && !done {
                        print "## [" ver "] - " dt
                        print ""
                        print "### Added"
                        print ""
                        print "### Changed"
                        print ""
                        print "### Fixed"
                        print ""
                        done = 1
                    }
                    { print }
                ' "$filepath" > "$TMPOUT"
                mv "$TMPOUT" "$filepath"
            fi
            ;;
    esac
done < "$TMPFILE"

"$SCRIPT_DIR/check-version-sync.sh"
