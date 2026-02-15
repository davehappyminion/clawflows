#!/usr/bin/env bash
# Run all clawflows tests
set -euo pipefail

TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BATS="${TESTS_DIR}/bats/bats-core/bin/bats"

# Default to running all tests
PATTERN="${1:-}"

if [[ -n "$PATTERN" ]]; then
    # Run specific test file or pattern
    "$BATS" --timing "${TESTS_DIR}/${PATTERN}"
else
    # Run all tests
    "$BATS" --timing "$TESTS_DIR"
fi
