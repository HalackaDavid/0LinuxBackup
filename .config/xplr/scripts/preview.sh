#!/bin/sh

file="$1"

case "$file" in
    *.png|*.jpg|*.jpeg|*.gif|*.webp)
        ueberzugpp layer --silent <<EOF
{
    "action": "add",
    "identifier": "preview",
    "path": "$file",
    "x": 1,
    "y": 1,
    "width": 30,
    "height": 15
}
EOF
        ;;
    *)
        file "$file"
        ;;
esac
