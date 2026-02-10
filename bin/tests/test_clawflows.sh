#!/usr/bin/env bash
# Test suite for the clawflows CLI.
# Runs each test in an isolated sandbox — never touches real files.
#
# Usage: bash bin/tests/test_clawflows.sh

# ── Test framework ───────────────────────────────────────────────────────────

PASS=0
FAIL=0
ERRORS=()

red()   { printf '\033[31m%s\033[0m' "$*"; }
green() { printf '\033[32m%s\033[0m' "$*"; }
bold()  { printf '\033[1m%s\033[0m' "$*"; }

pass() {
  PASS=$((PASS + 1))
  echo "  $(green ✓) $1"
}

fail() {
  FAIL=$((FAIL + 1))
  ERRORS+=("$1: $2")
  echo "  $(red ✗) $1"
  echo "    $(red "$2")"
}

assert_equal() {
  local label="$1" expected="$2" actual="$3"
  if [ "$expected" = "$actual" ]; then
    pass "$label"
  else
    fail "$label" "expected: '$expected', got: '$actual'"
  fi
}

assert_contains() {
  local label="$1" haystack="$2" needle="$3"
  if printf '%s' "$haystack" | grep -qF -- "$needle"; then
    pass "$label"
  else
    fail "$label" "expected output to contain: '$needle'"
  fi
}

assert_not_contains() {
  local label="$1" haystack="$2" needle="$3"
  if printf '%s' "$haystack" | grep -qF -- "$needle"; then
    fail "$label" "expected output NOT to contain: '$needle'"
  else
    pass "$label"
  fi
}

assert_file_exists() {
  local label="$1" path="$2"
  if [ -e "$path" ]; then
    pass "$label"
  else
    fail "$label" "expected file to exist: $path"
  fi
}

assert_file_not_exists() {
  local label="$1" path="$2"
  if [ -e "$path" ]; then
    fail "$label" "expected file NOT to exist: $path"
  else
    pass "$label"
  fi
}

assert_dir_exists() {
  local label="$1" path="$2"
  if [ -d "$path" ]; then
    pass "$label"
  else
    fail "$label" "expected directory to exist: $path"
  fi
}

# ── Sandbox setup / teardown ────────────────────────────────────────────────

REAL_SCRIPT="$(cd "$(dirname "$0")/.." && pwd)/clawflows"
SANDBOX=""

test_setup() {
  SANDBOX="$(mktemp -d)"

  # Mirror project structure
  mkdir -p "$SANDBOX/bin" "$SANDBOX/available" "$SANDBOX/enabled"
  touch "$SANDBOX/enabled/.gitkeep"

  # Copy the real script into the sandbox so it resolves CLAWFLOWS_DIR to $SANDBOX
  cp "$REAL_SCRIPT" "$SANDBOX/bin/clawflows"
  chmod +x "$SANDBOX/bin/clawflows"

  # ── Fixture workflows ──

  # alpha — simple, no config
  mkdir -p "$SANDBOX/available/alpha"
  cat > "$SANDBOX/available/alpha/WORKFLOW.md" <<'FRONT'
---
name: alpha
description: Alpha workflow for testing
---

# Alpha

A test workflow.
FRONT

  # beta — has config.example.env, quoted description
  mkdir -p "$SANDBOX/available/beta/scripts"
  cat > "$SANDBOX/available/beta/WORKFLOW.md" <<'FRONT'
---
name: beta
description: "Beta workflow with quoted desc"
---

# Beta

Another test workflow.
FRONT
  echo "KEY=value" > "$SANDBOX/available/beta/config.example.env"
  echo "#!/bin/bash" > "$SANDBOX/available/beta/scripts/run.sh"

  # gamma — no description field
  mkdir -p "$SANDBOX/available/gamma"
  cat > "$SANDBOX/available/gamma/WORKFLOW.md" <<'FRONT'
---
name: gamma
---

# Gamma

Workflow with no description.
FRONT

  # Fake AGENTS.md with pre-existing content
  cat > "$SANDBOX/agents.md" <<'EOF'
# My Agents

Some content before the block.

## Other Section

More content here.
EOF
}

test_teardown() {
  if [ -n "$SANDBOX" ] && [ -d "$SANDBOX" ]; then
    rm -rf "$SANDBOX"
  fi
}

# ── CLI wrapper ──────────────────────────────────────────────────────────────

run_clawflows() {
  AGENTS_MD="$SANDBOX/agents.md" "$SANDBOX/bin/clawflows" "$@"
}

# ── Tests ────────────────────────────────────────────────────────────────────

test_list_all_disabled() {
  echo
  bold "list: all workflows disabled initially"
  echo
  local out
  out="$(run_clawflows list)"

  assert_contains "alpha shown"    "$out" "alpha"
  assert_contains "beta shown"     "$out" "beta"
  assert_contains "gamma shown"    "$out" "gamma"
  assert_contains "all disabled"   "$out" "disabled"
  assert_not_contains "none enabled" "$out" "enabled"
}

test_list_after_enable() {
  echo
  bold "list: shows enabled status after enabling"
  echo
  run_clawflows enable alpha > /dev/null
  local out
  out="$(run_clawflows list)"

  assert_contains "alpha is enabled"    "$out" "enabled"
  assert_contains "beta still disabled" "$out" "disabled"
}

test_list_shows_descriptions() {
  echo
  bold "list: descriptions shown in output"
  echo
  local out
  out="$(run_clawflows list)"

  assert_contains "alpha desc shown" "$out" "Alpha workflow for testing"
  assert_contains "beta desc shown"  "$out" "Beta workflow with quoted desc"
  # gamma has no description — body text should not leak into list
  assert_not_contains "gamma has no desc text" "$out" "Workflow with no description"
}

test_enable_copies_to_enabled() {
  echo
  bold "enable: copies workflow to enabled/"
  echo
  local out
  out="$(run_clawflows enable alpha)"

  assert_contains "prints enabled msg" "$out" "enabled: alpha"
  assert_dir_exists "alpha dir in enabled" "$SANDBOX/enabled/alpha"
  assert_file_exists "WORKFLOW.md copied" "$SANDBOX/enabled/alpha/WORKFLOW.md"
}

test_enable_syncs_agents_md() {
  echo
  bold "enable: syncs AGENTS.md"
  echo
  run_clawflows enable alpha > /dev/null
  local contents
  contents="$(cat "$SANDBOX/agents.md")"

  assert_contains "start marker" "$contents" "<!-- clawflows:start -->"
  assert_contains "end marker"   "$contents" "<!-- clawflows:end -->"
  assert_contains "alpha listed" "$contents" "alpha"
}

test_enable_config_reminder() {
  echo
  bold "enable: shows config reminder when config.example.env exists"
  echo
  local out
  out="$(run_clawflows enable beta)"

  assert_contains "config reminder" "$out" "copy config.example.env to config.env"
}

test_enable_nonexistent() {
  echo
  bold "enable: error for non-existent workflow"
  echo
  local exit_code=0
  local out
  out="$(run_clawflows enable nope 2>&1)" || exit_code=$?

  assert_equal "non-zero exit" "1" "$exit_code"
  assert_contains "error message" "$out" "not found"
}

test_enable_already_enabled() {
  echo
  bold "enable: already-enabled is not an error"
  echo
  run_clawflows enable alpha > /dev/null
  local exit_code=0
  local out
  out="$(run_clawflows enable alpha 2>&1)" || exit_code=$?

  assert_equal "exit code 0" "0" "$exit_code"
  assert_contains "already msg" "$out" "already enabled: alpha"
}

test_disable_removes_from_enabled() {
  echo
  bold "disable: removes workflow from enabled/"
  echo
  run_clawflows enable alpha > /dev/null
  assert_dir_exists "alpha enabled first" "$SANDBOX/enabled/alpha"

  local out
  out="$(run_clawflows disable alpha)"

  assert_contains "disabled msg" "$out" "disabled: alpha"
  assert_file_not_exists "alpha removed" "$SANDBOX/enabled/alpha"
}

test_disable_updates_agents_md() {
  echo
  bold "disable: updates AGENTS.md (workflow entry removed)"
  echo
  run_clawflows enable alpha > /dev/null
  run_clawflows disable alpha > /dev/null

  local contents
  contents="$(cat "$SANDBOX/agents.md")"

  assert_contains "markers still present" "$contents" "<!-- clawflows:start -->"
  assert_not_contains "alpha entry gone" "$contents" "alpha: Alpha"
}

test_disable_not_enabled() {
  echo
  bold "disable: not-enabled workflow is not an error"
  echo
  local exit_code=0
  local out
  out="$(run_clawflows disable alpha 2>&1)" || exit_code=$?

  assert_equal "exit code 0" "0" "$exit_code"
  assert_contains "not enabled msg" "$out" "not enabled: alpha"
}

test_sync_no_enabled() {
  echo
  bold "sync: no enabled workflows shows message"
  echo
  local out
  out="$(run_clawflows sync)"

  assert_contains "synced msg" "$out" "synced AGENTS.md"

  local contents
  contents="$(cat "$SANDBOX/agents.md")"
  assert_contains "no workflows msg" "$contents" "No workflows enabled yet"
}

test_sync_with_enabled() {
  echo
  bold "sync: enabled workflows are listed"
  echo
  run_clawflows enable alpha > /dev/null
  run_clawflows enable beta  > /dev/null

  local contents
  contents="$(cat "$SANDBOX/agents.md")"

  assert_contains "alpha entry" "$contents" "alpha: Alpha workflow for testing"
  assert_contains "beta entry"  "$contents" "beta: Beta workflow with quoted desc"
  assert_contains "alpha path"  "$contents" "$SANDBOX/enabled/alpha/WORKFLOW.md"
  assert_contains "beta path"   "$contents" "$SANDBOX/enabled/beta/WORKFLOW.md"
}

test_sync_idempotent() {
  echo
  bold "sync: idempotent — running twice produces identical output"
  echo
  run_clawflows enable alpha > /dev/null

  local first second
  first="$(cat "$SANDBOX/agents.md")"
  run_clawflows sync > /dev/null
  second="$(cat "$SANDBOX/agents.md")"

  assert_equal "identical after second sync" "$first" "$second"
}

test_sync_first_appends() {
  echo
  bold "sync: first sync appends block (no existing markers)"
  echo
  run_clawflows sync > /dev/null

  local contents
  contents="$(cat "$SANDBOX/agents.md")"
  assert_contains "start marker added" "$contents" "<!-- clawflows:start -->"
  assert_contains "end marker added"   "$contents" "<!-- clawflows:end -->"
}

test_sync_replaces_block() {
  echo
  bold "sync: subsequent sync replaces block (not duplicated)"
  echo
  # First sync — creates block with no enabled workflows
  run_clawflows sync > /dev/null
  # Enable alpha — triggers second sync
  run_clawflows enable alpha > /dev/null

  local contents
  contents="$(cat "$SANDBOX/agents.md")"

  # Should have exactly one start marker
  local marker_count
  marker_count="$(grep -c 'clawflows:start' "$SANDBOX/agents.md")"
  assert_equal "single start marker" "1" "$marker_count"

  assert_contains "alpha now in block" "$contents" "alpha: Alpha workflow for testing"
}

test_agents_md_preserves_before() {
  echo
  bold "AGENTS.md: content before markers preserved"
  echo
  run_clawflows sync > /dev/null

  local contents
  contents="$(cat "$SANDBOX/agents.md")"
  assert_contains "pre-block content" "$contents" "Some content before the block."
}

test_agents_md_preserves_after() {
  echo
  bold "AGENTS.md: content after markers preserved"
  echo
  # First sync — add block
  run_clawflows sync > /dev/null
  # Append content after the block
  printf '\n## Footer\n\nFooter content.\n' >> "$SANDBOX/agents.md"

  # Re-sync — should preserve footer
  run_clawflows sync > /dev/null

  local contents
  contents="$(cat "$SANDBOX/agents.md")"
  assert_contains "footer preserved" "$contents" "Footer content."
}

test_agents_md_correct_paths() {
  echo
  bold "AGENTS.md: block contains correct sandbox paths"
  echo
  run_clawflows enable alpha > /dev/null

  local contents
  contents="$(cat "$SANDBOX/agents.md")"
  assert_contains "enabled path uses sandbox" "$contents" "$SANDBOX/enabled/alpha/WORKFLOW.md"
  assert_contains "available path in browse"  "$contents" "$SANDBOX/available/"
}

test_frontmatter_standard() {
  echo
  bold "frontmatter: extracts standard description"
  echo
  local out
  out="$(run_clawflows list)"
  assert_contains "alpha desc" "$out" "Alpha workflow for testing"
}

test_frontmatter_quoted() {
  echo
  bold "frontmatter: handles quoted description"
  echo
  local out
  out="$(run_clawflows list)"
  assert_contains "beta desc (quoted)" "$out" "Beta workflow with quoted desc"
}

test_frontmatter_missing() {
  echo
  bold "frontmatter: handles missing description gracefully"
  echo
  local exit_code=0
  local out
  out="$(run_clawflows list 2>&1)" || exit_code=$?

  assert_equal "no crash" "0" "$exit_code"
  assert_contains "gamma listed" "$out" "gamma"
}

# ── Runner ───────────────────────────────────────────────────────────────────

run_test() {
  local test_fn="$1"
  test_setup
  "$test_fn"
  test_teardown
}

main() {
  # Disable errexit for the test runner — assertions handle failures
  set +e

  echo
  bold "clawflows test suite"
  echo
  echo "━━━━━━━━━━━━━━━━━━━━"

  local tests=(
    test_list_all_disabled
    test_list_after_enable
    test_list_shows_descriptions
    test_enable_copies_to_enabled
    test_enable_syncs_agents_md
    test_enable_config_reminder
    test_enable_nonexistent
    test_enable_already_enabled
    test_disable_removes_from_enabled
    test_disable_updates_agents_md
    test_disable_not_enabled
    test_sync_no_enabled
    test_sync_with_enabled
    test_sync_idempotent
    test_sync_first_appends
    test_sync_replaces_block
    test_agents_md_preserves_before
    test_agents_md_preserves_after
    test_agents_md_correct_paths
    test_frontmatter_standard
    test_frontmatter_quoted
    test_frontmatter_missing
  )

  for t in "${tests[@]}"; do
    run_test "$t"
  done

  echo
  echo "━━━━━━━━━━━━━━━━━━━━"
  echo "$(bold "Results:") $(green "$PASS passed"), $([ "$FAIL" -gt 0 ] && red "$FAIL failed" || echo "$FAIL failed")"

  if [ "$FAIL" -gt 0 ]; then
    echo
    bold "Failures:"
    echo
    for err in "${ERRORS[@]}"; do
      echo "  $(red "•") $err"
    done
    echo
    exit 1
  fi

  echo
  exit 0
}

main
