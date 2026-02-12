#!/usr/bin/env bash
set -euo pipefail

# ── ClawFlows Installer ─────────────────────────────────────────────────────
# Works two ways:
#   1. curl | bash  (clones the repo)
#   2. bash install.sh  (already cloned)

REPO_URL="https://github.com/davehappyminion/clawflows.git"
INSTALL_DIR="$HOME/.openclaw/workspace/clawflows"
BIN_DIR="$HOME/.local/bin"
BIN_TARGET="$BIN_DIR/clawflows"

# ── Flags ─────────────────────────────────────────────────────────────────
NO_ESSENTIALS=false
for arg in "$@"; do
  case "$arg" in
    --no-essentials) NO_ESSENTIALS=true ;;
  esac
done

# ── Colors ─────────────────────────────────────────────────────────────────
BOLD='\033[1m'
DIM='\033[2m'
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RESET='\033[0m'

info()  { printf "  ${BLUE}→${RESET} %s\n" "$1"; }
ok()    { printf "  ${GREEN}✓${RESET} %s\n" "$1"; }
warn()  { printf "  ${YELLOW}!${RESET} %s\n" "$1"; }
err()   { printf "  ${RED}✗${RESET} %s\n" "$1" >&2; exit 1; }

# ── Header ─────────────────────────────────────────────────────────────────

printf "${CYAN}"
cat << 'LOGO'

  ____ _                 _____ _
 / ___| | __ ___      __| ___| | _____      _____
| |   | |/ _` \ \ /\ / /| |_  | |/ _ \ \ /\ / / __|
| |___| | (_| |\ V  V / |  _| | | (_) \ V  V /\__ \
 \____|_|\__,_| \_/\_/  |_|   |_|\___/ \_/\_/ |___/

LOGO
printf "${RESET}"
printf "  ${BOLD}⚡️ Superpowers for your OpenClaw agent${RESET}\n"
printf "  ${DIM}github.com/davehappyminion/clawflows${RESET}\n"
echo ""

# ── 1. Clone or update ──────────────────────────────────────────────────────

command -v git >/dev/null 2>&1 || err "git is required but not installed"

if [ -d "$INSTALL_DIR/.git" ]; then
  info "Pulling latest workflows..."
  git -C "$INSTALL_DIR" pull --ff-only --quiet 2>/dev/null || warn "Could not pull latest (offline or diverged)"
  ok "Updated"
else
  if [ -d "$INSTALL_DIR" ]; then
    err "$INSTALL_DIR already exists but is not a git repo. Remove it first."
  fi
  info "Downloading workflows..."
  git clone --quiet "$REPO_URL" "$INSTALL_DIR"
  ok "Cloned to $INSTALL_DIR"
fi

# ── 2. Create directories ───────────────────────────────────────────────────

mkdir -p "$INSTALL_DIR/workflows/enabled"
mkdir -p "$INSTALL_DIR/system/runs"

# ── 3. Symlink the CLI ──────────────────────────────────────────────────────

mkdir -p "$BIN_DIR"

if [ -L "$BIN_TARGET" ] || [ -e "$BIN_TARGET" ]; then
  rm -f "$BIN_TARGET"
fi

ln -s "$INSTALL_DIR/system/cli/clawflows" "$BIN_TARGET"
ok "Installed clawflows CLI"

# ── 4. Ensure ~/.local/bin is in PATH ────────────────────────────────────────

path_ok=false
case ":${PATH}:" in
  *":$BIN_DIR:"*) path_ok=true ;;
esac

if ! $path_ok; then
  rc_file=""
  case "${SHELL:-}" in
    */zsh)  rc_file="$HOME/.zshrc" ;;
    */bash) rc_file="$HOME/.bashrc" ;;
  esac

  if [ -n "$rc_file" ]; then
    if ! grep -qF "$BIN_DIR" "$rc_file" 2>/dev/null; then
      printf '\n# Added by ClawFlows installer\nexport PATH="%s:$PATH"\n' "$BIN_DIR" >> "$rc_file"
      ok "Added to PATH in $rc_file"
      warn "Open a new terminal or run: source $rc_file"
    else
      ok "PATH already configured"
    fi
  else
    warn "Add $BIN_DIR to your PATH manually"
  fi
else
  ok "PATH already configured"
fi

# ── 5. Set up scheduler cron ─────────────────────────────────────────────────

if command -v openclaw >/dev/null 2>&1; then
  if openclaw cron list </dev/null 2>/dev/null | grep -q "clawflows-scheduler"; then
    ok "Scheduler already running"
  else
    info "Setting up auto-scheduler..."
    openclaw cron add \
      --name "clawflows-scheduler" \
      --cron "*/15 * * * *" \
      --session isolated \
      --message "Read and execute $INSTALL_DIR/system/scheduler.md" \
      --no-deliver </dev/null >/dev/null 2>&1
    ok "Scheduler running (checks every 15 min)"
  fi
else
  warn "openclaw not found — skipping scheduler"
fi

# ── 6. Initial sync ─────────────────────────────────────────────────────────

AGENTS_MD="${AGENTS_MD:-$HOME/.openclaw/workspace/AGENTS.md}"

if [ -f "$AGENTS_MD" ]; then
  "$BIN_TARGET" sync >/dev/null 2>&1
  ok "Agent synced"
else
  info "No AGENTS.md found — skipping sync"
fi

# ── 7. Count workflows ──────────────────────────────────────────────────────

workflow_count=0
if [ -d "$INSTALL_DIR/workflows/available" ]; then
  workflow_count=$(ls -d "$INSTALL_DIR/workflows/available"/*/ 2>/dev/null | wc -l | tr -d ' ')
fi

# ── 8. Enable essentials (skip when agent handles it via --no-essentials) ─────

if ! $NO_ESSENTIALS; then
  ESSENTIALS=(send-morning-inspiration send-morning-briefing process-email check-calendar)

  echo ""
  printf "  ${BOLD}The Essentials Pack${RESET}\n"
  echo ""
  printf "  We strongly recommend enabling these 4 workflows to start:\n"
  echo ""
  printf "    ✨ ${BOLD}send-morning-inspiration${RESET}   Uplifting quote to start your day\n"
  printf "    ☀️  ${BOLD}send-morning-briefing${RESET}     Weather, calendar, priorities at 7am\n"
  printf "    📧 ${BOLD}process-email${RESET}              Inbox triage — unsubscribe junk, surface important\n"
  printf "    📅 ${BOLD}check-calendar${RESET}             48-hour radar with conflict detection\n"
  echo ""
  printf "  ${DIM}You can disable any of these anytime with: clawflows disable <name>${RESET}\n"
  echo ""
  printf "  Enable the essentials? [Y/n] "
  read -r essentials_confirm </dev/tty 2>/dev/null || essentials_confirm="y"

  if [ "$essentials_confirm" != "n" ] && [ "$essentials_confirm" != "N" ]; then
    for wf in "${ESSENTIALS[@]}"; do
      if [ -d "$INSTALL_DIR/workflows/available/$wf" ]; then
        "$BIN_TARGET" enable "$wf" >/dev/null 2>/dev/null
      fi
    done
    ok "Essentials enabled"
  else
    info "Skipped — you can enable them later with clawflows enable <name>"
  fi
fi

# ── 9. Done ──────────────────────────────────────────────────────────────────

echo ""
printf "  ${GREEN}${BOLD}Done!${RESET} ${BOLD}$workflow_count workflows${RESET} available.\n"
echo ""
printf "  ${BOLD}Next steps:${RESET}\n"
echo ""
printf "    ${CYAN}clawflows list${RESET}                     Browse all workflows\n"
printf "    ${CYAN}clawflows enable ${DIM}<name>${RESET}          Turn one on\n"
printf "    ${CYAN}clawflows update${RESET}                   Pull latest workflows\n"
echo ""
