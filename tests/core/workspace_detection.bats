#!/usr/bin/env bats
# Tests for OpenClaw workspace detection
# Ensures AGENTS_MD and BACKUP_DIR respect custom workspace from openclaw.json

load '../test_helper'

setup() {
    setup_test_environment

    # Create a fake HOME for workspace detection tests
    export FAKE_HOME="${TEST_TMPDIR}/fakehome"
    mkdir -p "${FAKE_HOME}/.openclaw"
}

teardown() {
    teardown_test_environment
}

# ============================================================================
# Default Workspace (no config)
# ============================================================================

@test "workspace detection: falls back to default when no openclaw.json" {
    # Remove the .openclaw dir so there's no config
    rm -rf "${FAKE_HOME}/.openclaw"

    run env HOME="${FAKE_HOME}" AGENTS_MD="" bash "${REAL_CLI}" sync-agent

    assert_success
    assert_output --partial "AGENTS.md not found at ${FAKE_HOME}/.openclaw/workspace/AGENTS.md"
}

# ============================================================================
# Custom Workspace from openclaw.json
# ============================================================================

@test "workspace detection: reads custom workspace from openclaw.json" {
    local custom_ws="${TEST_TMPDIR}/my-custom-workspace"

    cat > "${FAKE_HOME}/.openclaw/openclaw.json" << EOF
{
  "agents": {
    "defaults": {
      "workspace": "${custom_ws}"
    }
  }
}
EOF

    run env HOME="${FAKE_HOME}" AGENTS_MD="" bash "${REAL_CLI}" sync-agent

    assert_success
    assert_output --partial "AGENTS.md not found at ${custom_ws}/AGENTS.md"
}

@test "workspace detection: sync writes to custom workspace AGENTS.md" {
    local custom_ws="${TEST_TMPDIR}/my-custom-workspace"
    mkdir -p "${custom_ws}"

    cat > "${FAKE_HOME}/.openclaw/openclaw.json" << EOF
{
  "agents": {
    "defaults": {
      "workspace": "${custom_ws}"
    }
  }
}
EOF

    # Create AGENTS.md at the custom workspace
    touch "${custom_ws}/AGENTS.md"

    run env HOME="${FAKE_HOME}" AGENTS_MD="" bash "${REAL_CLI}" sync-agent

    assert_success
    assert_output --partial "synced AGENTS.md"

    # Verify it wrote the clawflows block to the custom location
    run cat "${custom_ws}/AGENTS.md"
    assert_output --partial "clawflows:start"
}

# ============================================================================
# Edge Cases
# ============================================================================

@test "workspace detection: openclaw.json without workspace key falls back to default" {
    cat > "${FAKE_HOME}/.openclaw/openclaw.json" << 'EOF'
{
  "auth": {
    "profiles": {}
  }
}
EOF

    run env HOME="${FAKE_HOME}" AGENTS_MD="" bash "${REAL_CLI}" sync-agent

    assert_success
    assert_output --partial "AGENTS.md not found at ${FAKE_HOME}/.openclaw/workspace/AGENTS.md"
}

@test "workspace detection: empty openclaw.json falls back to default" {
    echo "" > "${FAKE_HOME}/.openclaw/openclaw.json"

    run env HOME="${FAKE_HOME}" AGENTS_MD="" bash "${REAL_CLI}" sync-agent

    assert_success
    assert_output --partial "AGENTS.md not found at ${FAKE_HOME}/.openclaw/workspace/AGENTS.md"
}

@test "workspace detection: AGENTS_MD env var overrides openclaw.json" {
    local custom_ws="${TEST_TMPDIR}/my-custom-workspace"
    local explicit_agents="${TEST_TMPDIR}/explicit/AGENTS.md"

    cat > "${FAKE_HOME}/.openclaw/openclaw.json" << EOF
{
  "agents": {
    "defaults": {
      "workspace": "${custom_ws}"
    }
  }
}
EOF

    # Explicit AGENTS_MD should override workspace detection
    run env HOME="${FAKE_HOME}" AGENTS_MD="${explicit_agents}" bash "${REAL_CLI}" sync-agent

    assert_success
    assert_output --partial "AGENTS.md not found at ${explicit_agents}"
    refute_output --partial "${custom_ws}"
}

@test "workspace detection: handles realistic openclaw.json with many keys" {
    local custom_ws="${TEST_TMPDIR}/clawd"

    cat > "${FAKE_HOME}/.openclaw/openclaw.json" << EOF
{
  "wizard": {
    "lastRunAt": "2026-02-17T00:19:36.139Z",
    "lastRunVersion": "2026.2.15"
  },
  "auth": {
    "profiles": {
      "anthropic:default": {
        "provider": "anthropic",
        "mode": "token"
      }
    }
  },
  "agents": {
    "defaults": {
      "workspace": "${custom_ws}",
      "compaction": {
        "mode": "safeguard"
      },
      "maxConcurrent": 4
    }
  },
  "gateway": {
    "port": 18789,
    "mode": "local"
  }
}
EOF

    run env HOME="${FAKE_HOME}" AGENTS_MD="" bash "${REAL_CLI}" sync-agent

    assert_success
    assert_output --partial "AGENTS.md not found at ${custom_ws}/AGENTS.md"
}
