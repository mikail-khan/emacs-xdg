#!/usr/bin/env zsh

set -euo pipefail

EMACS_DIR="${HOME}/.config/emacs"
OUT="${EMACS_DIR}/code.output"

: > "$OUT"

for file in \
  "$EMACS_DIR/early-init.el" \
  "$EMACS_DIR/init.el" \
  "$EMACS_DIR/custom.el" \
  "$EMACS_DIR/local.el"
do
  if [[ -f "$file" ]]; then
    {
      print "\n\n;;; ============================================================"
      print ";;; FILE: ${file#$EMACS_DIR/}"
      print ";;; ============================================================\n"
      cat "$file"
    } >> "$OUT"
  fi
done

if [[ -d "$EMACS_DIR/lisp" ]]; then
  find "$EMACS_DIR/lisp" \
    -type f \
    -name '*.el' \
    -print0 |
    sort -z |
    while IFS= read -r -d '' file; do
      {
        print "\n\n;;; ============================================================"
        print ";;; FILE: ${file#$EMACS_DIR/}"
        print ";;; ============================================================\n"
        cat "$file"
      } >> "$OUT"
    done
fi

print "Wrote: $OUT"