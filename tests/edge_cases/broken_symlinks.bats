#!/usr/bin/env bats
# Tests for broken symlink handling

load '../test_helper'

setup() {
    setup_test_environment
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Broken Symlink Tests
# ============================================================================

@test "broken symlink: list skips broken symlinks" {
    create_community_workflow "valid-workflow" "✅" "Valid workflow"
    enable_workflow "valid-workflow"
    create_broken_symlink "broken-workflow"

    run_clawflows list enabled

    assert_success
    assert_output --partial "valid-workflow"
    # Broken symlink should be silently skipped
    refute_output --partial "broken-workflow"
}

@test "broken symlink: run fails with clear error" {
    create_broken_symlink "broken-workflow"

    run_clawflows run broken-workflow

    assert_failure
    assert_output --partial "not found"
}

@test "broken symlink: sync-agent skips broken symlinks" {
    create_community_workflow "valid-workflow" "✅" "Valid workflow"
    enable_workflow "valid-workflow"
    create_broken_symlink "broken-workflow"
    touch "$AGENTS_MD"

    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "valid-workflow"
    refute_output --partial "broken-workflow"
}

@test "broken symlink: disable removes broken symlink" {
    create_broken_symlink "broken-workflow"

    # Verify the broken symlink exists
    assert [ -L "${ENABLED_DIR}/broken-workflow" ]

    run_clawflows disable broken-workflow

    assert_success
    assert [ ! -e "${ENABLED_DIR}/broken-workflow" ]
}

@test "broken symlink: created when source deleted after enable" {
    create_community_workflow "temp-workflow" "🕐" "Temporary workflow"
    enable_workflow "temp-workflow"

    # Delete the source (simulates update removing a workflow)
    rm -rf "${COMMUNITY_DIR}/temp-workflow"

    # Now the symlink is broken
    run_clawflows run temp-workflow

    assert_failure
    # Should fail because WORKFLOW.md not found
    assert_output --partial "not found"
}
