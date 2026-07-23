#!/bin/sh
printf '\033c\033]0;%s\a' Coins&Cities
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Coins&Cities.x86_64" "$@"
