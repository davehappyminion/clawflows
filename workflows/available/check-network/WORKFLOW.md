---
name: check-network
emoji: "\U0001F310"
description: Home network scan — discovers connected devices, checks internet speed, verifies DNS and VPN status, and flags unknown or new devices.
schedule: "8am"
---

# Check Network

Scan the home network for connected devices, test internet connectivity and speed, verify DNS resolution and VPN status, and flag any unknown or newly appeared devices.

## 1. Identify Local Network

Determine the active network interface and local subnet:

```
route -n get default 2>/dev/null | grep interface
ipconfig getifaddr en0
ifconfig en0 | grep "inet "
```

- Record the local IP, subnet mask, gateway IP, and interface name.
- Detect whether connected via Wi-Fi or Ethernet.
- Note the SSID if on Wi-Fi: `networksetup -getairportnetwork en0` or `/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep ' SSID'`.

## 2. Discover Connected Devices

Scan the local network for active hosts:

```
arp -a
```

If `nmap` is installed, run a more thorough scan:

```
nmap -sn 192.168.X.0/24 --host-timeout 5s
```

For each device found, record:
- IP address
- MAC address
- Hostname (if resolvable via DNS or mDNS)
- Manufacturer (derive from MAC OUI prefix if possible)

## 3. Identify Known vs Unknown Devices

Compare discovered devices against the user's known device list. Check:
- `~/.openclaw/workspace/TOOLS.md` for documented devices with IPs or MACs.
- Any previous run's device inventory if stored in `~/.openclaw/data/network/`.

Classify each device:
- **Known** — MAC or IP matches a documented device.
- **New** — Device not seen in previous scans. Flag for review.
- **Unknown** — No match in known device list and not previously seen. Highlight prominently.

## 4. Test Internet Connectivity

Run basic connectivity checks:

```
ping -c 3 1.1.1.1
ping -c 3 8.8.8.8
ping -c 3 google.com
```

- Record latency (min/avg/max) and packet loss for each target.
- If `ping` to IP works but `ping` to hostname fails, flag a DNS issue.

## 5. Test Internet Speed

Use `speedtest-cli` or `networkQuality` (built into macOS):

```
networkQuality -v
```

Or if `speedtest-cli` is installed:

```
speedtest-cli --json
```

- Record download speed, upload speed, and latency.
- Compare against previous results if available. Flag significant degradation (>30% drop).

## 6. Verify DNS Resolution

Test DNS resolution across multiple resolvers:

```
dig google.com @192.168.X.1    # router/local DNS
dig google.com @1.1.1.1        # Cloudflare
dig google.com @8.8.8.8        # Google
```

- Compare response times.
- Check if local DNS returns the same IPs as public DNS (to detect DNS hijacking or filtering).
- Report which DNS servers are configured: `scutil --dns | grep nameserver`.

## 7. Check VPN Status

Detect if a VPN connection is active:

```
ifconfig | grep -E "^(utun|tun|ppp)"
scutil --nc list
```

- Report whether a VPN is connected, and if so, which one.
- If a VPN is expected but not connected, flag it.
- Test for DNS leaks: compare `dig +short myip.opendns.com @resolver1.opendns.com` with the expected VPN exit IP.

## 8. Check Gateway and Router

```
ping -c 3 $(route -n get default | grep gateway | awk '{print $2}')
```

- Confirm the gateway is reachable and responsive.
- Record gateway latency.
- If latency to the gateway is high (>10ms on LAN), flag potential local network issues.

## 9. Present Findings

```
## Network Report — <date>

### Connection
| Property | Value |
|----------|-------|
| Interface | en0 (Wi-Fi) |
| SSID | MyNetwork |
| Local IP | 192.168.1.X |
| Gateway | 192.168.1.1 |
| DNS Servers | 1.1.1.1, 8.8.8.8 |
| VPN | Connected (WireGuard) / Not connected |

### Internet Speed
| Metric | Value | vs Last Run |
|--------|-------|-------------|
| Download | XX Mbps | +/- X% |
| Upload | XX Mbps | +/- X% |
| Latency | XX ms | +/- X ms |

### Connectivity
| Target | Latency (avg) | Packet Loss |
|--------|---------------|-------------|
| 1.1.1.1 | X ms | 0% |
| 8.8.8.8 | X ms | 0% |
| google.com | X ms | 0% |
| Gateway | X ms | 0% |

### Connected Devices (X total)
| IP | Hostname | MAC | Manufacturer | Status |
|----|----------|-----|-------------|--------|
| .1 | router | AA:BB:... | Ubiquiti | Known |
| .42 | macbook | CC:DD:... | Apple | Known |
| .99 | — | EE:FF:... | Unknown | **NEW** |

### Alerts
- NEW DEVICE: 192.168.1.99 (MAC: EE:FF:...) — not in known device list
- DNS latency to local resolver is 3x slower than Cloudflare
- VPN not connected (expected: always on)

**Summary:** X devices on network (Y known, Z new/unknown).
Internet: XX/XX Mbps down/up. DNS: healthy. VPN: status.
```

## Notes

- This workflow is read-only. It does not modify network settings, firewall rules, or device configurations.
- `nmap` provides the most complete device scan but may not be installed. Fall back to `arp -a` which shows recently-active devices only.
- MAC address manufacturer lookup uses the OUI prefix (first 3 octets). A local OUI database or the `maclookup` API can resolve these, but do not make external API calls without noting it.
- The "known devices" list is only as good as what the user has documented. Suggest updating TOOLS.md when new legitimate devices are identified.
- On macOS, `networkQuality` is built in (macOS 12+) and provides a reliable speed test without third-party tools.
- VPN detection covers utun (WireGuard, OpenVPN) and ppp interfaces. Some VPN clients may use different interface types.
- If the scan finds more than 30 devices, the network may be shared or have a flat topology. Note this and suggest network segmentation if appropriate.
