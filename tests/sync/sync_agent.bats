#!/usr/bin/env bats
# Tests for the sync-agent command

load '../test_helper'

setup() {
    setup_test_environment
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Basic Sync Tests
# ============================================================================

@test "sync-agent: creates block in AGENTS.md" {
    create_community_workflow "test-workflow" "🧪" "Test workflow"
    enable_workflow "test-workflow"
    touch "$AGENTS_MD"

    run_clawflows sync-agent

    assert_success
    assert_output --partial "synced AGENTS.md"
    run cat "$AGENTS_MD"
    assert_output --partial "<!-- clawflows:start -->"
    assert_output --partial "<!-- clawflows:end -->"
}

@test "sync-agent: replaces existing block" {
    create_community_workflow "test-workflow" "🧪" "Test workflow"
    enable_workflow "test-workflow"
    setup_agents_md

    # First sync
    run_clawflows sync-agent
    assert_success

    # Create another workflow and enable
    create_community_workflow "second-workflow" "✌️" "Second workflow"
    enable_workflow "second-workflow"

    # Second sync should replace, not duplicate
    run_clawflows sync-agent
    assert_success

    # Should only have one pair of markers
    run grep -c "clawflows:start" "$AGENTS_MD"
    assert_output "1"
}

@test "sync-agent: with no AGENTS.md skips gracefully" {
    rm -f "$AGENTS_MD"

    run_clawflows sync-agent

    assert_success
    assert_output --partial "skipping sync"
}

@test "sync-agent: includes all enabled workflows" {
    create_community_workflow "workflow-a" "🅰️" "Workflow A"
    create_community_workflow "workflow-b" "🅱️" "Workflow B"
    enable_workflow "workflow-a"
    enable_workflow "workflow-b"
    touch "$AGENTS_MD"

    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "workflow-a"
    assert_output --partial "workflow-b"
}

@test "sync-agent: shows schedule info" {
    create_workflow "community" "scheduled-wf" "⏰" "Scheduled workflow" "9am"
    enable_workflow "scheduled-wf"
    touch "$AGENTS_MD"

    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "9am"
}

@test "sync-agent: with broken symlinks skips them" {
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

@test "sync-agent: no workflows enabled shows message" {
    touch "$AGENTS_MD"

    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "No workflows enabled"
}

# ============================================================================
# Content Tests
# ============================================================================

@test "sync-agent: includes CLI commands section" {
    touch "$AGENTS_MD"

    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "CLI Commands"
    assert_output --partial "clawflows list"
    assert_output --partial "clawflows enable"
}

@test "sync-agent: includes workflow file paths" {
    create_community_workflow "test-workflow" "🧪" "Test workflow"
    enable_workflow "test-workflow"
    touch "$AGENTS_MD"

    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "WORKFLOW.md"
}
