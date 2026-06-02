#!/usr/bin/env bash

set -euo pipefail

EXAMPLE_FILE=".env.example"
ENV_FILE=".env"

if [[ ! -f "$EXAMPLE_FILE" ]]; then
  echo "Error: $EXAMPLE_FILE not found in current directory" >&2
  exit 1
fi

if [[ -f "$ENV_FILE" ]]; then
  read -r -p ".env already exists. Overwrite? [y/N] " confirm || true
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
  fi
fi

echo "Setting up $ENV_FILE based on $EXAMPLE_FILE"
echo ""

> "$ENV_FILE"

while IFS= read -r line || [[ -n "$line" ]]; do
  # Skip empty lines and comments
  if [[ -z "$line" || "$line" =~ ^# ]]; then
    echo "$line" >> "$ENV_FILE"
    continue
  fi

  # Extract variable name (everything before the first '=')
  var_name="${line%%=*}"

  # Extract default value (everything after the first '=')
  default_value="${line#*=}"

  if [[ -n "$default_value" ]]; then
    read -r -p "$var_name [$default_value]: " user_value || true
    value="${user_value:-$default_value}"
  else
    read -r -p "$var_name: " user_value || true
    value="$user_value"
  fi

  echo "${var_name}=${value}" >> "$ENV_FILE"

done < "$EXAMPLE_FILE"

echo ""
echo "$ENV_FILE created successfully."
