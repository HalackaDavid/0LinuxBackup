#!/usr/bin/env zsh

file1="tmp1"
file2="tmp2"
tmpfile=$(mktemp)

# sort and unique then compare
comm -3 <(sort "$file1") <(sort "$file2") > "$tmpfile"

echo "Unique lines written to: $tmpfile"

