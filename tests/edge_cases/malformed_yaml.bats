#!/usr/bin/env bats
# Tests for malformed YAML handling

load '../test_helper'

setup() {
    setup_test_environment
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Malformed YAML Tests
# ============================================================================

@test "malformed YAML: missing name field shows in list without name" {
    copy_fixture "missing-name" "community"

    run_clawflows list

    assert_success
    # Should still show in list (uses directory name)
    assert_output --partial "missing-name"
}

@test "malformed YAML: missing closing marker still extracts fields" {
    copy_fixture "no-closing-marker" "community"
    enable_workflow "no-closing-marker"
    touch "$AGENTS_MD"

    run_clawflows sync-agent

    assert_success
    run cat "$AGENTS_MD"
    # Should still find the workflow (uses what it can extract)
    assert_output --partial "no-closing-marker"
}

@test "malformed YAML: emoji without colon returns empty" {
    copy_fixture "malformed-yaml" "community"

    run_clawflows list

    assert_success
    # Workflow should appear but without emoji
    assert_output --partial "malformed-yaml"
}

@test "malformed YAML: validate catches missing fields" {
    mkdir -p "${CUSTOM_DIR}/incomplete"
    cat > "${CUSTOM_DIR}/incomplete/WORKFLOW.md" << 'EOF'
---
name: incomplete
---

No emoji or description.
EOF

    run_clawflows validate incomplete

    assert_failure
    assert_output --partial "Missing required field: emoji"
}

@test "malformed YAML: validate catches missing frontmatter" {
    mkdir -p "${CUSTOM_DIR}/no-frontmatter"
    cat > "${CUSTOM_DIR}/no-frontmatter/WORKFLOW.md" << 'EOF'
# No Frontmatter

This file has no YAML frontmatter at all.
EOF

    run_clawflows validate no-frontmatter

    assert_failure
    assert_output --partial "Missing frontmatter"
}

# ============================================================================
# Valid Edge Cases
# ============================================================================

@test "YAML: colon in description value is handled" {
    mkdir -p "${COMMUNITY_DIR}/colon-desc"
    cat > "${COMMUNITY_DIR}/colon-desc/WORKFLOW.md" << 'EOF'
---
name: colon-desc
emoji: 🔧
description: Schedule: 9am, 5pm
---

Test workflow.
EOF

    run_clawflows list

    assert_success
    # Full description should be shown
    assert_output --partial "Schedule: 9am, 5pm"
}

@test "YAML: unicode emoji in workflow" {
    mkdir -p "${COMMUNITY_DIR}/emoji-test"
    cat > "${COMMUNITY_DIR}/emoji-test/WORKFLOW.md" << 'EOF'
---
name: emoji-test
emoji: 🎉🎊✨
description: Celebration workflow
---

Test workflow.
EOF

    run_clawflows list

    assert_success
    assert_output --partial "emoji-test"
}
