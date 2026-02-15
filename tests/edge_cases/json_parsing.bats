#!/usr/bin/env bats
# Tests for JSON parsing in create --from-json

load '../test_helper'

setup() {
    setup_test_environment
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# JSON Parsing Tests
# ============================================================================

@test "JSON: valid JSON with all fields" {
    local json='{"name": "full-workflow", "summary": "Full summary", "description": "Full description", "emoji": "🎯", "schedule": "9am", "author": "@test"}'

    run_clawflows create --from-json "$json"

    assert_success
    assert [ -f "${CUSTOM_DIR}/full-workflow/WORKFLOW.md" ]

    run cat "${CUSTOM_DIR}/full-workflow/WORKFLOW.md"
    assert_output --partial "name: full-workflow"
    assert_output --partial "emoji: 🎯"
    assert_output --partial 'schedule: "9am"'
    assert_output --partial "author: @test"
}

@test "JSON: with missing required field fails" {
    local json='{"name": "missing-summary", "description": "Has description but no summary"}'

    run_clawflows create --from-json "$json"

    assert_failure
    assert_output --partial "Missing required field: summary"
}

@test "JSON: with extra whitespace works" {
    local json='{  "name"  :  "spaced"  ,  "summary"  :  "Has spaces"  ,  "description"  :  "Test"  }'

    run_clawflows create --from-json "$json"

    assert_success
    assert [ -f "${CUSTOM_DIR}/spaced/WORKFLOW.md" ]
}

@test "JSON: with optional fields missing uses defaults" {
    local json='{"name": "minimal", "summary": "Minimal workflow", "description": "Just required fields"}'

    run_clawflows create --from-json "$json"

    assert_success
    run cat "${CUSTOM_DIR}/minimal/WORKFLOW.md"
    # Should have default emoji
    assert_output --partial "emoji: 🔧"
    # Should NOT have schedule
    refute_output --partial "schedule:"
}

@test "JSON: empty JSON fails" {
    run_clawflows create --from-json '{}'

    assert_failure
    assert_output --partial "Missing required field"
}

@test "JSON: completely invalid JSON handles gracefully" {
    run_clawflows create --from-json "not json at all"

    assert_failure
    # Should fail on missing required fields, not crash
    assert_output --partial "Missing required field"
}

@test "JSON: duplicate workflow name fails" {
    create_custom_workflow "existing" "🏠" "Existing workflow"

    local json='{"name": "existing", "summary": "Duplicate name", "description": "Should fail"}'

    run_clawflows create --from-json "$json"

    assert_failure
    assert_output --partial "already exists"
}

# ============================================================================
# Known Limitations
# ============================================================================

# Note: The JSON parser uses simple grep/sed and has known limitations:
# - Escaped quotes in values will break parsing
# - Multiline strings are not supported
# - Nested objects are not supported
# These are documented limitations of the simple bash JSON parsing approach.
