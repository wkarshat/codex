#!/bin/sh
set -eu

# Verification only; the historical filename is retained for continuity.
DB="${CODEX_HOME:-$HOME/.codex}/state_5.sqlite"
IDS='019b3930-8418-7252-95f0-206e91ace10a
019b43b0-7dde-75e2-b514-de73e56fd215
019b47b9-a1e7-7c03-8275-7544cfc12134
019b5c92-60be-7f31-88a5-6ed31fb9b117
019c2cfd-4129-7f33-b95e-18c5b761cd53
019c2cfe-a108-7b53-aea0-5843b00cc394
019c2d2a-3d38-7b12-98b4-4318057087e0'

found=0
for id in $IDS; do
    if sqlite3 "$DB" "SELECT 1 FROM threads WHERE id = '$id' LIMIT 1;" | grep -q 1; then
        printf 'present: %s\n' "$id"
        found=1
    else
        printf 'absent:  %s\n' "$id"
    fi
done

exit "$found"
