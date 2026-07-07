# Cleanup Runbook

Updated: 2026-07-07

This runbook covers the work that still matters: preserve the remaining original
Claw contributions, rotate exposed credentials, recover regenerable storage, and
remove replaceable reference clones only when their review value has ended. The
machine-readable action list is `~/Work/Codex/CleanupCandidates.tsv`.

`OLD` and `Save` directories remain outside the candidate manifest and detailed
path tables. Their storage is included only in parent totals. They require a
separate archival-retention decision.

## 1. Preservation Pass

The OpenClaw fixes, email research, Claw ecosystem research, adaptive-relevance
notes, Crusts notes, NemoClaw operations note, and Setpack work are already on
remote branches. The live Neverest skill and Gmail capture script remain to be
preserved.

### 1.1 Copy The Reusable Skill And Capture Tool

```bash
set -euo pipefail

DOCS=/Users/walter/Work/Claw/openclaw-docs
CLAW=/Users/walter/Work/Claw

mkdir -p "$DOCS/skills/neverest" "$DOCS/scripts/email"

cp \
  "$CLAW/Setpacks/openclaw/today/openclaw/workspace/skills/neverest/SKILL.md" \
  "$DOCS/skills/neverest/SKILL.md"

cp \
  "$CLAW/Emails/Data/gogdata/gog-gmail-capture.sh" \
  "$DOCS/scripts/email/gog-gmail-capture.sh"

chmod +x "$DOCS/scripts/email/gog-gmail-capture.sh"
```

The Neverest skill was previously accepted by `openclaw skills check`. Recheck
it from the preserved location if the current OpenClaw CLI supports an explicit
skill path. Run `bash -n` on the Gmail script; do not run a live mailbox capture
merely to validate syntax.

### 1.2 Unavailable Archive Sources

The former `dotopenclaw*.tgz` archives are absent. Their `Ideas.md`, `Molty.md`,
`AGENTS.md`, and memory-member rows have therefore been removed from the current
candidate manifest. Any later reconstruction from retained session history is a
research-recovery task, not a filesystem cleanup candidate.

### 1.3 Inspect And Commit Separately

```bash
cd /Users/walter/Work/Claw/openclaw-docs

rg -n '/Users/walter|AIza|sk-|token|secret|password|client_secret' \
  skills/neverest/SKILL.md \
  scripts/email/gog-gmail-capture.sh

bash -n scripts/email/gog-gmail-capture.sh
git diff --check

git add skills/neverest/SKILL.md
git commit -m 'docs: preserve Neverest skill'

git add scripts/email/gog-gmail-capture.sh
git commit -m 'tools: preserve Gmail capture script'

git push origin claw_emails
git status --short --branch
```

## 2. Credential And Private-State Boundary

`~/Work/Claw/docs/ai.openclaw.repo.plist` remains and contains an exposed gateway
token plus obsolete machine-specific launch paths. Rotate the token before
removing the plist. Gmail captures contain private message bodies and account
metadata and remain outside publication and cleanup scope. The two backup-code
files remain excluded by prior instruction.

## 3. Measured Storage State

The APFS Data volume is 460 GiB, with about 329 GiB used and 88 GiB available
(79% capacity). The sealed system volume reports about 17 GiB used. Totals below
overlap where a child is shown under its parent.

| Area | Measured size | Assessment |
|---|---:|---|
| `~/Work` | 91 GiB | Repositories, experiments, captures, and archives. |
| `~/Library` | 64 GiB | Dominated by application support and caches. |
| `/Applications` | 45 GiB | Large installed products; uninstall, do not delete internals. |
| `/private/var/folders` | 19 GiB | Includes 8.3 GiB of this user's temporary/cache data. |
| `/Library` | 6.7 GiB | Developer tools, updates, and shared application support. |
| `/opt/homebrew` | 4.1 GiB | 2.7 GiB Cellar and 0.53 GiB Caskroom. |

Codex lacks macOS privacy permission to measure `Desktop`, `Documents`,
`Downloads`, `Movies`, and Trash. Grant Codex Full Disk Access and rerun:

```bash
du -sh ~/Desktop ~/Documents ~/Downloads ~/Movies ~/.Trash
find ~/Downloads -mindepth 1 -maxdepth 1 -print0 \
  | xargs -0 du -sh | sort -h
```

### 3.1 User Library

| Area | Size | Important contents |
|---|---:|---|
| `~/Library/Application Support` | 46.2 GiB | Google 13.1, Claude 11.8, Cursor 8.6, Zero 8.4 GiB. |
| `~/Library/Caches` | 8.7 GiB | Remaining application and Homebrew caches. |
| `~/Library/Containers` | 9.9 GiB | Almost entirely Docker's VM data. |
| `~/Library/pnpm/store` | 68 KiB | Pruned shared pnpm store. |
| `~/Library/Logs` | 0.1 GiB | No major opportunity. |

Important state/cache distinctions:

- Claude's 10.0 GiB `rootfs.img` is a VM runtime, not conversation data; remove
  it only if Cowork/VM mode is unused and can be downloaded again.
- Cursor's `state.vscdb` is 4.4 GiB and its May backup is 3.4 GiB. These can
  contain chat/composer state. Preserve needed sessions and validate the current
  database before removing only the old backup.
- Chrome uses 4.0 GiB for an on-device optimization model and 7.3 GiB for the
  active Default profile. The model is regenerable; the profile is not a cache.
- Zero's 8.4 GiB is mostly blockchain blocks and chainstate. It is regenerable
  from the network but belongs to active ZK work and is not a cleanup candidate.
- Docker's 9.8 GiB VM must be inspected through Docker after starting Docker
  Desktop. Do not delete the VM image directly.

### 3.2 Language And Tool Caches

| Area | Current state |
|---|---|
| Go build cache | Cleaned; 8 KiB remains. |
| npm cache | Removed. |
| npm `_npx` installs | Removed. |
| pnpm store | Pruned from 6.7 GiB to 68 KiB. |
| pre-commit cache | Removed. |
| uv cache | Pruned; about 409 MiB of active/reusable cache remains. |

Installed NVM and Rust versions are not immediate candidates. Node 22 is needed
by retained projects and Node 25 is active. Rust 1.69, 1.82, 1.90, 1.92, and
stable all have matching project pins or current use.

## 4. Highest-Confidence Recovery

The language/tool cache pass is complete. The remaining high-confidence items
are application caches and completed Instruments traces. Close the associated
applications before running selected commands.

```bash
trash \
  /Users/walter/Library/Caches/Google \
  /Users/walter/Library/Caches/com.openai.codex \
  /Users/walter/Library/Caches/com.todesktop.230313mzl4w4u92.ShipIt \
  '/Users/walter/Library/Application Support/Claude/Cache'
```

Instruments left about 6.1 GiB of completed trace bundles dated July 2-4 in the
user temporary directory. Close Instruments and Xcode, inspect, then remove the
narrow trace class:

```bash
find "$TMPDIR" -maxdepth 1 -type d -name 'instruments*.ktrace' \
  -exec du -sh {} + | sort -h

find "$TMPDIR" -maxdepth 1 -type d -name 'instruments*.ktrace' \
  -mtime +1 -exec trash {} +
```

## 5. Work Tree

| Root | Size | Current interpretation |
|---|---:|---|
| `~/Work/ZK` | 59.7 GiB | Active performance and wallet work; report gross opportunities only. |
| `~/Work/Spank` | 17.7 GiB | 9.0 GiB HECpoc, 5.2 GiB logs, 3.2 GiB OSS shelf. |
| `~/Work/Claw` | 4.4 GiB | OpenClaw clone, reference shelves, and a 0.44 GiB Setpacks tree. |
| `~/Work/Code` | 4.1 GiB | Coding-tool and MCP reference clones dominate. |
| `~/Work/WP` | 3.5 GiB | Images and non-archival compressed copies dominate visible material. |
| `~/Work/Github` | 0.8 GiB | AVTrans dependencies are the largest remaining generated area. |
| `~/Work/Claude` | 0.9 GiB | Mostly model/harness reference clones and a small generated Rust target. |
| `~/Work/Notes` | 10 MiB | Small working notes. |
| `~/Work/Biz` | 9.7 MiB | Small business-material root. |
| `~/Work/AppCleaner.app` | 8 MiB | Local application copy. |
| `~/Work/AppCleaner_3.6.8.zip` | 4 MiB | Redundant installer candidate if application copy is retained. |
| `~/Work/Codex` | 0.4 MiB | Current project inventory and cleanup repository. |
| `~/Work/Edus` | 0.3 MiB | Small education root. |
| `~/Work/LLMHW` | 0.2 MiB | Preserved earlier LLM hardware research. |
| `~/Work/AppleVoice` | 0.1 MiB | Small Apple Voice research root. |
| `~/Work/Tok` | 56 KiB | Small token-related notes. |
| `~/Work/Gamzz` | 32 KiB | Small game root. |
| `~/Work/Sec` | 24 KiB | Small security root. |
| `~/Work/Repos.csv` | 16 KiB | Repository inventory. |
| `~/Work/gits` | 4 KiB | Nearly empty legacy root. |

Visible standalone compressed archive outside excluded archival directories:

| Archive | Size | Assessment |
|---|---:|---|
| `~/Work/ZK/artifacts/zerobootstrap.tgz` | 3.84 GiB | Active ZK input; report only during current work. |

### 5.1 Authored Projects With Generated Output

| Path | Size | Action |
|---|---:|---|
| `~/Work/Spank/HECpoc/target` | 4.48 GiB | Trash; ignored Cargo build output. |
| `~/Work/Spank/HECpoc/profile/results` | 4.51 GiB | Preserve benchmark summaries first, then Trash reproducible raw results. |
| `~/Work/Github/Transcript/avtranscript/node_modules` | 0.40 GiB | Trash; retain manifests and lockfiles for a future AVTrans restart. |
| `~/Work/Code/Misses/petri/petri-venv` | 0.49 GiB | Trash if the missed experiment is inactive; recreate from its environment spec. |
| `~/Work/Claude/EQ/Req/rust/target` | 0.21 GiB | Trash generated output; do not resume the separate Equihash work here. |

HECpoc has uncommitted authored Markdown (`Bench.md`, `File.md`, `More.md`). Do
not treat the repository as disposable. Only its ignored `target` and, after
summary review, `profile/results` are candidates.

### 5.2 Claw Pack And Clone Cleanup

All four `node_modules` directories below `Setpacks/openclaw`, including the
nested cached `npx` installation, were deleted on 2026-07-07. About 3.9 GiB was
recovered. Pack manifests, wrappers, configuration, and Setpack source remain.

Remove the linked documentation worktree before the primary OpenClaw clone:

```bash
cd /Users/walter/Work/Claw
git -C openclaw worktree remove /Users/walter/Work/Claw/openclaw-docs
trash /Users/walter/Work/Claw/openclaw
```

This is safe only after `claw_emails` and
`codex/preserve-openclaw-april-fixes` are verified on `fear-ai/openclaw`.

## 6. Reference Repositories

Reference shelves should be managed at repository granularity. Do not delete
tracked tests, fixtures, datasets, documentation, or examples from a retained
clone: doing so makes status noisy and produces a misleading partial checkout.
Use a sparse/shallow clone when only part of an upstream project is needed, or
delete the whole clean clone and reacquire it later.

### 6.1 Untracked Build Products In Retained Shelves

Only two material ignored build directories were found in `sOSS` and none over
1 MiB in `Claws`:

| Path | Size | Status |
|---|---:|---|
| `sOSS/otel/opentelemetry-collector-contrib/bin` | 0.53 GiB | Ignored generated Darwin binaries; safe to rebuild. |
| `sOSS/otel/opentelemetry-collector/bin` | 0.04 GiB | Ignored generated collector binary; safe to rebuild. |

### 6.2 Large Tracked Non-Core Sections

These are not standalone deletion candidates while their clones are retained:

- SecLists `Fuzzing` and `Payloads` are the product's reference data;
- Wazuh `tests` is about 0.06 GiB and remains tracked test source;
- ClawWork `livebench` is about 0.10 GiB of tracked benchmark material;
- Kai `fastlane` is about 0.09 GiB of tracked release assets and metadata;
- Splunk attack datasets, OpenTelemetry test/data trees, Apache documentation,
  and vendored libraries are tracked upstream content;
- large `.git` stores are history, not build output. If history is unnecessary,
  replace the whole clone with a shallow clone rather than editing `.git`.

Large verified clean upstream clones are listed as optional P3 rows in the TSV.
The largest are Next.js (2.47 GiB), Continue (0.89 GiB), OpenTelemetry Collector
Contrib (0.67 GiB including generated binaries), SecLists (0.45 GiB), Splunk
Security Content (0.35 GiB), OpenCode (0.33 GiB), and Wazuh (0.29 GiB).

Before deleting any clean clone:

```bash
git -C /absolute/repo status --porcelain
git -C /absolute/repo branch -vv
git -C /absolute/repo remote -v
```

The first command must be empty and the checked-out commit must be reachable on
the recorded remote branch or tag.

## 7. ZK Summary

`~/Work/ZK` is 59.7 GiB. Its currently active performance work contains large
bootstrap inputs, benchmark captures, datadirs, and debug logs. Only 0.05 GiB
was found in conventional `node_modules`/cache directories. The gross future
opportunities are duplicate bootstrap material, completed benchmark snapshots,
and rotated debug logs, but those are experimental evidence and are not placed
in the cleanup manifest during active work.

The one existing low-risk ZK candidate remains the 55 MiB TENT
`node_modules`. Archive-directory details remain intentionally excluded.

## 8. Applications And System Areas

Largest application bundles:

| Application area | Size | Decision |
|---|---:|---|
| Microsoft | 11.8 GiB | Keep if Office applications are used; uninstall components conventionally. |
| Splunk | 10.0 GiB | Major opportunity if local Splunk is no longer part of Spank testing. |
| Xcode | 4.8 GiB | Keep for active native/Rust development. |
| iMovie | 3.7 GiB | Optional uninstall if unused. |
| Google | 2.5 GiB | Review installed Google applications separately from Chrome profile data. |
| Docker Desktop | 2.3 GiB | Keep if container work continues; inspect its 9.8 GiB VM first. |
| Codex | 1.3 GiB | Current working application; keep. |
| VS Code | 1.2 GiB | Keep if used. |
| GarageBand | 1.1 GiB | Optional uninstall; shared instruments add about 1.8 GiB. |

### 8.1 Pearcleaner And AppCleaner Evaluation

Both local applications are authentic Developer ID-signed builds. They overlap
for normal application uninstall, but they should be used as review tools rather
than indiscriminate disk cleaners.

| Tool | Installed state | Strengths | Limits | Recommended role |
|---|---|---|---|---|
| Pearcleaner | 5.4.3, 14 MiB, Homebrew-managed in `/Applications`; current official release, signed by team `BK8443AXLU` | Associated-file search, orphan review, exports, Homebrew/PKG views, developer-environment inspection, services/plugins, and Trash-based undo | Requires Full Disk Access and a privileged helper for some work; broad feature set increases the need to review selections; official development is on indefinite hold | Primary inventory and uninstall-review tool while compatible; use its export/list views before deletion |
| AppCleaner | 3.6.8, 8 MiB, standalone copy under `~/Work`; current official release, signed by team `X85ZX835W9` | Small, simple drag/drop or application-list workflow for finding associated files | Narrowly focused; no equivalent repository, package-store, Docker, or developer-cache workflow | Keep as a second opinion for ordinary app removal; its same-version ZIP is redundant after validation |

Official sources:

- Pearcleaner: `https://github.com/alienator88/Pearcleaner` and
  `https://itsalin.com/appInfo/?id=pearcleaner`
- AppCleaner: `https://freemacsoft.net/appcleaner/`

Do not download Pearcleaner from similarly named third-party sites. Its official
repository explicitly identifies `itsalin.com` as the developer's only legitimate
website. The installed Homebrew cask points there and matches release 5.4.3.

Recommended evaluation sequence:

1. Keep both tools during the cleanup pass; their combined installed size is
   negligible compared with the areas under review.
2. Verify each bundle before use:

   ```bash
   codesign --verify --deep --strict --verbose=2 /Applications/Pearcleaner.app
   spctl --assess --type execute --verbose=2 /Applications/Pearcleaner.app

   codesign --verify --deep --strict --verbose=2 \
     /Users/walter/Work/AppCleaner.app
   spctl --assess --type execute --verbose=2 \
     /Users/walter/Work/AppCleaner.app
   ```

3. Use Pearcleaner to inventory an application and export or record its proposed
   associated files without deleting them.
4. Drop the same application into AppCleaner and compare the proposed files.
   Shared containers, documents, profiles, databases, credentials, plugins, and
   system extensions require manual judgment.
5. Prefer a vendor uninstaller for Splunk, Docker, VPN/network extensions,
   security tools, drivers, and applications with background services.
6. Move approved files to Trash and wait before emptying it. Do not combine app
   uninstall with Pearcleaner's Lipo, translation, package, or developer-cache
   cleanup in the same operation.

Neither tool replaces the task-specific commands in this runbook:

- use Git and `trash` for repositories and generated project output;
- use `go`, npm, pnpm, uv, and Homebrew for their own caches;
- use Docker commands for Docker's VM contents;
- preserve Cursor, Claude, Codex, Chrome, and Zero state according to the
  application-specific boundaries above;
- rotate credentials before removing files that contain them.

Docker Desktop is currently stopped. To evaluate its data safely:

```bash
open -a Docker
docker system df -v
docker builder prune
# Use docker system prune only after reviewing stopped containers and volumes.
```

`/Library/Updates` holds about 1.76 GiB in two Command Line Tools update payloads.
Let macOS Software Update or a completed reboot clear them; do not manually
remove system update directories. Three local OS update snapshots are also
system-managed.

## 9. Candidate Manifest

`CleanupCandidates.tsv` contains 48 current rows sorted by priority, action, and target. It includes
preservation, credential rotation, cache pruning, generated output, conditional
application cleanup, clean-clone removal, and the two held Fedload cloud tasks.

```bash
column -t -s $'\t' /Users/walter/Work/Codex/CleanupCandidates.tsv | less -S

awk -F '\t' 'NR == 1 || $1 == "P0"' \
  /Users/walter/Work/Codex/CleanupCandidates.tsv

awk -F '\t' 'NR == 1 || $2 == "trash_regenerable" || $2 == "prune_cache"' \
  /Users/walter/Work/Codex/CleanupCandidates.tsv
```

Do not pipe the TSV directly into `rm`. One row uses a deliberately narrow glob.
Execute the documented tool-specific command or
review the prerequisite first.

## 10. Execution Order

1. Preserve the Neverest skill and Gmail capture script; commit and push each.
2. Rotate the exposed gateway token and remove the obsolete launch plist.
3. Clear remaining application caches and stale Instruments traces for the fastest
   low-risk recovery.
4. Remove ignored HECpoc build output and review benchmark results.
5. Remove the OpenClaw linked worktree and primary clone if local checkouts are
   no longer wanted.
6. Inspect Docker, Cursor backup state, Chrome's downloaded model, and optional
   applications before conditional cleanup.
7. Remove whole clean reference clones only when their review role has ended.
8. Re-measure the Data volume and the newly accessible protected home folders.
