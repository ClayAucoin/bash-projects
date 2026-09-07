#!/usr/bin/env bash
set -euo pipefail

echo "This script will combine file contents from the current directory (recursively)."
echo "Enter extensions to include (without the dot). Type '-' when finished."

# --- collect extensions ---
extensions=()
while true; do
  read -rp "Extension to include (or '-' for no more): " ext_raw
  ext_trimmed="${ext_raw#"${ext_raw%%[![:space:]]*}"}"   # ltrim
  ext_trimmed="${ext_trimmed%"${ext_trimmed##*[![:space:]]}"}"   # rtrim
  ext_lower=$(printf "%s" "$ext_trimmed" | tr '[:upper:]' '[:lower:]')
  if [[ "$ext_lower" == "-" ]]; then
    break
  fi
  ext="${ext_lower#.}"  # remove leading dot if present
  if [[ -z "$ext" ]]; then
    echo "Empty extension skipped."
    continue
  fi
  extensions+=("$ext")
done

if (( ${#extensions[@]} == 0 )); then
  echo "No extensions provided. Exiting."
  exit 1
fi

# --- build output filename ---
dirbase="${PWD##*/}"
dirnorm=$(printf "%s" "$dirbase" | tr -cd '[:alnum:]-' | tr '[:upper:]' '[:lower:]')
extslug=$(IFS=-; echo "${extensions[*]}")
outfname="contents-of-${dirnorm}-${extslug}.txt"

# --- build find expression ---
expr=()
for e in "${extensions[@]}"; do
  expr+=(-o -iname "*.${e}")
done
expr=( "${expr[@]:1}" )

# --- decide whether to exclude test.js files ---
exclude_tests=false
for e in "${extensions[@]}"; do
  if [[ "$e" == "js" ]]; then
    exclude_tests=true
    break
  fi
done

echo "Collecting files (excluding node_modules, coverage, and JS test files when applicable)..."

# Determine if JS is one of the selected extensions
exclude_js_tests=false
for e in "${extensions[@]}"; do
  if [[ "$e" == "js" ]]; then
    exclude_js_tests=true
    break
  fi
done

# shellcheck disable=SC2207
if $exclude_js_tests; then
  mapfile -d '' files < <(
    find . \
      -type d \( -name node_modules -o -name coverage \) -prune -o \
      -type f \( "${expr[@]}" \) \
      ! -iname "*.test.js" \
      ! -iname "*.spec.js" \
      -print0 | sort -z
  )
else
  mapfile -d '' files < <(
    find . \
      -type d \( -name node_modules -o -name coverage \) -prune -o \
      -type f \( "${expr[@]}" \) \
      -print0 | sort -z
  )
fi

# --- check for no files found ---
if (( ${#files[@]} == 0 )); then
  echo "No matching files found for: ${extensions[*]}"
  exit 0
fi

# --- write output ---
tmpfile="${outfname}.tmp.$$"
: > "$tmpfile"

for f in "${files[@]}"; do
  rel="${f#./}"
  if [[ "$rel" == "$outfname" ]]; then
    continue
  fi
  {
    printf "%s\n\n" "$rel"
    cat -- "$f"
    printf "\n\n"
  } >> "$tmpfile"
done

mv -f -- "$tmpfile" "$outfname"
echo "Done. Wrote: $outfname"
