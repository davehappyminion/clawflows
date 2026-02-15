#!/usr/bin/env bats
# Tests for the open command

load '../test_helper'

setup() {
    setup_test_environment
    mock_editor  # Create a mock editor
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Basic Open Tests
# ============================================================================

@test "open: opens custom workflow file" {
    create_custom_workflow "my-custom" "🏠" "Custom workflow"

    run_clawflows open my-custom

    assert_success
    assert_output --partial "Opening"
}

@test "open: warns for community workflows" {
    create_community_workflow "test-workflow" "🧪" "Community workflow"

    run_clawflows open test-workflow

    assert_success
    assert_output --partial "is a community workflow"
    assert_output --partial "Changes will be lost on update"
}

@test "open: non-existent workflow fails" {
    run_clawflows open nonexistent-workflow

    assert_failure
    assert_output --partial "workflow 'nonexistent-workflow' not found"
}

@test "open: with no argument fails" {
    run_clawflows open

    assert_failure
    assert_output --partial "usage: clawflows open <name>"
}

# ============================================================================
# Editor Tests
# ============================================================================

@test "open: respects EDITOR env var" {
    create_custom_workflow "my-custom" "🏠" "Custom workflow"

    run_clawflows open my-custom

    assert_success
    # Our mock editor should have been used
    assert_output --partial "Opening"
}

@test "open: prefers custom over community" {
    create_community_workflow "shared-name" "🌍" "Community version"
    create_custom_workflow "shared-name" "🏠" "Custom version"

    run_clawflows open shared-name

    assert_success
    # Should NOT warn about community workflow since custom exists
    refute_output --partial "is a community workflow"
}

@test "open: missing WORKFLOW.md fails" {
    # Create directory but no WORKFLOW.md
    mkdir -p "${CUSTOM_DIR}/broken-workflow"

    run_clawflows open broken-workflow

    assert_failure
    assert_output --partial "WORKFLOW.md not found"
}

# Note: "no editor found" test is skipped because it's hard to
# reliably simulate no editor on most systems that have vim/nano/vi
