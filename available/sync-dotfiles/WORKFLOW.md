---
name: sync-dotfiles
description: Dotfiles backup — commits dotfiles and Homebrew config to a git repo for safekeeping.
---

# Sync Dotfiles

Backup dotfiles and Homebrew config to a git repo.

## 1. Locate Dotfiles Repo

Check common locations:

```bash
ls -d ~/dotfiles ~/.dotfiles ~/Projects/dotfiles 2>/dev/null
```

If no repo exists, ask the user where to create one.

## 2. Sync Shell Config

Copy current shell configuration:

```bash
cp ~/.zshrc ~/dotfiles/zshrc 2>/dev/null
cp ~/.bashrc ~/dotfiles/bashrc 2>/dev/null
cp ~/.zprofile ~/dotfiles/zprofile 2>/dev/null
cp ~/.bash_profile ~/dotfiles/bash_profile 2>/dev/null
```

## 3. Sync Git Config

```bash
cp ~/.gitconfig ~/dotfiles/gitconfig 2>/dev/null
cp ~/.gitignore_global ~/dotfiles/gitignore_global 2>/dev/null
```

## 4. Sync Homebrew

Export Homebrew bundle:

```bash
brew bundle dump --file=~/dotfiles/Brewfile --force
```

## 5. Sync Other Configs

Copy other useful configs:

```bash
cp ~/.ssh/config ~/dotfiles/ssh_config 2>/dev/null
cp ~/.vimrc ~/dotfiles/vimrc 2>/dev/null
cp ~/.tmux.conf ~/dotfiles/tmux.conf 2>/dev/null
```

## 6. Commit and Push

```bash
cd ~/dotfiles
git add -A
git commit -m "dotfiles sync $(date +%Y-%m-%d)"
git push origin main
```

## After Running

Report:
- Files synced (new/modified/unchanged)
- Homebrew packages in Brewfile
- Whether push succeeded

## Notes

- Never sync files containing secrets (`.env`, API keys, tokens)
- Check `.gitignore` in the dotfiles repo excludes sensitive files
- Schedule via cron for weekly automatic backup
