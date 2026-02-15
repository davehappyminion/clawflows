#!/usr/bin/env bats
# Tests for the update command

load '../test_helper'

setup() {
    setup_test_environment
    # Initialize as git repo for update tests
    git -C "$CLAWFLOWS_DIR" init -q 2>/dev/null || true
    git -C "$CLAWFLOWS_DIR" config user.email "test@test.com" 2>/dev/null || true
    git -C "$CLAWFLOWS_DIR" config user.name "Test" 2>/dev/null || true
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Basic Update Tests
# ============================================================================

@test "update: runs git pull" {
    mock_git "success"

    run_clawflows update

    assert_success
    assert_output --partial "Updating clawflows"
}

@test "update: calls sync-agent on success" {
    mock_git "success"
    setup_agents_md

    run_clawflows update

    assert_success
    assert_output --partial "synced AGENTS.md"
}

@test "update: with offline/no network shows error" {
    mock_git "fail"

    run_clawflows update

    assert_failure
    assert_output --partial "Could not update"
}

@test "update: preserves custom workflows" {
    create_custom_workflow "my-custom" "🏠" "My custom workflow"
    mock_git "success"

    run_clawflows update

    assert_success
    # Custom workflow should still exist
    assert [ -d "${CUSTOM_DIR}/my-custom" ]
    assert [ -f "${CUSTOM_DIR}/my-custom/WORKFLOW.md" ]
}

# ============================================================================
# Edge Cases
# ============================================================================

@test "update: suggests manual git pull on failure" {
    mock_git "fail"

    run_clawflows update

    assert_failure
    assert_output --partial "git -C"
    assert_output --partial "pull"
}
