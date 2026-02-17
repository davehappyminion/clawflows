#!/usr/bin/env bash
# Test helper for clawflows BATS tests
# Provides test isolation, fixtures, and helper functions

# Load BATS support libraries
TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
load "${TESTS_DIR}/bats/bats-support/load"
load "${TESTS_DIR}/bats/bats-assert/load"

# Path to the real CLI (for reference, not used directly in isolated tests)
REAL_CLI="${TESTS_DIR}/../system/cli/clawflows"

# ============================================================================
# Test Environment Setup
# ============================================================================

# setup_test_environment creates an isolated test environment
# Call this in setup() for each test file
setup_test_environment() {
    # Create isolated temp directory for this test
    export TEST_TMPDIR="${BATS_TEST_TMPDIR:-$(mktemp -d)}"

    # Override all clawflows paths to use temp directory
    export CLAWFLOWS_DIR="${TEST_TMPDIR}/clawflows"
    export AGENTS_MD="${TEST_TMPDIR}/AGENTS.md"
    export BACKUP_DIR="${TEST_TMPDIR}/backups"

    # These would normally be set by the CLI, but we set them for testing
    export CUSTOM_DIR="${CLAWFLOWS_DIR}/workflows/available/custom"
    export COMMUNITY_DIR="${CLAWFLOWS_DIR}/workflows/available/community"
    export ENABLED_DIR="${CLAWFLOWS_DIR}/workflows/enabled"

    # Create directory structure
    mkdir -p "$CUSTOM_DIR"
    mkdir -p "$COMMUNITY_DIR"
    mkdir -p "$ENABLED_DIR"
    mkdir -p "$BACKUP_DIR"
    mkdir -p "${CLAWFLOWS_DIR}/system/cli"
    mkdir -p "${CLAWFLOWS_DIR}/community-submissions"

    # Create a modified CLI that uses our test paths
    create_test_cli

    # Create empty AGENTS.md
    touch "$AGENTS_MD"
}

# teardown_test_environment cleans up after tests
# Call this in teardown() for each test file
teardown_test_environment() {
    # BATS_TEST_TMPDIR is auto-cleaned by BATS
    # Only clean up if we created our own tmpdir
    if [[ -z "${BATS_TEST_TMPDIR:-}" && -n "${TEST_TMPDIR:-}" ]]; then
        rm -rf "$TEST_TMPDIR"
    fi
}

# create_test_cli creates a CLI wrapper that uses test paths
create_test_cli() {
    export TEST_CLI="${CLAWFLOWS_DIR}/system/cli/clawflows"

    # Create a wrapper script that sets our test paths then sources the real CLI
    cat > "$TEST_CLI" << EOF
#!/usr/bin/env bash
set -euo pipefail

# TEST OVERRIDES - injected by test_helper.bash
CLAWFLOWS_DIR="${CLAWFLOWS_DIR}"
AGENTS_MD="${AGENTS_MD}"
BACKUP_DIR="${BACKUP_DIR}"
COMMUNITY_DIR="${COMMUNITY_DIR}"
CUSTOM_DIR="${CUSTOM_DIR}"
ENABLED_DIR="${ENABLED_DIR}"
SUBMISSIONS_DIR="${CLAWFLOWS_DIR}/community-submissions"
BIN_TARGET="\$HOME/.local/bin/clawflows"

START_MARKER="<!-- clawflows:start -->"
END_MARKER="<!-- clawflows:end -->"

EOF

    # Append the real CLI, skipping the config section
    # Start from _find_openclaw (before Helpers) so tests get the openclaw lookup
    awk '
        /^# ── Find openclaw/ { found=1 }
        found { print }
    ' "$REAL_CLI" >> "$TEST_CLI"

    chmod +x "$TEST_CLI"
}

# ============================================================================
# Workflow Creation Helpers
# ============================================================================

# create_workflow creates a workflow in the specified location
# Usage: create_workflow <location> <name> [emoji] [description] [schedule] [author]
# location: "community" or "custom"
create_workflow() {
    local location="$1"
    local name="$2"
    local emoji="${3:-}"
    local description="${4:-A test workflow}"
    local schedule="${5:-}"
    local author="${6:-}"

    local target_dir
    if [[ "$location" == "community" ]]; then
        target_dir="${COMMUNITY_DIR}/${name}"
    elif [[ "$location" == "custom" ]]; then
        target_dir="${CUSTOM_DIR}/${name}"
    else
        echo "Invalid location: $location" >&2
        return 1
    fi

    mkdir -p "$target_dir"

    # Build YAML frontmatter
    local content="---
name: ${name}"

    if [[ -n "$emoji" ]]; then
        content="${content}
emoji: ${emoji}"
    fi

    content="${content}
description: ${description}"

    if [[ -n "$schedule" ]]; then
        content="${content}
schedule: \"${schedule}\""
    fi

    if [[ -n "$author" ]]; then
        content="${content}
author: ${author}"
    fi

    content="${content}
---

# ${name}

This is a test workflow for ${name}.
"

    printf '%s\n' "$content" > "${target_dir}/WORKFLOW.md"
}

# create_community_workflow is a convenience wrapper
create_community_workflow() {
    create_workflow "community" "$@"
}

# create_custom_workflow is a convenience wrapper
create_custom_workflow() {
    create_workflow "custom" "$@"
}

# enable_workflow creates a symlink in enabled/
enable_workflow() {
    local name="$1"
    local source_dir

    if [[ -d "${CUSTOM_DIR}/${name}" ]]; then
        source_dir="${CUSTOM_DIR}/${name}"
    elif [[ -d "${COMMUNITY_DIR}/${name}" ]]; then
        source_dir="${COMMUNITY_DIR}/${name}"
    else
        echo "Workflow not found: $name" >&2
        return 1
    fi

    ln -s "$source_dir" "${ENABLED_DIR}/${name}"
}

# create_broken_symlink creates a symlink pointing to non-existent location
create_broken_symlink() {
    local name="$1"
    ln -s "/nonexistent/path/${name}" "${ENABLED_DIR}/${name}"
}

# ============================================================================
# AGENTS.md Helpers
# ============================================================================

# setup_agents_md creates an AGENTS.md with optional existing content
setup_agents_md() {
    local existing_content="${1:-}"

    if [[ -n "$existing_content" ]]; then
        printf '%s\n' "$existing_content" > "$AGENTS_MD"
    else
        # Create with clawflows markers
        cat > "$AGENTS_MD" << 'EOF'
# Agent Instructions

Some existing content above clawflows.

<!-- clawflows:start -->
<!-- clawflows:end -->

Some existing content below clawflows.
EOF
    fi
}

# agents_md_contains checks if AGENTS.md contains a string
agents_md_contains() {
    local pattern="$1"
    grep -q "$pattern" "$AGENTS_MD"
}

# ============================================================================
# Assertion Helpers
# ============================================================================

# assert_workflow_exists checks that a workflow exists in a location
assert_workflow_exists() {
    local location="$1"
    local name="$2"

    local dir
    case "$location" in
        community) dir="${COMMUNITY_DIR}/${name}" ;;
        custom) dir="${CUSTOM_DIR}/${name}" ;;
        enabled) dir="${ENABLED_DIR}/${name}" ;;
        *) fail "Invalid location: $location" ;;
    esac

    [[ -e "$dir" ]] || fail "Expected workflow to exist: $dir"
    [[ -f "${dir}/WORKFLOW.md" || -L "$dir" ]] || fail "Expected WORKFLOW.md at: ${dir}/WORKFLOW.md"
}

# assert_workflow_not_exists checks that a workflow does not exist
assert_workflow_not_exists() {
    local location="$1"
    local name="$2"

    local dir
    case "$location" in
        community) dir="${COMMUNITY_DIR}/${name}" ;;
        custom) dir="${CUSTOM_DIR}/${name}" ;;
        enabled) dir="${ENABLED_DIR}/${name}" ;;
        *) fail "Invalid location: $location" ;;
    esac

    [[ ! -e "$dir" ]] || fail "Expected workflow to not exist: $dir"
}

# assert_symlink_target checks that a symlink points to expected target
assert_symlink_target() {
    local symlink="$1"
    local expected_target="$2"

    [[ -L "$symlink" ]] || fail "Expected symlink: $symlink"
    local actual_target
    actual_target="$(readlink "$symlink")"
    [[ "$actual_target" == "$expected_target" ]] || \
        fail "Expected symlink target '$expected_target', got '$actual_target'"
}

# assert_is_symlink checks that a path is a symlink
assert_is_symlink() {
    local path="$1"
    [[ -L "$path" ]] || fail "Expected symlink: $path"
}

# assert_is_directory checks that a path is a real directory (not symlink)
assert_is_directory() {
    local path="$1"
    [[ -d "$path" && ! -L "$path" ]] || fail "Expected directory (not symlink): $path"
}

# ============================================================================
# CLI Execution Helpers
# ============================================================================

# run_clawflows runs the test CLI with given arguments
# Results are in $output, $status, $lines (standard BATS run behavior)
run_clawflows() {
    run "$TEST_CLI" "$@"
}

# ============================================================================
# Fixture Helpers
# ============================================================================

# Copy fixtures from tests/fixtures to test environment
copy_fixture() {
    local fixture_name="$1"
    local dest_location="$2"  # "community" or "custom"

    local fixture_path="${TESTS_DIR}/fixtures/${fixture_name}"
    local dest_dir

    if [[ "$dest_location" == "community" ]]; then
        dest_dir="${COMMUNITY_DIR}/${fixture_name}"
    else
        dest_dir="${CUSTOM_DIR}/${fixture_name}"
    fi

    cp -r "$fixture_path" "$dest_dir"
}

# ============================================================================
# JSON Helpers (for create --from-json tests)
# ============================================================================

# create_json builds a JSON string for workflow creation
create_json() {
    local name="$1"
    local summary="$2"
    local description="$3"
    local emoji="${4:-}"
    local schedule="${5:-}"
    local author="${6:-}"

    local json="{\"name\": \"${name}\", \"summary\": \"${summary}\", \"description\": \"${description}\""

    [[ -n "$emoji" ]] && json="${json}, \"emoji\": \"${emoji}\""
    [[ -n "$schedule" ]] && json="${json}, \"schedule\": \"${schedule}\""
    [[ -n "$author" ]] && json="${json}, \"author\": \"${author}\""

    json="${json}}"
    echo "$json"
}

# ============================================================================
# Backup Helpers
# ============================================================================

# create_test_backup creates a backup file for restore tests
create_test_backup() {
    local backup_name="${1:-test-backup.tar.gz}"
    local workflows=("${@:2}")  # Remaining args are workflow names

    local temp_dir
    temp_dir=$(mktemp -d)

    mkdir -p "${temp_dir}/custom"

    # Create workflow directories in backup
    for wf in "${workflows[@]}"; do
        mkdir -p "${temp_dir}/custom/${wf}"
        cat > "${temp_dir}/custom/${wf}/WORKFLOW.md" << EOF
---
name: ${wf}
emoji: 📦
description: Backup test workflow ${wf}
---

# ${wf}

Restored from backup.
EOF
    done

    # Create enabled list
    printf '%s\n' "${workflows[@]}" > "${temp_dir}/enabled-workflows.txt"

    # Create tarball
    tar -czf "${BACKUP_DIR}/${backup_name}" -C "$temp_dir" custom enabled-workflows.txt

    rm -rf "$temp_dir"

    echo "${BACKUP_DIR}/${backup_name}"
}

# ============================================================================
# Mock Helpers
# ============================================================================

# mock_openclaw creates a fake openclaw command via the OPENCLAW_CMD env var.
# This controls _find_openclaw() so hardcoded path fallbacks can't find a real openclaw.
mock_openclaw() {
    local behavior="${1:-success}"  # success, fail, or missing

    if [[ "$behavior" == "missing" ]]; then
        # OPENCLAW_CMD="" tells _find_openclaw to return empty (not found)
        export OPENCLAW_CMD=""
        return
    fi

    mkdir -p "${TEST_TMPDIR}/bin"

    local log_file="${TEST_TMPDIR}/openclaw.log"

    if [[ "$behavior" == "success" ]]; then
        cat > "${TEST_TMPDIR}/bin/openclaw" << EOF
#!/bin/bash
echo "\$*" >> "${log_file}"
echo "Mock openclaw: \$*"
exit 0
EOF
    elif [[ "$behavior" == "cron-exists" ]]; then
        # Simulates scheduler already set up
        cat > "${TEST_TMPDIR}/bin/openclaw" << EOF
#!/bin/bash
echo "\$*" >> "${log_file}"
if [[ "\$1" == "cron" && "\$2" == "list" ]]; then
    echo "clawflows-scheduler  */15 * * * *"
else
    echo "Mock openclaw: \$*"
fi
exit 0
EOF
    else
        cat > "${TEST_TMPDIR}/bin/openclaw" << EOF
#!/bin/bash
echo "\$*" >> "${log_file}"
echo "Mock openclaw failed: \$*" >&2
exit 1
EOF
    fi

    chmod +x "${TEST_TMPDIR}/bin/openclaw"
    export OPENCLAW_CMD="${TEST_TMPDIR}/bin/openclaw"
}

# mock_editor creates a fake editor that just touches the file
mock_editor() {
    mkdir -p "${TEST_TMPDIR}/bin"
    cat > "${TEST_TMPDIR}/bin/mock-editor" << 'EOF'
#!/bin/bash
# Just touch the file to simulate editing
touch "$1"
exit 0
EOF
    chmod +x "${TEST_TMPDIR}/bin/mock-editor"
    export EDITOR="${TEST_TMPDIR}/bin/mock-editor"
}

# mock_git creates a fake git command for update tests
mock_git() {
    local behavior="${1:-success}"

    mkdir -p "${TEST_TMPDIR}/bin"

    if [[ "$behavior" == "success" ]]; then
        cat > "${TEST_TMPDIR}/bin/git" << 'EOF'
#!/bin/bash
echo "Mock git: $*"
exit 0
EOF
    else
        cat > "${TEST_TMPDIR}/bin/git" << 'EOF'
#!/bin/bash
echo "Mock git failed: $*" >&2
exit 1
EOF
    fi

    chmod +x "${TEST_TMPDIR}/bin/git"
    export PATH="${TEST_TMPDIR}/bin:${PATH}"
}
