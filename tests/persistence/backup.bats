#!/usr/bin/env bats
# Tests for the backup command

load '../test_helper'

setup() {
    setup_test_environment
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Basic Backup Tests
# ============================================================================

@test "backup: creates tar.gz archive" {
    create_custom_workflow "my-custom" "🏠" "Custom workflow"
    enable_workflow "my-custom"

    run_clawflows backup

    assert_success
    assert_output --partial "Backup created"

    # Check archive exists
    local backup_file
    backup_file=$(ls "${BACKUP_DIR}"/*.tar.gz 2>/dev/null | head -1)
    assert [ -f "$backup_file" ]
}

@test "backup: includes custom workflows" {
    create_custom_workflow "my-custom" "🏠" "Custom workflow"
    enable_workflow "my-custom"

    run_clawflows backup

    assert_success

    # Extract and check contents
    local backup_file
    backup_file=$(ls "${BACKUP_DIR}"/*.tar.gz | head -1)
    local extract_dir
    extract_dir=$(mktemp -d)
    tar -xzf "$backup_file" -C "$extract_dir"

    assert [ -d "${extract_dir}/custom/my-custom" ]
    assert [ -f "${extract_dir}/custom/my-custom/WORKFLOW.md" ]

    rm -rf "$extract_dir"
}

@test "backup: includes enabled list" {
    create_custom_workflow "custom-a" "🅰️" "Custom A"
    create_community_workflow "comm-b" "🅱️" "Community B"
    enable_workflow "custom-a"
    enable_workflow "comm-b"

    run_clawflows backup

    assert_success

    local backup_file
    backup_file=$(ls "${BACKUP_DIR}"/*.tar.gz | head -1)
    local extract_dir
    extract_dir=$(mktemp -d)
    tar -xzf "$backup_file" -C "$extract_dir"

    assert [ -f "${extract_dir}/enabled-workflows.txt" ]
    run cat "${extract_dir}/enabled-workflows.txt"
    assert_output --partial "custom-a"
    assert_output --partial "comm-b"

    rm -rf "$extract_dir"
}

@test "backup: excludes .gitkeep files" {
    create_custom_workflow "my-custom" "🏠" "Custom workflow"
    touch "${CUSTOM_DIR}/.gitkeep"

    run_clawflows backup

    assert_success

    local backup_file
    backup_file=$(ls "${BACKUP_DIR}"/*.tar.gz | head -1)
    local extract_dir
    extract_dir=$(mktemp -d)
    tar -xzf "$backup_file" -C "$extract_dir"

    # Should NOT contain .gitkeep
    assert [ ! -f "${extract_dir}/custom/.gitkeep" ]

    rm -rf "$extract_dir"
}

@test "backup: with custom filename" {
    create_custom_workflow "my-custom" "🏠" "Custom workflow"

    run_clawflows backup my-backup

    assert_success
    assert [ -f "${BACKUP_DIR}/my-backup.tar.gz" ]
}

@test "backup: with empty custom dir" {
    # No custom workflows
    run_clawflows backup

    assert_success
    assert_output --partial "Custom workflows: 0"
}

@test "backup: creates BACKUP_DIR if missing" {
    rm -rf "$BACKUP_DIR"
    create_custom_workflow "my-custom" "🏠" "Custom workflow"

    run_clawflows backup

    assert_success
    assert [ -d "$BACKUP_DIR" ]
}

@test "backup: shows correct counts" {
    create_custom_workflow "custom-1" "1️⃣" "Custom 1"
    create_custom_workflow "custom-2" "2️⃣" "Custom 2"
    create_community_workflow "comm-1" "🌍" "Community 1"
    enable_workflow "custom-1"
    enable_workflow "comm-1"

    run_clawflows backup

    assert_success
    assert_output --partial "Custom workflows: 2"
    assert_output --partial "Enabled workflows: 2"
}

@test "backup: timestamp format in filename" {
    create_custom_workflow "my-custom" "🏠" "Custom workflow"

    run_clawflows backup

    assert_success

    local backup_file
    backup_file=$(ls "${BACKUP_DIR}"/*.tar.gz | head -1)
    # Should match pattern: clawflows-YYYY-MM-DD-HHMMSS.tar.gz
    [[ "$backup_file" =~ clawflows-[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{6}\.tar\.gz ]]
}
