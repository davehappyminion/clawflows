#!/usr/bin/env bats
# Tests for the edit command

load '../test_helper'

setup() {
    setup_test_environment
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Basic Edit Tests
# ============================================================================

@test "edit: copies community workflow to custom" {
    create_community_workflow "test-workflow" "🧪" "Test workflow"

    run_clawflows edit test-workflow

    assert_success
    assert_output --partial "copied to custom/"
    assert [ -d "${CUSTOM_DIR}/test-workflow" ]
    assert [ -f "${CUSTOM_DIR}/test-workflow/WORKFLOW.md" ]
}

@test "edit: workflow already in custom shows path" {
    create_custom_workflow "my-custom" "🏠" "Custom workflow"

    run_clawflows edit my-custom

    assert_success
    assert_output --partial "workflow is in custom/"
    assert_output --partial "${CUSTOM_DIR}/my-custom/WORKFLOW.md"
}

@test "edit: updates symlink to custom version if enabled" {
    create_community_workflow "test-workflow" "🧪" "Test workflow"
    enable_workflow "test-workflow"

    # Verify it points to community first
    local before_target
    before_target="$(readlink "${ENABLED_DIR}/test-workflow")"
    [[ "$before_target" == *"community"* ]]

    run_clawflows edit test-workflow

    assert_success
    assert_output --partial "updated symlink to custom version"

    # Now should point to custom
    local after_target
    after_target="$(readlink "${ENABLED_DIR}/test-workflow")"
    [[ "$after_target" == *"custom"* ]]
}

@test "edit: non-existent workflow fails" {
    run_clawflows edit nonexistent-workflow

    assert_failure
    assert_output --partial "workflow 'nonexistent-workflow' not found"
}

@test "edit: with no argument fails" {
    run_clawflows edit

    assert_failure
    assert_output --partial "usage: clawflows edit <name>"
}

# ============================================================================
# Content Preservation Tests
# ============================================================================

@test "edit: preserves workflow content when copying" {
    create_community_workflow "test-workflow" "🧪" "Original description"

    run_clawflows edit test-workflow

    assert_success

    # Content should match
    run cat "${CUSTOM_DIR}/test-workflow/WORKFLOW.md"
    assert_output --partial "Original description"
}
