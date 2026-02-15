#!/usr/bin/env bats
# Tests for the submit command

load '../test_helper'

setup() {
    setup_test_environment
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Basic Submit Tests
# ============================================================================

@test "submit: copies custom workflow to community-submissions" {
    create_custom_workflow "my-custom" "🏠" "My custom workflow"

    run_clawflows submit my-custom

    assert_success
    assert_output --partial "Workflow copied to community-submissions/"
    assert [ -d "${CLAWFLOWS_DIR}/community-submissions/my-custom" ]
    assert [ -f "${CLAWFLOWS_DIR}/community-submissions/my-custom/WORKFLOW.md" ]
}

@test "submit: only works on custom workflows" {
    create_community_workflow "community-wf" "🌍" "Community workflow"

    run_clawflows submit community-wf

    assert_failure
    assert_output --partial "already a community workflow"
}

@test "submit: non-existent custom workflow fails" {
    run_clawflows submit nonexistent

    assert_failure
    assert_output --partial "not found in custom/"
}

@test "submit: duplicate submission fails" {
    create_custom_workflow "my-custom" "🏠" "My custom workflow"

    # First submit
    run_clawflows submit my-custom
    assert_success

    # Second submit should fail
    run_clawflows submit my-custom
    assert_failure
    assert_output --partial "already been submitted"
}

@test "submit: with no argument fails" {
    run_clawflows submit

    assert_failure
    assert_output --partial "usage: clawflows submit <name>"
}

# ============================================================================
# Validation Tests
# ============================================================================

@test "submit: validates workflow before submitting" {
    # Create workflow without required fields
    mkdir -p "${CUSTOM_DIR}/invalid-wf"
    cat > "${CUSTOM_DIR}/invalid-wf/WORKFLOW.md" << 'EOF'
---
name: invalid-wf
---

Missing emoji and description.
EOF

    run_clawflows submit invalid-wf

    assert_failure
    assert_output --partial "Missing required field"
}

# ============================================================================
# Output Tests
# ============================================================================

@test "submit: shows next steps" {
    create_custom_workflow "my-custom" "🏠" "My custom workflow"

    run_clawflows submit my-custom

    assert_success
    assert_output --partial "Next steps"
    assert_output --partial "Fork this repo"
    assert_output --partial "git add"
    assert_output --partial "git commit"
    assert_output --partial "pull request"
}
