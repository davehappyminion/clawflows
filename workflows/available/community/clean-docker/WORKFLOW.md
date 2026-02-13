---
name: clean-docker
emoji: 🐳
description: Docker cleanup — prunes dangling images, stopped containers, unused volumes and networks. Shows disk savings. Always asks before deleting.
author: @davehappyminion
---

# Clean Docker

Audit the local Docker environment for waste: dangling images, stopped containers, unused volumes, and orphaned networks. Show what can be cleaned and how much space it would reclaim. ASK the user before deleting anything.

## 1. Verify Docker Is Running

```
docker info > /dev/null 2>&1
```

- If Docker is not running or not installed, stop immediately and report the issue.
- Note the Docker version and storage driver for the report.

## 2. Capture Disk Usage (Before)

```
docker system df
docker system df -v
```

- Record total disk usage: images, containers, local volumes, build cache.
- Save these numbers for the before/after comparison.

## 3. Inventory Stopped Containers

```
docker ps -a --filter "status=exited" --filter "status=dead" --filter "status=created" \
  --format "{{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Size}}"
```

- List every stopped container with its name, image, exit time, and size.
- Flag containers that exited more than 7 days ago as "safe to remove."
- Flag containers that exited within 7 days as "recent — review before removing."

## 4. Inventory Dangling Images

```
docker images --filter "dangling=true" --format "{{.ID}}\t{{.Repository}}\t{{.Tag}}\t{{.Size}}\t{{.CreatedSince}}"
```

- List all dangling (untagged) images with their size and age.
- Also check for images not used by any container:

```
docker images --format "{{.ID}}" | while read id; do
  if [ -z "$(docker ps -a --filter ancestor=$id -q)" ]; then echo "$id unused"; fi
done
```

## 5. Inventory Unused Volumes

```
docker volume ls --filter "dangling=true" --format "{{.Name}}\t{{.Driver}}"
```

- List all dangling volumes (not attached to any container).
- Warn that volume data is permanently lost once deleted. This is the most destructive cleanup action.

## 6. Inventory Unused Networks

```
docker network ls --filter "type=custom" --format "{{.ID}}\t{{.Name}}\t{{.Driver}}"
```

- Exclude default networks (bridge, host, none).
- Check if each custom network has any connected containers.
- List orphaned networks that can be safely removed.

## 7. Check Build Cache

```
docker builder prune --dry-run
```

- Report total build cache size.
- Note how much would be freed by pruning.

## 8. Present Findings and ASK for Approval

```
## Docker Cleanup Report — <date>

### Disk Usage (Before)
| Category    | Size   | Reclaimable |
|-------------|--------|-------------|
| Images      | X GB   | Y GB        |
| Containers  | X MB   | Y MB        |
| Volumes     | X GB   | Y GB        |
| Build Cache | X GB   | Y GB        |
| **Total**   | X GB   | Y GB        |

### Stopped Containers (X)
| Name | Image | Stopped | Size | Safe? |
|------|-------|---------|------|-------|
| ...  | ...   | 14d ago | X MB | Yes   |

### Dangling Images (X)
| ID (short) | Size | Age |
|------------|------|-----|
| abc123     | X MB | 30d |

### Unused Volumes (X) -- DATA LOSS WARNING
| Name | Driver |
|------|--------|
| ...  | local  |

### Unused Networks (X)
| Name | Driver |
|------|--------|
| ...  | bridge |

### Build Cache
Reclaimable: X GB
```

**STOP HERE.** Present this report and ask the user which categories to clean:
- "Remove stopped containers? (y/n)"
- "Remove dangling images? (y/n)"
- "Remove unused volumes? (y/n) -- WARNING: data loss"
- "Remove unused networks? (y/n)"
- "Prune build cache? (y/n)"

## 9. Execute Cleanup (Only After Approval)

Run only the commands the user approved:

- Containers: `docker container prune -f`
- Images: `docker image prune -f`
- Volumes: `docker volume prune -f`
- Networks: `docker network prune -f`
- Build cache: `docker builder prune -f`

After cleanup, run `docker system df` again and report the after numbers.

```
### Disk Usage (After)
| Category    | Before | After | Freed  |
|-------------|--------|-------|--------|
| Images      | X GB   | Y GB  | Z GB   |
| Containers  | X MB   | Y MB  | Z MB   |
| Volumes     | X GB   | Y GB  | Z GB   |
| Build Cache | X GB   | Y GB  | Z GB   |
| **Total**   | X GB   | Y GB  | **Z GB freed** |
```

## Notes

- **Safety first.** Never delete anything without explicit user approval. This workflow is interactive.
- The `-f` (force) flag is only used after the user confirms. Never pass `-f` preemptively.
- `docker system prune -a` is intentionally NOT used because it is too aggressive (removes all unused images, not just dangling ones).
- Volumes are the most dangerous to prune. Database data, application state, and configuration can live in volumes. Always warn clearly.
- If Docker Desktop is running, some resources may be managed by Desktop's own garbage collection. Note this in the report if applicable.
- On macOS, Docker runs in a VM. Disk space freed inside the VM may not immediately reflect on the host. Mention this if relevant.
