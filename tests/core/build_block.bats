#!/usr/bin/env bats
# Tests for _build_block() output (AGENTS.md content generation)

load '../test_helper'

setup() {
    setup_test_environment
    setup_agents_md
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Simple Workflow Guidance
# ============================================================================

@test "build_block: includes simple workflow guidance section" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "Keep Workflows Simple"
}

@test "build_block: advises plain language and short steps" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "Plain language"
    assert_output --partial "Fewer steps is better"
}

# ============================================================================
# Generic Workflow Guidance
# ============================================================================

@test "build_block: includes generic workflow guidance section" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "Keep Workflows Generic"
}

@test "build_block: warns against hardcoding user details" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "Never hardcode"
    assert_output --partial "name, location, timezone"
}

@test "build_block: includes bad and good examples" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "Bad:"
    assert_output --partial "Good:"
}

@test "build_block: advises runtime discovery over hardcoded values" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "Discover at runtime"
}

# ============================================================================
# Basic Block Structure
# ============================================================================

@test "build_block: includes clawflows markers" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "<!-- clawflows:start -->"
    assert_output --partial "<!-- clawflows:end -->"
}

@test "build_block: includes CLI commands section" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "### CLI Commands"
    assert_output --partial "clawflows list"
    assert_output --partial "clawflows enable"
}

@test "build_block: includes sharing workflows section" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "### Sharing Workflows"
}

@test "build_block: shows no workflows message when none enabled" {
    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "No workflows enabled yet"
}

@test "build_block: lists enabled workflows" {
    create_community_workflow "test-wf" "🧪" "A test workflow"
    enable_workflow "test-wf"

    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    assert_output --partial "### Enabled Workflows"
    assert_output --partial "test-wf"
    assert_output --partial "A test workflow"
}
