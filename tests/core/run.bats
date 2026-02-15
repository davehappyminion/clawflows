#!/usr/bin/env bats
# Tests for the run command

load '../test_helper'

setup() {
    setup_test_environment
    mock_openclaw "missing"  # Default: openclaw not available
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Basic Run Tests
# ============================================================================

@test "run: runs enabled workflow (fallback mode without openclaw)" {
    create_community_workflow "test-workflow" "🧪" "Test workflow"
    enable_workflow "test-workflow"

    run_clawflows run test-workflow

    assert_success
    assert_output --partial "Workflow ready: test-workflow"
    assert_output --partial "Run test-workflow"
}

@test "run: auto-enables community workflow if not enabled" {
    create_community_workflow "test-workflow" "🧪" "Test workflow"
    # Don't enable it

    run_clawflows run test-workflow

    assert_success
    assert_output --partial "Enabling test-workflow"
    assert [ -L "${ENABLED_DIR}/test-workflow" ]
}

@test "run: auto-enables custom workflow if not enabled" {
    create_custom_workflow "my-custom" "🏠" "My custom workflow"
    # Don't enable it

    run_clawflows run my-custom

    assert_success
    assert_output --partial "Enabling my-custom"
    assert [ -L "${ENABLED_DIR}/my-custom" ]
}

@test "run: non-existent workflow fails" {
    run_clawflows run nonexistent-workflow

    assert_failure
    assert_output --partial "workflow 'nonexistent-workflow' not found"
}

@test "run: with no argument fails" {
    run_clawflows run

    assert_failure
    assert_output --partial "usage: clawflows run <name>"
}

# ============================================================================
# OpenClaw Integration Tests
# ============================================================================

@test "run: uses openclaw when available" {
    create_community_workflow "test-workflow" "🧪" "Test workflow"
    enable_workflow "test-workflow"
    mock_openclaw "success"

    run_clawflows run test-workflow

    assert_success
    assert_output --partial "Running test-workflow"
    assert_output --partial "Mock openclaw"
}

@test "run: fallback without openclaw shows instructions" {
    create_community_workflow "test-workflow" "🧪" "Test workflow"
    enable_workflow "test-workflow"
    mock_openclaw "missing"

    run_clawflows run test-workflow

    assert_success
    assert_output --partial "To run it, tell your agent"
}

# ============================================================================
# Edge Cases
# ============================================================================

@test "run: with missing WORKFLOW.md fails" {
    # Create directory but not WORKFLOW.md
    mkdir -p "${COMMUNITY_DIR}/broken-workflow"
    ln -s "${COMMUNITY_DIR}/broken-workflow" "${ENABLED_DIR}/broken-workflow"

    run_clawflows run broken-workflow

    assert_failure
    assert_output --partial "WORKFLOW.md not found"
}

@test "run: prefers custom over community" {
    create_community_workflow "shared-name" "🌍" "Community version"
    create_custom_workflow "shared-name" "🏠" "Custom version"
    # Neither enabled yet

    run_clawflows run shared-name

    assert_success
    # Should have enabled the custom one
    local target
    target="$(readlink "${ENABLED_DIR}/shared-name")"
    [[ "$target" == *"custom"* ]]
}
