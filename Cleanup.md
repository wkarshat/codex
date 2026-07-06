# Cleanup Runbook

Updated: 2026-07-06

This runbook names directories, repositories, session records, build caches, and sensitive local files that can be cleaned up after the project review. The machine-readable companion is `~/Work/Codex/CleanupCandidates.tsv`.

Completed cleanup includes seven zero-token local Codex threads, 11 zero-diff cloud tasks, nine legacy `.coding-sess` directories, seven Rust build targets, all 27 `node_modules` trees under `~/Work/Code/MCP`, the stale lowercase `codess` clone, two broken Codex launcher installations, and the two OpenClaw worktrees' root dependency and distribution products. The OpenClaw code, OpenClaw documentation, and Setpack checkpoints are committed and pushed. The default filesystem method for remaining candidates is: verify, quarantine, wait, then remove.

## First Principles

1. Do not bulk-delete `~/Work/Spank/sOSS`, `~/Work/Claw/Emails`, `~/Work/Claw/Claws`, or `~/Work/ZK/ZKs` at their roots. Each contains exceptions.
2. Remove regenerable build output before deleting repositories. This recovers more than 10 GB with little risk.
3. A clean clone with a reachable remote commit is disposable. A dirty clone, untracked draft directory, or repository with no commits is not.
4. Archive session records only after durable conclusions have landed in repository documents or these reports.
5. Prefer macOS `trash` or a dated quarantine directory over `rm -rf`.

## Candidate Criteria

An item belongs in `CleanupCandidates.tsv` only when all of these are true:

1. The target is exact: one file, directory, repository, cache, launcher, session, or cloud-task URL rather than a broad discovery root.
2. It still exists or remains visible, and its current state has been checked.
3. Removal, quarantine, repair, or rescue has a concrete benefit.
4. The evidence supports the proposed action: regenerable output, no unique work, a verified superset elsewhere, a broken reference, or identified material to rescue.
5. Any prerequisite names a finite check. Open-ended research means the item is not yet an actionable cleanup candidate.

Apply the strongest justified disposition immediately:

- **Remove now:** regenerable output, empty/no-diff sessions, broken links, or exact duplicates with no unique state.
- **Quarantine then remove:** identity is established but a short integrity, ancestry, or superset check remains.
- **Rescue then remove:** unique work exists and its destination is known.
- **Exclude from the manifest:** broad roots, merely old material, active work, or anything requiring project-level investigation.

## P1 Regenerable Storage

The remaining exact opportunities below can be rebuilt from retained source, manifests, and lockfiles. On 2026-07-05, four listed Rust targets, all 27 `node_modules` trees below `~/Work/Code/MCP`, and the NemoClaw, sitit, and MCP servers root dependency trees were deleted, reclaiming about 14.20 GiB across those passes. On 2026-07-06, the OpenClaw work was preserved and both worktrees' root `node_modules` and `dist` directories were deleted, reclaiming about 4.1 GB more.

| Path | Approximate size | Prerequisite |
|---|---:|---|
| `~/Work/Claw/Setpacks/openclaw/apr20/openclaw/home/.codex/.tmp/plugins` | 26 MB | Pack inactive; plugin cache can be reacquired. |
| `~/Work/ZK/ZKs/insight/ecosystem/TENT/insight-ui-tent/node_modules` | 55 MB | Retain manifest and lockfile. |

Manual processing:

```bash
trash /Users/walter/Work/ZK/ZKs/insight/ecosystem/TENT/insight-ui-tent/node_modules
```

Do not delete `himalaya/rust-toolchain.toml`; that repository has a local tracked modification outside `target/`.

The two OpenClaw `.codess` directories are not in the remove-now group. They total about 75 MB. Their Cursor and Claude databases are byte-identical, but their Codex databases and ingest metadata are not. Confirm that canonical CodeSess has ingested the distinct records, then keep one store or regenerate both from the retained session sources.

## Claw Repository Cleanup

The `~/Work/Claw` root mixes authored projects, upstream reference clones, and runtime-pack state. Apply cleanup at repository or generated-directory granularity, never at the `Claw`, `Claws`, `Emails`, or `Setpacks` root.

### Rescue Before Cleanup

| Path | Required action |
|---|---|
| `~/Work/Claw/Claws/NemoClaw` | Copy local-only branch `nemow13` to a personal fork or private bundle; it contains the unique 638-line `NemoClaw.md` commit. |
| `~/Work/Claw/Emails/himalaya` | Decide whether the Rust 1.90 toolchain override is still required; preserve as a patch if so. |
| `~/Work/Claw/Setpacks/openclaw/today/openclaw/workspace/.git` | Decide whether private deleted email exports in history are an archive. Do not publish this repository. |

### Remove Or Normalize

- Remove `~/Work/Claw/Emails/neverest/.DS_Store`; the clone is otherwise clean.
- Treat `Setpacks/openclaw/ocrepo/openclaw/workspace/.git` as accidental until a filtered workspace-history design is chosen. It has no commits, and `.openclaw` runtime state must not be committed.
- Remove the temporary `openai/plugins` clone under the inactive `apr20` Codex cache when no pack command is using it.
- Remove clean upstream clones individually when their comparison task is complete. A useful retained shelf is `NemoClaw`, `nanoclaw`, `zeroclaw`, `hermes-agent`, `ClawWork`, `himalaya`, `neverest`, `gogcli`, `gmailsorter`, `inbox-zero`, `email-oauth2-proxy`, and `notmuch`/`isync`.
- Large clean reference clones that are cheap to reacquire include `ClawWork` (about 263 MB), `Kai` (about 167 MB), `openclaw-ai-sdk` (about 115 MB), and `inbox-zero` (about 129 MB).

## P1 Definite Duplicates

### Codess Duplicate Resolved

The stale `~/Work/Code/codess` clone was deleted on 2026-07-05 after verification that it had no unique commits. `~/Work/Code/CodeSess` remains the sole canonical local checkout of `fear-ai/codess`.

### Legacy Session Stores Removed

All nine non-archival `.coding-sess` directories listed in `cs.txt` were deleted on 2026-07-05. A new search found no remaining `.coding-sess` directory under `~/Work` outside `OLD` and `Save`. The newer WPages `.codess` store was not removed.

## P1 Session Cleanup

### Local Codex Threads

The seven confirmed zero-token local threads were deleted and are absent from `~/.codex/state_5.sqlite`. The historical IDs are retained only in `deleted_sessions.sh`, now a non-destructive verifier. For future cleanup, use the Homebrew CLI or the Codex App; do not edit the SQLite database directly.

### Codex Cloud Tasks

Eleven zero-diff tasks from the June 2025 `FedLoad Windows` cloud environment were archived on 2026-07-05 and no longer appear in `codex cloud list`. This included eight Fedload failures/operations/reviews and all three tasks that ran against quizC.

Two changed Fedload tasks remain active and on hold:

| Task | Changes | Required disposition |
|---|---:|---|
| `Analyze, design and plan solution` | 87 added lines in `ANA.md`, `DES.md`, and `PLAN.md` | Compare with current Fedload documents and decide whether the separate branch/task can be removed. |
| `Run tests/test_main.py` | 4 additions, 3 removals | Preserve or reapply the valid import-order patch before removing the task. |

The repositories below and these two changed cloud tasks are retained:

| Effort | Local root | Remote and branch to preserve |
|---|---|---|
| Fedload | `~/Work/Github/fedloadw` | `fear-ai/fedloadw`, branch `develop` (`7ca6725` verification pin) |
| quizC | No local clone found in the non-archival home tree after directory, Git-remote, Spotlight, and known-filename searches | `fear-ai/quizC`, branch `edit100224_1` (`8737fb3`), to be promoted to `main` before cloning |

The web interface labels the completed action **Archive Task**. The CLI now lists only the two held changed tasks.

## Reference-Pack Discovery Scopes

The following roots are mostly replaceable upstream material, but contain exceptions. They are discovery scopes, not cleanup candidates; only individually verified clones should enter the TSV.

| Root | Size | Keep-out rule |
|---|---:|---|
| `~/Work/Spank/sOSS` | 3.2 GB | Keep dirty `python-json-logger`, any locally cited fixtures, and currently used benchmarks. |
| `~/Work/Claw/Emails` | 421 MB | Keep local `Data` until classified and preserve modified `himalaya/rust-toolchain.toml`. |
| `~/Work/Claw/Claws` | 913 MB | Remove clean upstream clones individually, not the whole directory. |
| `~/Work/ZK/ZKs` | 2.2 GB | Keep `zerocurrencycoin` forks, recent Insight work, and dirty repos. |

For each Git clone, require all of the following before removal:

```bash
git -C /absolute/repo/path status --porcelain
git -C /absolute/repo/path remote -v
git -C /absolute/repo/path branch -vv
```

The first command must be empty. The current commit must be present on a remote branch or tag. Record the remote URL and commit SHA in the TSV or an archive note, then Trash the clone. Reclone later if needed.

## Codex Launchers

Launcher cleanup completed on 2026-07-05:

- the broken NVM-installed Codex `0.124.0` package and wrapper were uninstalled;
- the stale Homebrew `0.120.0` cask record and dangling link were removed;
- Homebrew Codex `0.142.5` was installed successfully.

Interactive shells now resolve `codex` to `/opt/homebrew/bin/codex`. The desktop app independently runs `/Applications/Codex.app/Contents/Resources/codex`; both report `codex-cli 0.142.5`.

There are 18 non-archival project `.claude/settings.local.json` files. Treat allows containing concrete paths, arguments, PIDs, test names, domains, or shell fragments as disposable approval history. Do not migrate or compare them. Review only bare capabilities and broad command-family entries such as `Bash`, `Read`, `Write`, `Edit`, `WebSearch`, and `Bash(find:*)`; intentional user-wide grants belong in `~/.claude/settings.json`.

`local.csv` contains the current extraction of 50 unique WebFetch hostnames, but those parameterized grants are out of scope for policy reconciliation. Once the broad entries have been checked, the local settings files can be discarded and future approvals allowed to rebuild narrowly as needed.

## Maintained Lists

| File | Current purpose |
|---|---|
| `CleanupCandidates.tsv` | Five exact pending items: three regenerable/incidental filesystem targets and two held cloud tasks. |
| `cs.txt` | Empty after all nine listed non-archival `.coding-sess` directories were deleted and absence was verified. |
| `local.csv` | Current 50 unique WebFetch hostnames extracted from non-archival local Claude settings. |
| `domains.cvs` | 44 sorted unique base domains derived from `local.csv`; requested filename spelling retained. |
| `deleted_sessions.sh` | Non-destructive verification that seven deleted local Codex thread IDs remain absent. |

## Using The TSV

Inspect candidates without acting:

```bash
column -t -s $'\t' /Users/walter/Work/Codex/CleanupCandidates.tsv | less -S
```

Filter immediate regenerable storage:

```bash
awk -F '\t' 'NR == 1 || $2 == "trash_regenerable"' /Users/walter/Work/Codex/CleanupCandidates.tsv
```

Filter items requiring rescue:

```bash
awk -F '\t' 'NR == 1 || $2 ~ /rescue|merge|bundle|review/' /Users/walter/Work/Codex/CleanupCandidates.tsv
```

Do not pipe the manifest directly into `rm`. Use it to drive an audit or quarantine script that checks existence, Git status, and prerequisites for each row.

## Suggested Order

1. Protect NemoClaw's local-only branch and decide whether the Himalaya Rust override remains necessary.
2. Remove the temporary plugin cache under inactive `apr20`.
3. Trash the remaining TENT dependency directory and incidental Neverest `.DS_Store`.
4. Resolve the two held changed Fedload cloud tasks after preserving any useful branch or patch content.
5. Check only broad capabilities and `Bash(command:*)` families in the 18 project-local Claude settings files, then discard the local files.
6. Remove clean reference clones individually as space or attention warrants.
