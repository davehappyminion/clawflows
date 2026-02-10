---
name: check-security
description: Security hygiene check — verifies macOS updates, scans open ports, checks FileVault and Firewall status.
---

# Check Security

Security hygiene — updates, open ports, FileVault, Firewall status.

## 1. System Updates

Check for pending macOS updates:

```bash
softwareupdate -l 2>&1
```

Check Homebrew for outdated packages:

```bash
brew outdated 2>/dev/null
```

## 2. FileVault Status

Verify full-disk encryption:

```bash
fdesetup status
```

## 3. Firewall Status

Check macOS firewall:

```bash
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode
```

## 4. Open Ports

Scan for open listening ports:

```bash
lsof -iTCP -sTCP:LISTEN -P -n
```

Flag any unexpected services.

## 5. SSH Configuration

Check SSH settings:

```bash
cat ~/.ssh/config 2>/dev/null | head -20
ls -la ~/.ssh/ 2>/dev/null
```

Verify:
- Key-based auth is preferred
- No overly permissive permissions on key files

```bash
stat -f "%A %N" ~/.ssh/* 2>/dev/null
```

## 6. Browser Extensions

Check for installed browser extensions that might be risky:

```bash
ls ~/Library/Application\ Support/Google/Chrome/Default/Extensions/ 2>/dev/null
```

## After Running

Report:
- Pending system updates
- FileVault: enabled/disabled
- Firewall: enabled/disabled, stealth mode status
- Open ports and what's listening
- SSH configuration issues
- Overall security score (Good/Fair/Needs Attention)

## Notes

- Don't change any settings automatically — report and recommend
- Some open ports are normal (development servers, etc.) — note which are expected
- Flag critical issues prominently (FileVault off, Firewall off)
