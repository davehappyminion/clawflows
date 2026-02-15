#!/usr/bin/env bats
# Tests for the list command

load '../test_helper'

setup() {
    setup_test_environment
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Basic List Tests
# ============================================================================

@test "list: shows enabled workflows" {
    create_community_workflow "workflow-a" "🅰️" "Workflow A"
    create_community_workflow "workflow-b" "🅱️" "Workflow B"
    enable_workflow "workflow-a"

    run_clawflows list

    assert_success
    assert_output --partial "Enabled (1)"
    assert_output --partial "workflow-a"
}

@test "list: shows available workflows" {
    create_community_workflow "workflow-a" "🅰️" "Workflow A"
    create_community_workflow "workflow-b" "🅱️" "Workflow B"
    enable_workflow "workflow-a"

    run_clawflows list

    assert_success
    assert_output --partial "Available (1)"
    assert_output --partial "workflow-b"
}

@test "list enabled: only shows enabled workflows" {
    create_community_workflow "workflow-a" "🅰️" "Workflow A"
    create_community_workflow "workflow-b" "🅱️" "Workflow B"
    enable_workflow "workflow-a"

    run_clawflows list enabled

    assert_success
    assert_output --partial "Enabled (1)"
    assert_output --partial "workflow-a"
    refute_output --partial "workflow-b"
}

@test "list available: only shows available workflows" {
    create_community_workflow "workflow-a" "🅰️" "Workflow A"
    create_community_workflow "workflow-b" "🅱️" "Workflow B"
    enable_workflow "workflow-a"

    run_clawflows list available

    assert_success
    assert_output --partial "Available (1)"
    assert_output --partial "workflow-b"
    refute_output --partial "Enabled"
}

@test "list: shows 'no workflows enabled' when none enabled" {
    create_community_workflow "workflow-a" "🅰️" "Workflow A"

    run_clawflows list enabled

    assert_success
    assert_output --partial "No workflows enabled"
}

@test "list: with empty directories shows 'no workflows'" {
    run_clawflows list

    assert_success
    assert_output --partial "No workflows found"
}

# ============================================================================
# Display Tests
# ============================================================================

@test "list: shows emoji and description" {
    create_community_workflow "test-workflow" "🧪" "A test workflow description"
    enable_workflow "test-workflow"

    run_clawflows list

    assert_success
    assert_output --partial "🧪"
    assert_output --partial "test-workflow"
    assert_output --partial "A test workflow description"
}

@test "list: skips .gitkeep files" {
    create_community_workflow "real-workflow" "🧪" "Real workflow"
    touch "${COMMUNITY_DIR}/.gitkeep"

    run_clawflows list

    assert_success
    assert_output --partial "real-workflow"
    refute_output --partial ".gitkeep"
}

@test "list: custom workflows override community by name" {
    create_community_workflow "shared-name" "🌍" "Community version"
    create_custom_workflow "shared-name" "🏠" "Custom version"

    run_clawflows list

    assert_success
    # Should show custom version's description
    assert_output --partial "Custom version"
    # Should NOT show community version
    refute_output --partial "Community version"
}

# ============================================================================
# Count Tests
# ============================================================================

@test "list: counts enabled correctly" {
    create_community_workflow "wf-1" "1️⃣" "First"
    create_community_workflow "wf-2" "2️⃣" "Second"
    create_community_workflow "wf-3" "3️⃣" "Third"
    enable_workflow "wf-1"
    enable_workflow "wf-2"

    run_clawflows list

    assert_success
    assert_output --partial "Enabled (2)"
    assert_output --partial "Available (1)"
}

@test "list: all filter shows everything" {
    create_community_workflow "wf-enabled" "✅" "Enabled one"
    create_community_workflow "wf-available" "📦" "Available one"
    enable_workflow "wf-enabled"

    run_clawflows list all

    assert_success
    assert_output --partial "Enabled (1)"
    assert_output --partial "Available (1)"
}
