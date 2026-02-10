#!/usr/bin/env bash
set -euo pipefail

# ── ClawFlows Installer ─────────────────────────────────────────────────────
# Works two ways:
#   1. curl | bash  (clones the repo)
#   2. bash install.sh  (already cloned)

REPO_URL="https://github.com/davehappyminion/clawflows.git"
INSTALL_DIR="$HOME/.clawflows"
BIN_DIR="$HOME/.local/bin"
BIN_TARGET="$BIN_DIR/clawflows"

info()  { printf '  \033[1;34m→\033[0m %s\n' "$1"; }
ok()    { printf '  \033[1;32m✓\033[0m %s\n' "$1"; }
warn()  { printf '  \033[1;33m!\033[0m %s\n' "$1"; }
err()   { printf '  \033[1;31m✗\033[0m %s\n' "$1" >&2; exit 1; }

echo ""
echo "  ClawFlows Installer"
echo "  ────────────────────"
echo ""

# ── 1. Clone or update ──────────────────────────────────────────────────────

command -v git >/dev/null 2>&1 || err "git is required but not installed"

if [ -d "$INSTALL_DIR/.git" ]; then
  info "Updating existing install at $INSTALL_DIR"
  git -C "$INSTALL_DIR" pull --ff-only --quiet 2>/dev/null || warn "Could not pull latest (offline or diverged)"
  ok "Updated"
else
  if [ -d "$INSTALL_DIR" ]; then
    err "$INSTALL_DIR already exists but is not a git repo. Remove it first."
  fi
  info "Cloning to $INSTALL_DIR"
  git clone --quiet "$REPO_URL" "$INSTALL_DIR"
  ok "Cloned"
fi

# ── 2. Symlink the CLI ──────────────────────────────────────────────────────

mkdir -p "$BIN_DIR"

if [ -L "$BIN_TARGET" ] || [ -e "$BIN_TARGET" ]; then
  rm -f "$BIN_TARGET"
fi

ln -s "$INSTALL_DIR/bin/clawflows" "$BIN_TARGET"
ok "Linked clawflows → $BIN_TARGET"

# ── 3. Ensure ~/.local/bin is in PATH ────────────────────────────────────────

path_ok=false
case ":${PATH}:" in
  *":$BIN_DIR:"*) path_ok=true ;;
esac

if ! $path_ok; then
  # Detect shell rc file
  rc_file=""
  case "${SHELL:-}" in
    */zsh)  rc_file="$HOME/.zshrc" ;;
    */bash) rc_file="$HOME/.bashrc" ;;
  esac

  if [ -n "$rc_file" ]; then
    # Only add if not already present in the file
    if ! grep -qF "$BIN_DIR" "$rc_file" 2>/dev/null; then
      printf '\n# Added by ClawFlows installer\nexport PATH="%s:$PATH"\n' "$BIN_DIR" >> "$rc_file"
      ok "Added $BIN_DIR to PATH in $rc_file"
      warn "Run 'source $rc_file' or open a new terminal to use clawflows"
    else
      ok "$BIN_DIR already referenced in $rc_file"
    fi
  else
    warn "$BIN_DIR is not in PATH — add it to your shell config manually"
  fi
else
  ok "$BIN_DIR is already in PATH"
fi

# ── 4. Initial sync ─────────────────────────────────────────────────────────

AGENTS_MD="${AGENTS_MD:-$HOME/.openclaw/workspace/AGENTS.md}"

if [ -f "$AGENTS_MD" ]; then
  info "Running initial sync with AGENTS.md"
  "$BIN_TARGET" sync
  ok "AGENTS.md updated"
else
  info "Skipping AGENTS.md sync (file not found at $AGENTS_MD)"
fi

# ── 5. Done ──────────────────────────────────────────────────────────────────

echo ""
echo "  Done! Get started:"
echo ""
echo "    clawflows list                     # see available workflows"
echo "    clawflows enable <workflow-name>   # enable one"
echo ""
