# Context, Prompt, and Memory Systems

Updated: 2026-07-05

Related cleanup artifacts: `~/Work/Codex/Cleanup.md` and `~/Work/Codex/CleanupCandidates.tsv` translate this review into named, prerequisite-aware cleanup candidates. They intentionally separate immediate regenerable storage, session archival, quarantine, and rescue-before-removal work.

This review traces the systems actually used to carry instructions, project context, prompt methods, and working state across sessions. It focuses on authored and repeatedly used work, not instruction files inherited from third-party repositories.

## Bottom Line

The work converged on four different jobs that should remain separate:

1. Stable agent behavior: `AGENTS.md` and, for Claude-specific behavior, `CLAUDE.md`.
2. Durable project truth: `README.md`, technical documents, decisions, and checked-in status.
3. Volatile transition state: a small memory index and bounded fact files, or a short session handoff.
4. Historical evidence: raw session logs, timestamped snapshots, Codess databases, and the Misses corpus.

The strongest practical deployment was Spank during March-April 2026. It combined a committed `CLAUDE.md`, an explicit reading order and authoritative-document map, a protected memory bootstrap, transition snapshots, and later Claude's indexed fact-file memory. Zero/Insight then used the indexed form more cleanly for operational facts and a resume agenda. `CContext` is the strongest formal analysis of the machinery. `CodeSess` is the strongest implementation for preserving raw session history. `Misses/Falla/pDSL` is the strongest evidence-driven attempt to turn repeated interaction failures into better prompts and agent rules.

No single project finished the whole system. The reusable pieces are distributed across those four efforts.

Permissions and harness configuration form a separate control plane around all four jobs. Behavioral instructions express intent; sandbox, approval, allow/deny, hooks, and trusted-project settings enforce capabilities. The local deployments repeatedly treated prose rules as if they narrowed broad runtime grants. They do not.

## Developer Outlook And Working Preferences

The prompt and instruction corpus expresses a consistent approach to technical work. These are semantic preferences, not a proposal to place all of their text in one startup prompt.

1. **Establish scope and purpose first.** Answer the stated problem at its given boundary. Surface a materially useful adjacent issue briefly, but do not silently turn it into additional work. Explicitly distinguish discussion, recommendation, authorization, and reports of actions already taken.
2. **Prefer evidence to plausible completion.** Trace executable paths, inspect integration points, test negative cases, and reconcile claims with observed behavior. Existing structure, passing happy-path tests, or a polished document is not enough evidence that a system works. State unresolved gaps and qualify completion claims.
3. **Explain decisions, not ceremony.** Technical analysis should give exact values, paths, tradeoffs, and the reason for a choice. Direct factual or status questions should receive direct answers. Avoid praise, filler, repeated summaries, generic suggestions, schedule estimates, and status words standing in for substantive results.
4. **Organize information by responsibility.** Separate conceptual design, implementation procedure, current status, technical contracts, behavioral policy, volatile handoff state, and historical evidence. Give each fact one authoritative home. Present material step by step, increasing from orientation and decisions to practical procedure and exact references.
5. **Maintain present-state documentation.** Describe what is true, what is intended, what remains open, and what should happen next. Preserve history only when it is needed to understand a live constraint or decision. Use cross-references only when the target contains necessary material that should not be repeated locally.
6. **Preserve information without preserving clutter.** Do not silently delete findings, requirements, or user-authored detail during an edit. Consolidation may move or replace material once its surviving meaning has been checked. Superseded explanations, duplicate rules, stale counts, and session chronology do not belong in current-state documents.
7. **Keep consequential changes deliberate and reversible.** Prefer narrow commands and recoverable operations. Destructive file actions, history changes, remote writes, persistent environment changes, and new standing artifacts require clear ownership and authorization. A plan selection or past-tense report does not imply approval for its side effects.
8. **Treat prompting and configuration as testable engineering.** Promote rules from recurring evidence, keep proposals distinct from active policy, and verify effective loading, permissions, hooks, and skill behavior. Prose guidance, runtime enforcement, project truth, and session continuity are separate mechanisms.

Two apparent tensions need explicit handling. Initiative means identifying relevant risks and improvements, not expanding the task without consent. Preservation means retaining unique meaning, not retaining every obsolete paragraph or duplicate copy. These boundaries should govern future consolidation of the existing material.

## Current Evidence Base

| System | Current value | Status and future use |
|---|---|---|
| Repository instruction routers | WPages, HardUW, MultiWP, Must, Zero, and zerowallet contain authored `AGENTS.md` files. WPages uses three lines to identify overview, status, and tests; HardUW separates conceptual, procedural, and prompting material. | Best low-cost project pattern. Retain compact routers and remove duplicated global behavior from project files. |
| Prompt and stage libraries | `~/Work/WP/multiwp/python0/prompts/Prompts.md` and `PromptStage.md` cover adversarial review, evidence, completeness, interfaces, testing, release, and operations. `HardenPrompt.md` addresses documentation restructuring. | Strong method library, but too large for startup context. Reuse through task-specific skills or direct reading. |
| Spank instruction and memory stack | `spank-py/CLAUDE.md`, bounded memory files, and snapshots demonstrate authority maps, transition handling, and recovery checkpoints. | Strongest integrated deployment, currently drifted. Reconcile the active instruction file, memory index, and disabled hook. |
| CContext | `~/Work/Claude/CContext` models context authority, prompt assembly, compaction, configuration, and session analysis. | Strongest reference design, incompletely packaged. Review and commit only reusable examples and scripts, with a working README. |
| Zero/Insight managed memory | The local memory index contains bounded operational facts, documentation rules, and one ordered handoff. | Best current memory shape, but not portable. Promote durable facts and rules into the repositories. |
| Codess | `~/Work/Code/CodeSess` ingests and queries session records; working stores exist under WPages and HardUW. | Preserve as historical ledger and add current Codex-app ingestion plus a context-manifest/status view. |
| Misses, Falla, PromptProps, and pDSL | `~/Work/Code/Misses` separates session evidence, intent classification, candidate rules, and active instructions. | Keep as the rule laboratory. Promote only recurring, high-cost findings; do not inject the full taxonomy or a universal prompt DSL. |

## Strong Deployments

### Spank Instruction And Memory Stack

Spank assembled the most complete context system found in the review.

`spank-py/CLAUDE.md` was revised across at least eight commits from February through April 2026. Its active responsibilities include:

- protected documents;
- response voice and structure;
- destructive-operation and Git gates;
- documentation maintenance;
- security and operational rules;
- a pointer to `README.md` for project orientation.

The earlier combined `MEMORY.md` added a stricter transition protocol:

- an explicit reading order;
- authoritative homes for behavioral rules, engineering practices, task conventions, and technical contracts;
- update triggers tied to continuity risk;
- exclusion rules for material already captured elsewhere;
- lifecycle rules requiring entries to leave memory after promotion;
- mandatory orientation and confirmation after compaction or restart;
- timestamped snapshots before every rewrite.

The snapshot corpus contains 37 files and 3,763 lines from March 3-23, 2026. This proves repeated use. It also records why the mechanism existed: automatic continuation after compaction had caused unconfirmed work, and important design decisions were repeatedly being re-litigated.

The later indexed memory split user preferences, project architecture, current state, naming rules, and specific inventories into separate files. This reduced automatic context load, but `project_state.md` eventually became a chronological session ledger with stale test counts and many completed-session sections. That material belongs in history, not current startup state.

Current drift matters:

- `spank-py/CLAUDE.md` has uncommitted changes.
- The project hook is in `.claude/settings.json0`, so it is disabled by filename.
- Current `~/.claude/settings.json` has no hooks.
- The Spank managed-memory directory has `MEMORY.mdold`, not an active `MEMORY.md`.
- A second Spank-oriented memory index exists in global `~/.claude/memory`, where project-specific state can leak into unrelated projects.

The design was sound, but the live deployment is no longer internally aligned.

### Repository Instruction Routers

Several smaller deployments show that a context system does not need to be elaborate.

`wpages/AGENTS.md` is three lines:

- `WPages.md` for project overview and workflow;
- `Status.md` for implementation and pending concerns;
- `tests/TESTS.md` for test scope and coverage.

This is the clearest progressive-disclosure design in the corpus. It names the authoritative documents and their purpose without copying their content.

`harduw/AGENTS.md` adds communication rules and points to:

- `HardenUW.md` for design and structure;
- `HardenSteps.md` for implementation and administration;
- `HardenPrompt.md` for prompting methods.

`multiwp/AGENTS.md` and `must-py/AGENTS.md` expanded into 41-line policy files covering voice, edits, Markdown, security, Git, and prompt parsing. They were used and committed, but they duplicate many global agent rules. WPages and the later Zero files are better models for a compact project layer.

`Zero400/AGENTS.md` and `zerowalletmac/AGENTS.md` demonstrate another useful function: scope separation. One says full node only and excludes the wallet; the other says desktop wallet only. Those boundaries prevent context from one neighboring repository silently entering another.

### CContext

`CContext` is a research and deployment guide rather than a runtime service. Its main contribution is a clean model of context authority:

1. assembled system prompt;
2. tools and schemas;
3. injected project files such as `CLAUDE.md` and memory;
4. dynamic runtime notices;
5. conversation history, later replaced by compaction summaries.

It correctly assigns stable project rules to `CLAUDE.md`, volatile continuity to memory, and detailed technical explanation to documents read on demand. It also analyzed 23 Claude sessions, 165 MB of JSONL, and 5,279 tool calls to ground configuration choices.

Its reusable artifacts are not yet safely distributed. The committed GitHub repo contains only `CCLaunch.md`, `CDecode.md`, `CInternals.md`, and `CPrompts.md`. The practical examples and scripts are untracked. The example `CLAUDE.md` tells the reader to open `README.md`, but the repo has no `README.md`. Treat CContext as high-value research requiring one packaging pass.

### Zero And Insight Managed Memory

The June 2026 Zero/Insight memory is the strongest example of bounded, on-demand facts. The index is short; each linked file has one purpose. Examples include:

- RPC contract test method;
- live daemon/build transition;
- host and deployment paths;
- backup naming convention;
- current documentation tier rules;
- one ordered `session-status-next.md` handoff.

This is more useful than a long undifferentiated `MEMORY.md`. It supports immediate resumption without forcing every operational detail into the initial context.

Two entries also show how learned preferences became reusable rules: `reference-link-rules.md` and `no-archeology-no-history-in-docs.md`. They are practical and specific, but currently exist only inside Claude's local state. Their durable conclusions should be promoted into the relevant repository's `AGENTS.md` or documentation guide.

### Misses And pDSL

The Misses project provides a disciplined promotion pipeline:

1. retain session evidence;
2. classify failures and interaction intent;
3. measure recurring behavior;
4. stage candidate instructions in `PromptProps.md`;
5. require explicit confirmation before moving a proposal into active `CLAUDE.md`.

That separation is excellent. It prevents every frustrating interaction from immediately bloating the startup prompt.

`Falla.md` supplies an intent taxonomy: directives, goals, observations, opinions, confirmation, clarification, correction, back-reference, new subject, pacing, compound prompts, and miss review. `pDSL.md` explores explicit markers such as hold and checkpoint, but correctly notes that a probabilistic model cannot make a prompt DSL deterministic.

The practical conclusion is narrower than a full DSL: reserve a few explicit markers for high-cost ambiguity, such as discussion-only, hold, checkpoint, exact token, and direct authorization for side effects. Keep the full taxonomy as analysis, not injected context.

### Codess

Codess addresses a different layer: preserving and querying what happened. Its databases under WPages, HardUW, and CodeSess demonstrate real ingestion. This is useful for archaeology, analytics, and recovering lost sessions.

It should not become the source of project truth. A session database can answer who discussed a decision and when; the repository must still state the current decision. Codess should eventually index these project-owned context surfaces:

- repository path and Git remote;
- `AGENTS.md` and `CLAUDE.md` locations and hashes;
- document-map targets;
- durable status file;
- local memory index location;
- recent session IDs and transition summaries.

That would make Codess a catalog and portability aid without turning conversation history into an implicit specification.

## Current Known Gaps

The following gaps remain in the current deployments and should drive the operating model and migration work below.

1. Rules duplicated into memory, README, process docs, and instruction files, then diverged.
2. Memory accumulated completed-session chronology and stale test counts.
3. Valuable local files remained untracked, including CContext examples and managed Claude memories.
4. Project-specific memory appeared in global `~/.claude/memory`, risking cross-project contamination.
5. Runtime configuration drifted from its documentation: renamed/disabled hook files and missing live hooks.
6. Very large prompting references such as `HardenPrompt.md` became research libraries rather than usable startup instructions.
7. Session stores preserved history but did not preserve the current context manifest needed on another computer.
8. Agent-specific files fragmented the rules. `AGENTS.md` and `CLAUDE.md` need an explicit relationship, not copied parallel policies.

## Permissions And Harness Configuration

The permission work followed the same trajectory as memory: useful experiments accumulated at user, project, session, and copied-environment scopes, but no single effective-state view was maintained.

### Control Layers

The reviewed environments use at least four distinct mechanisms:

1. Runtime sandbox and approval mode: whether a tool can reach the filesystem, network, or host, and whether execution pauses for approval.
2. Tool allow/deny rules: prefix and path patterns pre-approved or blocked by the harness.
3. Hooks and wrappers: code run at session start, before a tool, or after compaction; shell wrappers also change available tools and environment.
4. Behavioral instructions: `AGENTS.md` and `CLAUDE.md` rules asking the model to avoid destructive operations or request confirmation.

Only the first three enforce behavior mechanically. The fourth is valuable defense in depth but cannot revoke a capability already granted by the harness.

### Current Codex Posture

`~/.codex/config.toml` currently sets:

- global `sandbox_mode = "danger-full-access"`;
- network access enabled;
- `approval_policy = "never"`;
- the full-access warning hidden;
- four local projects marked trusted;
- live web search and several connected plugins enabled.

`~/.codex/rules/default.rules` contains historical pre-approvals, including:

- pushing `main` to origin;
- pulling/rebasing `main`;
- two project-specific recursive removals;
- several exact old shell/Python commands.

The current global posture makes most of those prefix rules operationally redundant: full host access plus `never` means the agent is not waiting for those rule matches. They remain evidence of an earlier allowlist experiment and can mislead a reader into thinking they are the active security boundary.

The Codex thread database shows the progression:

| Period | Observed thread posture |
|---|---|
| Late 2025 to early 2026 | `read-only` or `workspace-write`, usually `on-request` |
| February-April 2026 | `danger-full-access`, mostly `on-request` |
| Recent 2026 threads | `danger-full-access` or disabled filesystem sandbox, often `never` |

This is a real shift from bounded execution toward convenience and autonomy. The repository prose continued to require confirmation for Git, deletion, package changes, and remote execution, but the current Codex harness does not enforce that requirement.

### Current Claude Posture

`~/.claude/settings.json` currently has:

- permission mode `acceptEdits`;
- 48 user-level allow entries;
- 7 deny entries;
- no active hooks;
- auto-compaction and away summaries disabled;
- co-author trailers disabled while built-in Git instructions remain enabled.

The global allows include unrestricted-prefix forms for Git, Python, curl,
GitHub CLI, copy, trash, cargo, uv, jq, sed, and awk, plus bare `Edit`,
`Write`, `WebFetch`, and `WebSearch`. The deny list protects selected credential
paths only through Claude's `Read` tool.

`Bash(git:*)` is already active at user scope. The older `Bash(git add *)`,
`Bash(git stash list *)`, and `Bash(git stash show *)` entries are therefore
redundant. This broad rule minimizes Git prompts, but it also covers remote and
history-changing Git operations; it is a convenience stance, not a read-only
Git policy.

That boundary is incomplete. A denied `Read(~/.ssh/**)` does not by itself prevent an allowed Python or shell command from reading the same path. Secret-path protection must exist at the sandbox, OS, or Bash-policy layer too; tool-specific deny rules are not a general information-flow boundary.

The current live state also contradicts the CContext deployment description:

- CContext describes a Spank `PreToolUse` Bash environment hook.
- The only project file now present is `.claude/settings.json0`, which Claude does not load as `settings.json`.
- The user-level Claude settings have no hooks.

The hook was designed and apparently used, but is no longer deployed.

### Project Overrides

Eighteen non-archival project-specific Claude permission files remain as `.claude/settings.local.json`. The global Git ignore rule excludes that filename everywhere, so these files are local click-history, not portable project policy. Allows containing concrete paths, arguments, PIDs, test names, domains, or shell fragments can be discarded from policy consideration. Review only bare capabilities and broad command-family forms such as `Bash`, `Read`, `Write`, `Edit`, `WebSearch`, and `Bash(find:*)`; deliberate user-wide grants belong in `~/.claude/settings.json`.

The regenerated `local.csv` contains 50 unique WebFetch hostnames from non-archival local settings, but parameterized domain grants are not migration candidates under this rule. `domains.cvs` contains the corresponding 44 sorted unique base domains for reference.

The broad forms currently found across those files are bare `Bash`, `Read`,
`Write`, `Edit`, and `WebSearch`, plus `Bash(command:*)` families for
shell/interpreter and inspection tools. These are the only local allows worth
comparing with the user baseline. Entries such as exact Git commands, paths,
`Bash(done)`, loop fragments, environment assignments, and one-off test
invocations are approval residue rather than policy abstractions.

Current Git-rule examples divide into three useful classes:

- user policy: `~/.claude/settings.json` has the active `Bash(git:*)` grant;
- tracked project policy: `mcpred/.claude/settings.json` repeats
  `Bash(git:*)`;
- reference examples: the cloned `agentdb`, `agentic-flow`, and `ruflo`
  settings enumerate separate `git add`, `branch`, `checkout`, `commit`,
  `config`, `diff`, `log`, `push`, `stash`, `status`, and `tag` rules.

The ZK and coding-tool `settings.local.json` files contain similar operation
lists, but those are local approval residue. They are evidence for which command
families recur, not portable policy. Since the user-level `Bash(git:*)` rule is
already broader, copying those lists would add duplication without reducing
prompts.

Prompt-level autonomy stances also recur, but mostly in reference projects:

- `oh-my-codex/AGENTS.md` says to complete work without asking and narrows
  questions to irreversible, side-effectful, or materially branching actions;
- OpenClaw workspace templates say "Don't ask permission. Just do it," while
  separately requiring confirmation for destructive commands;
- the Codex source `AGENTS.md` allows formatting and scoped tests without asking,
  but asks before the full test suite;
- the authored `Claude/Agents` and `Misses` rules take the more conservative
  stance that commit, push, destructive filesystem changes, installs, and remote
  execution require approval.

The useful synthesis is not blanket autonomy. State once that routine,
reversible inspection, editing, formatting, and scoped verification proceed
without confirmation; reserve questions for destructive changes, publication,
credential use, and choices that materially change the requested result. This
reduces conversational approval calls while runtime allows handle repeated tool
acceptance.

### Permission Research That Worked

`CContext/permission_audit.md` inspected eight Spank JSONL sessions and found seven denial events. Its key practical finding was not repeated denial of an already-approved path; it was command-shape mismatch. Claude's matcher evaluated the leading token, so commands beginning with an assignment or `for` did not match the allowlisted command later in the shell string.

The practical acceptance rule is consequently simple: begin the tool call with
the allowlisted executable. `git -C <path> ...` matches the Git family;
`cd <path> && git ...`, `VAR=value git ...`, and a `for` loop begin with a
different token and may ask again. Direct one-command calls improve acceptance
more reliably than accumulating exact command strings.

`Misses/PromptProps.md` refined that into a useful rule:

- shape commands to an existing narrow allowlist rather than widening the allowlist;
- use `git -C <path>` instead of `cd <path> && git ...`;
- issue one command per tool call;
- keep Git history changes, removals, and non-GET remote changes gated;
- distinguish a report of an action from an explicit imperative authorizing it.

This is one of the clearest examples of session evidence becoming a proposed operational rule. The proposal remains staged rather than active, which is methodologically correct.

### Effective Assessment

The current system is internally inconsistent:

1. Prose instructions usually require explicit approval for destructive or remote actions.
2. Claude has broad user grants and project-local additions that can bypass those intentions.
3. Codex is globally full-access with no approval gate.
4. Hooks described as enforcement or environment setup are disabled or absent.
5. Local project grants are ignored by Git and therefore do not move to another computer.
6. Old local settings retain sensitive and obsolete command history.

This does not mean the experiments failed. They identified real parser behavior, useful command shaping, project-specific needs, and the difference between user and project scopes. The missing product is an auditable effective-policy view and a deliberate baseline.

### Recommended Permission Model

Use a small baseline plus explicit exceptions.

1. User baseline: default to workspace-bounded filesystem access, network only when needed, and approval for side effects. Do not use global full-access/never as the durable default.
2. Project policy: track only reviewed `.claude/settings.json` hooks or narrow rules that every checkout needs. Keep `settings.local.json` as disposable user-specific residue.
3. High-risk actions: choose one explicit stance. A narrow stance gates Git
   commit/push/rebase; the current `Bash(git:*)` stance deliberately trades that
   gate for fewer prompts. Recursive deletion, package installation, arbitrary
   remote execution, process-wide kill, privilege escalation, and non-GET
   remote requests should remain separately controlled.
4. Secrets: deny them at filesystem/sandbox level where possible; do not rely on a `Read`-tool deny while arbitrary interpreters are allowed.
5. Command design: prefer narrow direct invocations over compound shells. Approval rules should name stable command families, not session-specific command strings.
6. Hooks: use them for logging, invariant checks, or bounded environment setup. Verify they are actually loaded; a renamed `settings.json0` is documentation, not deployment.
7. Audit: periodically generate a redacted matrix of user defaults, project additions, active hooks, trusted roots, and dangerous grants. Compare it with `AGENTS.md` / `CLAUDE.md` claims.
8. Portability: Codess should record policy file paths and hashes, but secret-bearing and local approval files must not be copied automatically.

## Recommended Operating Model

Use five surfaces, each with one job.

### 1. AGENTS.md

Keep this versioned, short, and cross-agent. Target roughly 20-60 lines, shorter when possible.

Include:

- project scope and neighboring-repo exclusions;
- authoritative reading order;
- project-specific safety or Git constraints;
- links to current status and technical docs;
- only behavioral rules that repeatedly matter in this project.

Do not include project history, current task details, test counts, or long prompting tutorials.

### 2. CLAUDE.md

Use only when Claude needs behavior not represented by the cross-agent file or when Claude's loading semantics require it. Begin by reading or adopting `AGENTS.md`; add Claude-specific compaction, memory, hook, or tool guidance. Do not maintain a second copy of general project rules.

### 3. Repository Truth

The repository should carry durable knowledge in human-readable documents:

- `README.md`: project purpose and document map;
- `STATUS.md`: current stage, known working state, open decisions, and next bounded work;
- technical documents: contracts and architecture;
- Git history: historical evolution.

`STATUS.md` should describe the present, not become a chronological diary.

### 4. Volatile Memory

Use the indexed fact-file pattern locally:

- `MEMORY.md`: one-line index only;
- `session-status-next.md`: one current handoff, replaced rather than appended;
- bounded fact files for facts not yet promoted into repository truth;
- preferences only when they are not already active in `AGENTS.md` or `CLAUDE.md`.

Each memory entry needs a disposition: promote to repository, retain as local operational fact, or delete when obsolete. Periodic review should remove stale entries.

### 5. Historical Ledger

Use Codess and immutable snapshots for recovery and analysis. Store IDs, timestamps, paths, sources, and hashes. Do not automatically re-inject historical transcripts into working context.

## Hierarchical Policy And Cross-Harness Compatibility

The hierarchy should organize source material by meaning and load it according to need. It should not make `CLAUDE.md` the canonical home for every rule merely because Claude happens to read that filename.

### Current Loading Reality

For the present `~/Work/Spank/spank-rs` working directory:

- `~/.claude/CLAUDE.md` does not exist;
- no `CLAUDE.md` or `CLAUDE.local.md` exists from `~/` down through the current directory;
- no project `.claude/CLAUDE.md` exists;
- no project `AGENTS.md` exists;
- `~/Work/Spank/spank-py/CLAUDE.md` is a sibling and is not loaded for `spank-rs`.

Therefore a Claude Code session launched in `spank-rs` currently gets neither a user-level nor project-level authored instruction file from this hierarchy. A Codex session also gets no repository `AGENTS.md` from this path.

Claude Code's current documented behavior is:

1. `~/.claude/CLAUDE.md` is user-wide.
2. `CLAUDE.md` or `.claude/CLAUDE.md` is project-shared.
3. `CLAUDE.local.md` is personal to the current project.
4. Claude loads `CLAUDE.md` and `CLAUDE.local.md` files on the ancestor chain above the working directory at launch; they concatenate rather than replace one another.
5. Additional `CLAUDE.md` files inside subdirectories are allowed and load lazily when Claude accesses files in those directories.
6. `.claude/rules/**/*.md` supports modular rules; `paths:` frontmatter can limit rules to matching files or subtrees.
7. `@path` imports organize content but do not reduce context cost because imports expand at launch.
8. `CLAUDE.md` is not a per-session file. Session-only constraints belong in the prompt or temporary command-line configuration; `CLAUDE.local.md` is persistent local project policy, not session memory.

Claude Code does not directly treat `AGENTS.md` as its instruction file. Anthropic now explicitly recommends a small `CLAUDE.md` that imports `@AGENTS.md` when a repository already uses the cross-agent name. Codex directly loads hierarchical `AGENTS.md` files from global, repository, and nested directory scopes.

Official references:

- Claude memory and instruction hierarchy: https://code.claude.com/docs/en/memory
- Claude settings scopes: https://code.claude.com/docs/en/settings
- Claude extension loading: https://code.claude.com/docs/en/features-overview
- Codex `AGENTS.md`: https://developers.openai.com/codex/guides/agents-md
- Codex skills: https://developers.openai.com/codex/skills

### Separate The Concerns

The proposed semantic modules are:

| Module | Contents | Typical load mode |
|---|---|---|
| Communication | Voice, interaction pacing, clarification, reports versus instructions, scope control | Small always-on core |
| Agent operations | Tool selection, destructive action, approval behavior, Git ownership, stopping rules | Small always-on core plus harness overlay |
| Software engineering | Design discipline, testing, review, security, dependency and release practices | On-demand skill or project rule |
| Documentation | Document types, present-state writing, cross-references, status and decision placement | On-demand skill; path-scoped for docs |
| Coding baseline | Naming, structure, error boundaries, API and test conventions independent of language | Path-scoped or implementation skill |
| Language standards | Python, Rust, TypeScript, shell, SQL, and framework-specific rules | File-extension or subtree scoped |
| Methodology | Company/project life cycle, product discovery, SDD, architecture process, regulated workflows | Project-selected skill or rule |
| Project truth | Scope, architecture, commands, current status, local terminology | Repository documents referenced by entry file |
| Harness adapter | Claude/Codex tool names, hooks, settings, permission syntax, invocation controls | Provider-specific and small |

Not every module deserves a permanent prompt slot. Communication and high-cost safety rules need continuous availability. A Python style guide is relevant only when Python is being changed. A release checklist should load for release work. A long documentation method should load when editing documentation, not when debugging a parser.

### Canonical Source And Adapters

A provider-neutral policy repository should own the semantic text once. One possible structure is:

```text
agent-policy/
  core/
    communication.md
    operations.md
  engineering/
    manufacturing.md
    testing.md
    security.md
  documentation/
    documentation.md
  coding/
    baseline.md
    python.md
    rust.md
    typescript.md
  methods/
    project-lifecycle.md
    spec-driven-development.md
  skills/
    documentation-review/SKILL.md
    implementation-review/SKILL.md
    release-review/SKILL.md
  adapters/
    claude/
    codex/
  tests/
    scenarios.yml
    expected-behaviors.yml
  registry.yml
```

This is a source organization, not a mandate to inject every file. The registry should record, for each module:

- stable identifier and owner;
- purpose and non-purpose;
- scope: user, organization, repository, subtree, task, or session;
- load policy: always, path-matched, model-invoked, or explicit-only;
- canonical source path;
- Claude and Codex adapter targets;
- provider-specific deviations;
- version and last validation date;
- scenario tests that justify the rule.

### Repository Entry Pattern

Use `AGENTS.md` as the shared project core where practical:

```text
repo/
  AGENTS.md
  CLAUDE.md
  README.md
  STATUS.md
  .claude/
    rules/
      docs.md
      python.md
      rust.md
    skills/
  .agents/
    skills/
```

`AGENTS.md` should stay short and contain cross-harness project rules, reading order, verification commands, and scope boundaries.

`CLAUDE.md` should normally be a wrapper:

```md
@AGENTS.md

## Claude Code

- Claude-specific compaction, hook, or tool behavior only.
```

Do not use a long chain of `@` imports as a pseudo-module system. Every import enters startup context. Use `.claude/rules/` for path specialization and skills for task specialization.

For Codex, nested `AGENTS.md` or `AGENTS.override.md` files provide subtree specialization. Codex concatenates global guidance, repository guidance, and files down to the current working directory; closer files apply later. The default combined project instruction budget is 32 KiB, another reason to keep entry files narrow.

### Skills As The Shared Extension Unit

Both Claude Code and Codex currently support the open Agent Skills `SKILL.md` format. That makes skills the best available compatibility surface for reusable workflows and deep reference material.

Use skills for:

- documentation review;
- language-specific implementation and review;
- security and release checklists;
- schema transformation;
- repository archaeology;
- repeatable operational workflows.

Do not assume identical provider behavior around the shared file format. Discovery paths, frontmatter extensions, tool permissions, implicit invocation, subagent execution, and packaging differ. Keep one canonical skill body where semantics match, then apply thin provider metadata or wrappers.

For large skill collections:

- curate descriptions because descriptions consume startup context and drive invocation;
- make side-effectful skills explicit-only;
- disable or uninstall obsolete skills rather than leaving every published skill active;
- pin third-party sources by version or commit;
- distinguish reviewed, experimental, quarantined, and retired resources;
- record tool and MCP dependencies;
- test trigger and non-trigger prompts after upgrades.

Claude supports user and project skills under `~/.claude/skills/` and `.claude/skills/`, plus plugin distribution. Codex scans user and repository `.agents/skills/` locations and packages distributable skills as plugins. A deployment script or package manager can place adapters in both locations from one canonical source; do not hand-edit two divergent copies.

### Plugins, Hooks, MCP, Agents, And Settings

Use each mechanism for its actual role:

| Mechanism | Appropriate use |
|---|---|
| Skill | Reusable task method or deep reference, loaded on demand |
| Plugin | Versioned distribution bundle for skills plus provider integrations |
| Hook | Deterministic lifecycle observation, validation, or enforcement |
| MCP server | Live external tools, data, or actions |
| Subagent/agent | Isolated role, context, model, and tool set for delegated work |
| Settings | Runtime model, permissions, hooks, plugins, environment, and user/project/local scope |
| Memory | Volatile continuity and learned local facts, not policy authority |

Do not encode deterministic security enforcement only as prose. Do not turn a skill into an always-loaded policy. Do not use memory as a configuration source. Do not use a plugin merely to distribute a paragraph that belongs in `AGENTS.md`.

### Compatibility Policy

Do not pursue byte-identical configuration across providers. Pursue semantic compatibility.

Maintain three layers:

1. Canonical behavior: provider-neutral statement and rationale.
2. Capability mapping: how each harness loads, scopes, invokes, and enforces it.
3. Provider adapter: minimal syntax needed for that harness.

Examples:

- Common behavior: destructive actions require explicit authorization.
- Claude adapter: instruction text, permission deny/ask rules, and optional `PreToolUse` hook.
- Codex adapter: `AGENTS.md` text, sandbox/approval profile, rules, and optional hook.

When one capability changes, amend the canonical behavior once, update only affected adapters, and run compatibility tests. Do not manually rewrite similar prose in every provider file during the same session and hope the copies remain aligned.

### Validation And Lifecycle

Every release or provider upgrade should run a small configuration audit:

1. List loaded instruction files and their order.
2. List discovered skills and source paths.
3. Verify expected trigger and non-trigger prompts for important skills.
4. Inspect effective permissions, hooks, MCP servers, plugins, and settings scopes.
5. Detect duplicate identifiers and divergent generated copies.
6. Check that provider adapters match the canonical module version.
7. Run behavioral scenarios for the costly rules: scope, destructive actions, Git authorization, documentation placement, and stopping behavior.

Claude's `InstructionsLoaded` hook can record which instruction file loaded, why, and whether it was eager or lazy. Codex can be asked to list its active instruction sources, and its session logs can be audited. Codess is a natural place to index those observations across sessions and machines.

The durable rule is: author once, adapt narrowly, load progressively, enforce mechanically where required, and test the effective configuration rather than trusting the directory layout.

## Migration Priorities

1. Establish explicit user baselines for Codex and Claude, replacing global full-access/no-approval and broad interpreter/network grants with reviewed defaults.
2. Compare only bare capabilities and broad `Bash(command:*)` families in project `settings.local.json` files with the user baseline; discard parameterized approval history, then remove the local files.
3. Package CContext: add a README, review and commit the reusable examples, and clearly mark templates versus live configuration.
4. Reconcile Spank: decide whether the modified `CLAUDE.md` is authoritative, restore or retire the project hook intentionally, and remove Spank-specific files from global Claude memory.
5. Promote durable Zero/Insight memory rules and current operational facts into the appropriate Git repositories; leave only transition state in local memory.
6. Give each revived project a compact WPages-style instruction router and a present-state `STATUS.md`.
7. Extend Codess with a context-manifest/status view that records instruction files, document-map targets, memory indexes, policy hashes, Git identity, and recent sessions without copying local credentials.
8. Keep Misses as the rule laboratory. Promote only high-frequency, high-cost findings into active instructions.

## Revival Test

A project is portable enough to resume on another computer when a new agent can answer these questions without the old conversation:

1. What is this project, and what is explicitly out of scope?
2. Which files are authoritative, and in what order should they be read?
3. What is true now?
4. What remains undecided or incomplete?
5. What action is proposed next, and does it require user confirmation?
6. Where is historical session evidence if deeper archaeology becomes necessary?

If those answers require opening an old chat sidebar, the context system has not yet carried the work product forward.
