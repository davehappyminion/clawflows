#!/usr/bin/env bats
# Tests for _find_openclaw and scheduler cron auto-setup

load '../test_helper'

setup() {
    setup_test_environment
    mock_openclaw "missing"  # Default: openclaw not available
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# _find_openclaw Tests
# ============================================================================

@test "find_openclaw: returns empty when openclaw is missing" {
    mock_openclaw "missing"

    run_clawflows run test-nonexistent 2>&1 || true

    # The mock sets OPENCLAW_CMD="" so _find_openclaw returns nothing
    # This means run falls back to showing instructions
    create_community_workflow "test-workflow" "🧪" "Test"
    enable_workflow "test-workflow"

    run_clawflows run test-workflow

    assert_success
    assert_output --partial "Workflow ready: test-workflow"
}

@test "find_openclaw: finds openclaw when OPENCLAW_CMD is set" {
    mock_openclaw "success"
    create_community_workflow "test-workflow" "🧪" "Test"
    enable_workflow "test-workflow"

    run_clawflows run test-workflow

    assert_success
    assert_output --partial "Running test-workflow"
    assert_output --partial "Mock openclaw"
}

# ============================================================================
# Enable + Scheduler Cron Auto-Setup Tests
# ============================================================================

@test "enable: sets up scheduler cron when enabling a scheduled workflow" {
    mock_openclaw "success"
    create_community_workflow "morning-brief" "☀️" "Morning briefing" "7am"

    run_clawflows enable morning-brief

    assert_success
    assert_output --partial "enabled: morning-brief"
    assert_output --partial "scheduler started"

    # Verify cron add was called
    assert [ -f "${TEST_TMPDIR}/openclaw.log" ]
    run cat "${TEST_TMPDIR}/openclaw.log"
    assert_output --partial "cron add"
    assert_output --partial "clawflows-scheduler"
}

@test "enable: does not set up scheduler for on-demand workflow" {
    mock_openclaw "success"
    create_community_workflow "test-workflow" "🧪" "Test workflow"
    # No schedule field

    run_clawflows enable test-workflow

    assert_success
    assert_output --partial "enabled: test-workflow"
    refute_output --partial "scheduler started"

    # cron add should not have been called
    if [ -f "${TEST_TMPDIR}/openclaw.log" ]; then
        run cat "${TEST_TMPDIR}/openclaw.log"
        refute_output --partial "cron add"
    fi
}

@test "enable: skips scheduler setup when cron already exists" {
    mock_openclaw "cron-exists"
    create_community_workflow "morning-brief" "☀️" "Morning briefing" "7am"

    run_clawflows enable morning-brief

    assert_success
    assert_output --partial "enabled: morning-brief"
    refute_output --partial "scheduler started"

    # cron list was called but cron add should not have been
    run cat "${TEST_TMPDIR}/openclaw.log"
    assert_output --partial "cron list"
    refute_output --partial "cron add"
}

@test "enable: skips scheduler when openclaw is missing" {
    mock_openclaw "missing"
    create_community_workflow "morning-brief" "☀️" "Morning briefing" "7am"

    run_clawflows enable morning-brief

    assert_success
    assert_output --partial "enabled: morning-brief"
    refute_output --partial "scheduler started"

    # No log file since openclaw was never called
    assert [ ! -f "${TEST_TMPDIR}/openclaw.log" ]
}

@test "enable: scheduler setup is idempotent across multiple scheduled workflows" {
    mock_openclaw "success"
    create_community_workflow "morning-brief" "☀️" "Morning briefing" "7am"
    create_community_workflow "evening-check" "🌙" "Evening check" "5pm"

    run_clawflows enable morning-brief
    assert_success
    assert_output --partial "scheduler started"

    # Second enable — mock still returns no cron (fresh mock), so it will set up again
    # In real usage, cron list would return the existing job after first add
    mock_openclaw "cron-exists"
    run_clawflows enable evening-check
    assert_success
    refute_output --partial "scheduler started"
}

# ============================================================================
# Uninstall + Scheduler Cron Removal Tests
# ============================================================================

@test "uninstall: removes scheduler cron when openclaw is available" {
    mock_openclaw "success"
    setup_agents_md

    run_clawflows uninstall <<< "y"

    assert_success
    assert_output --partial "Removed scheduler cron"

    run cat "${TEST_TMPDIR}/openclaw.log"
    assert_output --partial "cron remove"
    assert_output --partial "clawflows-scheduler"
}

@test "uninstall: skips cron removal when openclaw is missing" {
    mock_openclaw "missing"
    setup_agents_md

    run_clawflows uninstall <<< "y"

    assert_success
    refute_output --partial "Removed scheduler cron"
}
