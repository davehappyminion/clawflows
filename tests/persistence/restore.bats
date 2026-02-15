#!/usr/bin/env bats
# Tests for the restore command

load '../test_helper'

setup() {
    setup_test_environment
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Basic Restore Tests
# ============================================================================

@test "restore: extracts custom workflows" {
    # Create a backup
    create_test_backup "test-backup.tar.gz" "restored-workflow"

    run_clawflows restore "test-backup.tar.gz"

    assert_success
    assert [ -d "${CUSTOM_DIR}/restored-workflow" ]
    assert [ -f "${CUSTOM_DIR}/restored-workflow/WORKFLOW.md" ]
}

@test "restore: re-enables workflows from backup" {
    # Create community workflow that will be re-enabled
    create_community_workflow "comm-workflow" "🌍" "Community workflow"

    # Create backup with that workflow in enabled list
    create_test_backup "test-backup.tar.gz" "comm-workflow"

    run_clawflows restore "test-backup.tar.gz"

    assert_success
    assert_output --partial "Enabled"
    assert [ -L "${ENABLED_DIR}/comm-workflow" ]
}

@test "restore: skips existing custom workflows" {
    # Create backup with a workflow
    create_test_backup "test-backup.tar.gz" "my-custom"

    # Create the same workflow locally
    create_custom_workflow "my-custom" "🏠" "Local version"

    run_clawflows restore "test-backup.tar.gz"

    assert_success
    assert_output --partial "Skipped"

    # Should still have local version
    run cat "${CUSTOM_DIR}/my-custom/WORKFLOW.md"
    assert_output --partial "Local version"
}

@test "restore: with 'latest' keyword" {
    # Create multiple backups
    create_test_backup "clawflows-2024-01-01-000001.tar.gz" "old-workflow"
    create_test_backup "clawflows-2024-01-02-000001.tar.gz" "new-workflow"

    run_clawflows restore latest

    assert_success
    # Should restore from the newer backup (sorted reverse alphabetically)
    assert [ -d "${CUSTOM_DIR}/new-workflow" ]
}

@test "restore: with specific file path" {
    create_test_backup "specific-backup.tar.gz" "specific-workflow"

    run_clawflows restore "${BACKUP_DIR}/specific-backup.tar.gz"

    assert_success
    assert [ -d "${CUSTOM_DIR}/specific-workflow" ]
}

@test "restore: with corrupted backup fails" {
    # Create an invalid tar.gz
    echo "not a valid archive" > "${BACKUP_DIR}/bad-backup.tar.gz"

    run_clawflows restore "bad-backup.tar.gz"

    assert_failure
}

@test "restore: calls sync-agent when workflows enabled" {
    create_community_workflow "comm-workflow" "🌍" "Community workflow"
    create_test_backup "test-backup.tar.gz" "comm-workflow"
    setup_agents_md

    run_clawflows restore "test-backup.tar.gz"

    assert_success
    # sync is called silently, but we can check AGENTS.md was updated
    run cat "$AGENTS_MD"
    assert_output --partial "comm-workflow"
}

@test "restore: no backups found" {
    # Empty backup dir
    rm -rf "${BACKUP_DIR}"/*

    run_clawflows restore

    assert_failure
    assert_output --partial "No backups found"
}

@test "restore: backup file not found" {
    run_clawflows restore "nonexistent.tar.gz"

    assert_failure
    assert_output --partial "backup not found"
}

# ============================================================================
# Edge Cases
# ============================================================================

@test "restore: workflow not in community or custom is skipped" {
    # Create a backup with enabled workflow that doesn't exist anywhere
    local tmpdir
    tmpdir=$(mktemp -d)
    mkdir -p "${tmpdir}/custom"
    echo "nonexistent-workflow" > "${tmpdir}/enabled-workflows.txt"
    tar -czf "${BACKUP_DIR}/orphan-backup.tar.gz" -C "$tmpdir" custom enabled-workflows.txt
    rm -rf "$tmpdir"

    run_clawflows restore "orphan-backup.tar.gz"

    assert_success
    # Should not have created symlink for nonexistent workflow
    assert [ ! -e "${ENABLED_DIR}/nonexistent-workflow" ]
}

@test "restore: multiple custom workflows" {
    create_test_backup "multi-backup.tar.gz" "wf-1" "wf-2" "wf-3"

    run_clawflows restore "multi-backup.tar.gz"

    assert_success
    assert_output --partial "Restored 3"
    assert [ -d "${CUSTOM_DIR}/wf-1" ]
    assert [ -d "${CUSTOM_DIR}/wf-2" ]
    assert [ -d "${CUSTOM_DIR}/wf-3" ]
}
