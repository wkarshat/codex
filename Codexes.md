# Codexes: Focused Project Triage

Generated: 2026-06-26 from `~/Work` and non-secret Codex metadata in `~/.codex`. Updated: 2026-07-06.

Companion review: `~/Work/Codex/ContextSystems.md` inventories the authored `CLAUDE.md` / `AGENTS.md` deployments, Claude memory systems, prompt libraries, session-store work, and effective Claude/Codex permission layers. It proposes a compact operating model for carrying project truth and transition state forward while keeping runtime enforcement auditable.

This documentation set is maintained in `~/Work/Codex`, on branch `main`, with remote `https://github.com/wkarshat/codex.git`. The remote was empty when connected on 2026-07-04; the first consolidated project/session/cleanup checkpoint was pushed as `5de9506` on 2026-07-06.

Cleanup guide: `~/Work/Codex/Cleanup.md` provides conservative manual directions, while `~/Work/Codex/CleanupCandidates.tsv` names exact directories, repositories, session IDs, cloud-task URLs, prerequisites, and recommended actions for automated auditing or quarantine.

This revision discounts clean third-party OSS clones used for rapid review. It focuses on repos that look originated, extended, dirty, locally significant, or connected to Codex sessions.

## Bottom Line

- Git repos under non-archival `~/Work`: 229.
- Repos in the `fear-ai`, `wkarshat`, or `zerocurrencycoin` namespaces: 43.
- Dirty non-owned or no-remote repositories needing classification: 21.
- Active local Codex app threads: 24 across 14 working directories; all are currently unarchived.
- Active Codex Cloud tasks: 2, both held Fedload tasks with changes.

Best current bets: continue `Spank` around `HECpoc` + `spank-rs` + `SpankMax`, and revive the Fedload/labor/specification arc as a connected program. The previously missed `~/Work/Github/truj` corpus materially strengthens that second bet: it contains the labor controlled vocabulary, aliases, source manifests, schemas, and validation attempts that the proposed revival otherwise would have had to invent. Best meta-tool to revive: `Codess/CodeSess`, because it solves the exact missing session ledger problem.

## Decision Table: Continue / Revive

| Work | Paths | Call | Why |
|---|---|---|---|
| Spank HECpoc + spank-rs + SpankMax | ~/Work/Spank/HECpoc; ~/Work/Spank/spank-rs | Revive/continue | Most recent Codex work; HECpoc has 2026-06-24 commit plus local WIP; spank-rs has active Codex threads through 2026-06-26. This is the clearest current product line. |
| Fedload + Labor Dashboard + SDD/DSL specs | ~/Work/Github/fedloadw; ~/Work/Github/truj; ~/Work/Code/Schemas.md; ~/Work/Code/Misses/pDSL.md | Revive as connected research/tooling program | Fedload accumulated Federal Reserve source knowledge; `truj` extended the work into jobs/employment and produced a controlled vocabulary, source manifests, aliases, record experiments, and dashboard requirements; pDSL/SDD explored agent-fed specifications. Treat one labor-source ingestion path as the testbed. |
| Misses / Petri LLM failure corpus | ~/Work/Code/Misses | Revive/continue | Recent 2026-06-27 commit plus six local changes; strong README with concrete next analysis. Worth preserving as research infrastructure. |
| LLM hardware architecture research | ~/Work/LLMHW | Recover and reassess narrowly | Aggregates the June 2025 ChatGPT investigation of cache structure, inference algorithms, Groq, Cerebras, and comparable accelerators. Next work is limited to verifying and organizing that earlier research; Equihash and the July 2026 `FableFrontiers` program are separate and out of scope. |
| Codess / CodeSess session record store | ~/Work/Code/CodeSess | Revive for this exact pain | It addresses the session portability/status problem directly. `CodeSess` is now the sole local checkout; the stale lowercase duplicate was removed. Add Codex app state support. |
| Zero / ZK active branch set | ~/Work/ZK/Zero400; ZeroMac; zerowallet*; Docs; ZKs/insight/*zero | Selective revive | Own namespace and recent commits; likely useful if Zero maintenance is still alive. Needs pruning: keep active Zero400/ZeroMac/current insight-zero line, archive older snapshots. |
| OpenClaw + setpack | ~/Work/Claw/openclaw; ~/Work/Claw/setpack | Wrap or revive deliberately | Large Codex history and local WIP. Worth either a status/decision document or a clean closing commit; too much state to leave implicit. |

## Fedload / Labor / SDD Cluster

Scope boundary: `~/Work/Github/Schema` and `~/Work/Github/skip` are separate efforts handled elsewhere. They are not assessed, prioritized, or assigned actions in this document.

| Piece | Paths | Current evidence | Assessment |
|---|---|---|---|
| Fedload monitor | ~/Work/Github/fedloadw | README defines a Federal Reserve site monitor with change detection, entity extraction, reports, and API; code has `main.py`, `scheduler.py`, `fetcher.py`, `hasher.py`, `fed_entity_recognizer.py`, configs, reports, and tests. TODO flags scheduler monolith, JSON growth, config validation, recovery, data rotation, async, and SQLite migration. | Keep as domain testbed, not just app code. It is a real monitoring prototype, but it hit exactly the architecture/data-shape problems the schema/spec work should address. First revival step should be an architecture/status reset, not more feature work. |
| SDD / DSL for agent-fed specs | ~/Work/Code/Misses/pDSL.md plus related specification notes | pDSL frames prompt/spec syntax as controlled vocabulary, scope markers, checkpointing, and exact-token designators for predictable LLM agent behavior. | Use as the agent interface layer: requirements/spec DSL should produce constrained implementation tasks for coding agents. This bridges schema design and actual Fedload/Spank implementation work. |
| Revival path | Fedload as fixture, `truj` as source/vocabulary corpus, pDSL/SDD as agent protocol | No Codex app thread anchors found for this cluster, so it is under-indexed in current Codex state despite repo/doc evidence. | Define one small vertical slice from source artifact through normalized record and inspection output. |

### Fedload Stabs

| Work | Path | What It Is | Stage | Keep / Revive Use |
|---|---|---|---|---|
| Fedload working monitor | `~/Work/Github/fedloadw` | Federal Reserve site monitor: scheduled fetches, hash-based change detection, optional NER, report generation, FastAPI endpoints, tracked site/config JSON. | Beta-ish prototype on `develop`, remote `gh:fear-ai/fedloadw`; locally dirty only by deleted `.gitattributes` and `.gitignore`. Previous docs say 16 tests passed, 3 skipped, but current environment lacks dependencies such as `schedule` and `fastapi`, so tests did not collect here. | Treat as the domain fixture. Use it to drive the next schema/spec design, but do not extend the monolithic scheduler directly. |
| Fedload architecture backlog | `~/Work/Github/fedloadw/TODO.md`, `CHANGELOG.md`, `DEVELOP.md` | Explicit backlog: split `scheduler.py`, add config schema validation, rotate large JSON files, improve recovery/circuit breakers, structured logging, async processing, DB migration. | Well-documented but not yet implemented; `scheduler.py` is 665 lines locally and owns too much. | Convert this into a rebuild spec. The right target is smaller modules plus SQLite/typed records, not more JSON-file accretion. |
| Fed entity knowledge | `~/Work/Github/fedloadw/fed_entities.json`, `fed_terms.json`, `fed_entity_recognizer.py` | Domain-specific entity extraction for Fed officials, organizations, publications, events, and related terms. | Prototype data/logic exists; NER disabled by default in config for performance/stability. | Valuable seed data. Keep as a fixture for schema work: define canonical `Person`, `Organization`, `Publication`, `Event`, `Source`, `Document`, and `Change` entities from this. |
| Seed prompt/spec notes | `~/Work/Code/Schemas.md`, `~/Work/Code/Misses/pDSL.md` | Original representation problem prompt plus pDSL/SDD thinking about controlled specs, scope markers, checkpoints, exact-token naming, and agent workflow. | Loose notes. | Use as intent and agent-workflow input for the bounded ingestion pilot. |

### Fedload And quizC Identity Map

The `FedLoad Windows` cloud environment mixed two repositories. Classify a task by the repository it actually ran against, not by its sidebar grouping or prompt title.

| Effort | Durable carriers | Defining version to save | Aggregated residue | Decision |
|---|---|---|---|---|
| Fedload application | Local `~/Work/Github/fedloadw`; remote `fear-ai/fedloadw` | `develop` at `7ca6725` (2025-06-19), the latest implementation/documentation line | Eight zero-diff Fedload cloud tasks archived; remote design branch `codex/analyze,-design-and-plan-solution` at `e5d01bb`; one unreachable seven-line test patch | Keep `develop`. Resolve the local deletions of `.gitattributes` and `.gitignore` before calling the checkout clean. Hold the 87-line design and seven-line test tasks until their branch/patch disposition is explicit. |
| Fedload domain continuation | `~/Work/Github/truj` | No single executable successor yet; `truj` is the strongest data/vocabulary continuation | Labor vocabulary, aliases, source manifests, record experiments, and validation attempts | Preserve as related research, not as a version of `fedloadw`. Consolidate through the bounded ingestion pilot described below. |
| quizC application | Private remote `fear-ai/quizC`; no local checkout found after expanded home-directory search | `edit100224_1` at `8737fb3`, containing the only implementation (`quiz_environment.py`, `quiz_launcher.py`, `quiz_processing.py`) | Stub `main` at `7ee4b01`; all three no-diff quizC-environment cloud tasks archived | Promote or merge `edit100224_1` to `main`, verify it, then remove the old branch. Clone locally only after branch consolidation. |

Preservation targets should be identified by repository and branch; commit IDs are verification pins rather than the primary names:

| Effort | Local repository root | Remote repository | Branch to preserve | Verification commit |
|---|---|---|---|---|
| Fedload | `~/Work/Github/fedloadw` | `fear-ai/fedloadw` | `develop` | `7ca6725` |
| quizC | No local clone | `fear-ai/quizC` | `edit100224_1`, then promote to `main` | `8737fb3` |

For Fedload, work from the existing local repository on `develop`; do not create a second clone. For quizC, consolidate the remote implementation branch first, then make one local clone whose checked-out branch is the resulting `main`.

The quizC local search was repeated across the non-archival home tree, not only `~/Work`. It checked case-insensitive directory names, every discovered `.git/config` remote, Spotlight path/name results, and the known implementation filenames. No clone or loose source copy was found. The only `~/.codex` matches are 2026 audit sessions discussing these same cloud tasks; they are not quizC development sessions.

#### Fedload Cloud Aggregate

Ten tasks belong to the Fedload effort by repository or intent:

- two failed duplicate run/test attempts;
- four no-diff one-shot operations (`Run main.py`, read, download, and list changes);
- two no-diff review/report tasks;
- one design task whose `ANA.md`, `DES.md`, and `PLAN.md` survive only on `e5d01bb`;
- one test task whose only useful result is the recorded import-order adjustment.

None is a defining application version. The eight zero-diff Fedload tasks were archived on 2026-07-05. Retain the two changed tasks for now: compare the design files against current documentation and preserve or reapply the test patch before deciding whether those tasks can also go.

#### quizC Cloud Aggregate

Three tasks actually ran against `wkarshat/quizC` (now redirected to `fear-ai/quizC`):

- `Explain codebase structure to newcomer`: no diff;
- `Find and fix a bug in codebase`: no diff;
- `Review fedloadw codebase`: no diff and misrouted by repository selection.

These were archived on 2026-07-05. They were not quizC versions and contained no implementation to save. The sole developed quizC line is remote branch `edit100224_1`.

Suggested unifying target:

1. `fedloadw` supplies the first domain pilot, rebuilt around typed records rather than raw JSON growth.
2. `truj` supplies controlled vocabulary, source manifests, and representative labor fixtures.
3. pDSL/SDD becomes the agent-task layer: data/design specs become constrained implementation prompts.

Minimal vertical slice worth building:

1. Define Fedload entities: `Source`, `Document`, `Change`, `Person`, `Organization`, `Publication`, `Event`.
2. Write canonical JSON Schemas plus mapping examples from existing `fed_entities.json`, `tracked_sites.json`, and `change_log.json`.
3. Add contract tests in Node or Python for valid/invalid examples.
4. Add a small transformer that emits one target format, likely JSON Schema first, then SQLite DDL or Pydantic models.
5. Rewrite only one Fedload path to use the typed schema: fetch one source, detect one change, store/query it.

Fedload schema design correction:

- The original instinct was reasonable: Fedload, and an expanded jobs/employment monitor, faced many source shapes at once: APIs, scraped HTML, downloaded files, CSV/JSON, report text, and possibly PDFs. The first problem was not choosing a final database. It was preserving observations and pulling them into a usable shared representation.
- Start with a controlled vocabulary, not an entity-relationship model. Define canonical terms such as `source`, `document`, `published_at`, `retrieved_at`, `title`, `organization`, `location`, `job_title`, `series`, `measure`, `period`, `value`, `unit`, `url`, `raw_artifact`, `confidence`, and `provenance`.
- Add per-source aliases before hierarchy: each source says what it calls the same concept. Example: `Position Title`, `Job Title`, and `series_title` may map to different canonical terms depending on source context.
- Add source mappers as small, testable adapters: raw payload -> normalized envelope. Do not require all mappers to fill all fields.
- Always retain raw artifacts and source metadata. The normalized record should point back to the original URL/file, fetch time, parser, and raw path.
- Postpone hierarchy and ER decisions. Questions like whether `organization` is a text field, an entity, a department, a district bank, or an employer belong after repeated source patterns are visible.
- A useful early record shape is an envelope: `{kind, source, canonical, raw, provenance, confidence}`. The `canonical` section can stay sparse and evolve.
- Back-store should follow the observed access patterns. JSONL or SQLite is enough at first; PostgreSQL/schema-first design comes later if query needs justify it.

Practical first artifact:

1. `vocabulary.yml`: canonical terms, short definitions, expected scalar/list/object shape.
2. `sources/<name>.yml`: aliases, selectors/API paths, notes, sample source URLs.
3. `mappers/<name>.py`: source-specific conversion into the envelope.
4. `samples/raw/<source>/...`: saved raw artifacts.
5. `samples/normalized/<source>.jsonl`: mapped examples.
6. `tests/test_<source>_mapper.py`: validates mapping on fixed raw samples.

### Labor / Employment Continuation Found

`~/Work/Github/truj` is a substantial, previously omitted continuation of the Fedload idea into jobs and employment information. It is not a Git repo and has no upstream remote, which is probably why it disappeared from the repo-led inventory. Its files are mostly dated September 2025, with a few later filesystem touches.

| Artifact | Evidence | Assessment |
|---|---|---|
| Labor controlled vocabulary | `labor/pack/LaborDictionary.csv` contains 58 data rows plus definitions, labels, aliases, programs, series IDs, frequency, seasonality, units, provenance fields, and intended uses. `validation_config.yaml` defines controlled values for programs and disaggregation. | This is the strongest seed for `vocabulary.yml`; do not restart terminology work from scratch. It already records important ambiguity, such as household versus establishment meanings of employment. |
| Source catalog and capture | `manifest_master.json` has 42 source items and `manifest_v2.json` has 32. Fetch/download scripts cover HTML, PDF, images, and other saved artifacts. Sources include BLS CES/CPS/JOLTS, Federal Reserve material, and outside analysis. | This is the concrete heterogeneous-source fixture the schema work needed. Preserve these manifests and a small representative raw sample set. Do not make live scraping the first revival milestone. |
| Organization aliases | `OrgAlias.csv` and `OrgMap.json` map domains and aliases to canonical organizations, including the Federal Reserve Board, regional reserve banks, FRED, BLS, and private research organizations. | This directly confirms the controlled-vocabulary-plus-source-alias approach. Reuse it as a source registry, while keeping organization hierarchy optional. |
| Publication records | `LaborPublications.json`, Markdown/CSV variants, JSON Schema, examples, summaries, and a validation report. One report records 43 publications, 16 organizations, and 14 authors; a later package contains 50 publication records. | Real normalized data exists, but multiple versions disagree. Choose one canonical record set and retain older versions as fixtures, not parallel truths. |
| Reference-schema research | Notes and examples cover schema.org/CreativeWork, Crossref, DataCite, CSL-JSON, BibTeX/BibLaTeX, MARC/BIBFRAME, PRISM/IPTC, JSON-LD, organization/person schemas, and SHACL. | Useful source research, but too broad for the first implementation. Mine it for provenance and citation fields; postpone universal publication interoperability. |
| Labor indicator model | The dictionary and concordances cover CES, CPS, JOLTS, LAUS, QCEW, FRED, NAICS, SOC, and related measures. PRD 2.3 proposes a tidy observation shape: `series_id`, `date`, `value`, seasonal-adjustment flag, industry codes, measure, footnotes, and snapshot vintage. | This is a second bounded record family, separate from publications: `IndicatorDefinition` plus `Observation`. Keeping it separate avoids forcing articles, people, organizations, and time-series values into one schema. |
| Dashboard product design | Several MRD/PRD versions specify vintage comparison, benchmark tracking, sector contribution, provenance, exports, APIs, and operational requirements. | Valuable intent, but much of it is generated design rather than implemented product. Treat it as a feature reservoir. The vintage comparator is the best distinctive future vertical slice. |
| Executable work | About 10 Python scripts fetch manifests, scan textual changes, validate dictionary values, generate terms/codebooks/summaries, and build packages; there is also one analysis notebook. | Prototype utilities, not an application. There is no package metadata, test suite, CI, datastore, or web implementation. The current code should be harvested selectively rather than adopted wholesale. |

Concrete condition found during this review:

- The canonical dictionary starts with three `#` metadata lines before its CSV header. The validator calls `pandas.read_csv()` without comment handling, so it reads the metadata as the header and cannot validate that file as written.
- The validator hard-codes only CES/CPS/JOLTS/LAUS and narrow cadence values. The dictionary has 17 `programPrimary` values plus weekly frequency, multiple release-day conventions, and `N/A`/placeholder values. Validation configuration exists but the script duplicates older constants instead of loading it.
- The JSON publication schema requires only `title`, `url`, and `source`; later records contain additional provenance/reference fields not declared by that schema. Versioned copies contain 3, 21, 43, and 50-record stages.
- Current Python lacks `pandas` and `jsonschema`, so validation could not be executed here without installing dependencies. Static inspection already demonstrates the CSV/header incompatibility.

Revised revival sequence:

1. Create one small Git repo for the labor ingestion pilot from a carefully selected `truj` subset; do not put all 300-plus mixed generated files under a new canonical history unchanged.
2. Preserve `truj` read-only as archaeological source material. Record file hashes or make a snapshot archive before consolidation.
3. Extract three bounded models: `Source/Artifact`, `Publication`, and `IndicatorDefinition/Observation`. Share provenance fields, not a giant universal entity model.
4. Convert the existing labor dictionary into a machine-readable vocabulary without comment-prefixed CSV ambiguity. Load controlled values from configuration rather than duplicating them in validation code.
5. Select three fixtures: one BLS flat-file row, one Fed/BLS HTML or API record, and one publication/PDF record. Normalize each through a small source adapter while retaining the raw input.
6. Store normalized output in JSONL and optionally index it in SQLite. Add a database only when a demonstrated query requires it.
7. Build one read-only inspection page showing normalized fields, raw provenance, and mapper/version information. The first success criterion is traceable conversion, not a full dashboard.
8. After that pipeline is stable, use the saved PRD's vintage-comparison feature as the first substantive labor product.

This changes the status judgment: the labor/Fedload line is **actual but fragmented**, not merely planned. The vocabulary and examples are useful; the canonical pipeline and product are still missing.

## Codess Status: Planned / Possible / Actual

| Layer | Status | Evidence | Assessment |
|---|---|---|---|
| Planned | Unified session record store for Claude Code, Codex, and Cursor; scan, ingest, normalize, query, and keep a central project registry. | `~/Work/Code/CodeSess/README.md`, `Codess.md`, and `CoPlan.md` describe `.codess/` stores, a registry, scan/ingest/query commands, source adapters, and future FTS/Markdown export. | The concept directly matches the current pain: session continuity, project status, and cross-machine memory. The planned shape is still right. |
| Actual canonical repo | `~/Work/Code/CodeSess` is the newer and stronger implementation. | Remote `gh:fear-ai/codess`, latest local commit `2026-04-13 3f1991a Updates`; tests pass: 212 passed via `/Users/walter/.pyenv/shims/pytest tests/ -q`. | Keep this as canonical. It has package layout, source adapters, registry support, docs, and the clearest implementation plan. |
| Duplicate resolved | The stale lowercase `~/Work/Code/codess` checkout was removed on 2026-07-05. | It had no unique commits and was seven commits behind `CodeSess`/`origin/main`. | Do not recreate it; use `~/Work/Code/CodeSess`. |
| Restructure point | Commit `d7d4872 total restructure and reimplement` is the pivot from old `CodingSess` to new `Codess`. | It removed/renamed `CodingSess.md`, `CSPlan.md`, `CSCandidates.md`, `coding-sessions-schema.sql`, root `cli/`, and root `ingest/`; added `Codess.md`, `CoPlan.md`, `CoSchema.md`, `CursorSchema.md`, `src/cli/`, `src/codess/`, scan/walk/registry code, and expanded tests. | This is the commit that explains the two shapes. Anything before it is the older CodingSess generation; anything after it is the current Codess architecture. |
| Actual CLI | CodeSess exposes `scan`, `ingest`, and `query`; tests cover the core paths. | `python3 -m main scan --dir /Users/walter/Work/Code --source cc,codex,cursor --out -` found only one old Codex/Claude-style project hit plus global Cursor records. `query --dir ~/Work/Code/CodeSess --stats` reports no current `.codess` store. | Core code exists, but live usefulness is limited until current app/session sources are supported and legacy stores are migrated. |
| Actual local data | Current Codex app state is not where CodeSess mainly looks. | `~/.codex/state_5.sqlite` and `~/.codex/logs_2.sqlite` remain the principal current app stores. All nine discovered project `.coding-sess` directories, including CodeSess's legacy database, were deleted on 2026-07-05. | Revival must target current Codex app state and surviving provider-native traces; no project `.coding-sess` migration source remains. |
| Known gaps | Several documented gaps are real. | `CoPlan.md` notes `--norec` is parsed but not wired, walk discovery is tested but not a production caller, query uses only `roots[0]`, config validation is scan-centered, Cursor global/workspace semantics are unclear, and CLI help is global rather than command-specific. | This is a good revive project because the next work is concrete integration and compatibility, not invention from scratch. |
| Possible next product | A status ledger for all active work, not just a historical importer. | It can read Codex app `threads`, project git state, surviving `.codess` stores, Cursor/Claude traces, and maybe GitHub remotes. | Best near-term target: `codess status` that outputs project rows like this report: name, path, git, recent sessions, dirty state, stage, and next action. |

Recommended Codess revival order:

1. Keep `~/Work/Code/CodeSess` canonical; the stale lowercase duplicate has been removed.
2. Add a Codex app adapter for `~/.codex/state_5.sqlite`, `~/.codex/logs_2.sqlite`, `~/.codex/session_index.jsonl`, and `~/.codex/history.jsonl`.
3. Fix the documented plumbing gaps: `--norec`, walk-first discovery, multi-root query, config validation for ingest/query, Cursor global/workspace counting.
4. Implement `codess status` as the first truly useful command: summarize projects and sessions without requiring a prior per-project ingest.

## Transcript / AVTrans Cluster

This cluster is an audio/video transcription-service comparison site, but the deeper purpose was broader: prototype a way to convert messy online vendor/feature research into a structured informational website. It stalled in the implementation details: TypeScript/JavaScript app wiring, data conversion, store choice, and the boundary between research artifacts and site-ready records. The datastore path kept shifting between PostgreSQL/Prisma, Redis/static files, and compiled CSV/JSON/TypeScript data; the web prototype then accumulated local WIP that currently breaks the build.

| Work | Path | What It Is | Stage | Assessment |
|---|---|---|---|---|
| Transcript planning repo | `~/Work/Github/Transcript` | Product/design/planning docs for a vendor-comparison platform: PRD, research, storage strategy, schema/types, security, search, vendor docs. | Branch `develop`; remote `gh:fear-ai/transcript`; local `develop` is one commit ahead of `origin/develop` at `2d173f8 Copyright notices`; untracked `Compare/CompG.txt`. | Keep as product-research record and strategy source. It is not the current app implementation. |
| AVTrans web app | `~/Work/Github/Transcript/avtranscript` | Next.js/TypeScript app for the vendor directory and comparison site. Includes pages, vendor cards/lists, complexity/adaptive-display system, generated vendor data, and data-pipeline scripts. | Branch `develop` in sync with `origin/develop` at `f404e2e STATUS`, but local WIP is dirty: modified status/components/package, deleted CSVs/config/styles/validator, untracked `STATUS0.md` and `logs/`. | This is the implementation worth inspecting before archive/revival. Current WIP should be either reverted or completed deliberately, because it removed parts the docs call core. |
| Datastore attempt | `TranscriptStorage.md`, `docs/DataPipeline.md`, `docs/VendorDataMigration.md`, `avtranscript/data`, `avtranscript/scripts`, `avtranscript/lib/data` | Storage designs evolved from PostgreSQL/Prisma to Phase I compiled files, then CSV -> JSON -> static TypeScript with smart caching and validation. Current generated data exists: 25 vendors, 25 affiliates, `lib/data/vendors.ts`. | Phase I data pipeline was documented as complete, but local WIP removed `data/vendors.csv`, `data/affiliates.csv`, `validate-affiliates.ts`, and data-pipeline package scripts/dependencies from `package.json`. | The datastore problem was not lack of a plan; it was too many plans plus partial implementation churn. Best revival path is compiled JSON/TS only for MVP, then postpone database/Redis. |
| Research-to-site prototype | `TranscriptResearch.md`, `TranscriptSearch.md`, `docs/TranscriptVendors.md`, `docs/TranscriptChoices.*`, `docs/vendor-extended.ts`, `avtranscript/data` | The intended pipeline was: gather vendor/service/feature/pricing research online, normalize it into comparable records, validate it, then render an informational comparison site. | So far unsuccessful as a repeatable workflow. Research docs and generated data exist, but the conversion/store layer never settled into a simple durable shape. | This is the important reusable idea. Revive it as a tiny research-to-record pipeline before treating it as a web product. |
| Web side | `avtranscript/pages`, `components`, `providers`, `utils`, `types` | Working Next.js structure with homepage/find/about/privacy/terms/demo pages, vendor list/card components, complexity provider, error utilities, generated data. | `npm run type-check` passes. `npm run build` fails because `pages/_app.tsx` imports deleted `../styles/globals.css`. | The web side is near-revivable, but current local WIP is broken. First fix is restoring or replacing the deleted style/config files, then validating the vendor directory page. |
| Documentation sprawl | `avtranscript/*.md`, `Transcript/docs/*.md`, `Save/Transcript*.md` | Many overlapping docs: Phase I, site design, implementation, test plans/results, command docs, CSV issues, error priorities, vendor research, storage, data migration. | Docs themselves identify documentation drift and recommend consolidation. | Preserve high-signal docs, but do not keep expanding them. Create one `STATUS.md` plus one `ProjectSpecifications.md`; archive the rest after extracting unique requirements. |

Recommended AVTrans disposition:

1. Treat `~/Work/Github/Transcript/avtranscript` as the implementation repo and `~/Work/Github/Transcript` as the planning/research repo.
2. Decide whether the current dirty deletions in `avtranscript` were intentional. If not, restore `styles/globals.css`, `tailwind.config.js`, `postcss.config.js`, CSVs, validator, and package scripts/dependencies from `HEAD`.
3. Reframe the MVP as research-to-site conversion, not a full web app: one vendor research note -> one typed record -> one rendered card/list page.
4. Keep the MVP datastore simple: generated JSON/TypeScript from 25 vendor records. Do not revive PostgreSQL/Redis until the static site is stable.
5. Make the build pass, then check `/find` and vendor cards at desktop/mobile widths.
6. Consolidate docs into a small status/spec pair before adding features. The docs already warn that documentation sprawl was slowing implementation.

Modern retry note:

- AVTrans may deserve another try because newer AI design/app tools can now cheaply generate the UI exploration that previously consumed too much TS/JS effort. The reusable target should remain research-to-site conversion, not a general database-backed SaaS.
- Use AI design/build tools for disposable layout and interaction drafts, then port only the useful parts into a repo-owned static Next.js app. Avoid letting the tool own the source of truth for data.
- Recommended stack: Figma Make or v0 for UI exploration; repo-owned Next.js/Vercel for implementation; JSON/TypeScript generated records for data; optional Supabase only after the static research-to-record pipeline works.
- Guardrail: do not start with auth, reviews, accounts, PostgreSQL, Redis, or scraped-update automation. Those are Phase II+.

Schema realism note:

- The universal schema idea may be unreasonable as a standards project. Decades of practice suggest most teams define fields in the local database/API context of the day and move on.
- The useful version is narrower: bounded canonical records for a specific research-to-site or monitor-to-site pipeline, plus source-specific adapters, provenance, confidence, and raw-source retention.
- For Fedload and AVTrans, schema work should not aim to solve Person/Company/Product/etc. forever. It should make one domain's input research reliably become useful records and pages.

## Decision Table: Wrap Up

| Work | Paths | Call | Why |
|---|---|---|---|
| spank-py | ~/Work/Spank/spank-py | Wrap-up / maybe superseded | Python SPL-compatible engine has local WIP but Rust HECpoc/spank-rs seems to have taken the lead. Preserve API lessons, publish/close package state, then stop carrying ambiguous WIP. |
| mcpconf / mcpred | ~/Work/Code/MCP/MCPs/mcpconf_cl; mcpconf_gpt5; mcpred | Wrap-up | Useful MCP tooling, but older. mcpred has local WIP. Decide if these become maintained tools or archive with final README/status. |
| Transcript / avtranscript | ~/Work/Github/Transcript; ~/Work/Github/Transcript/avtranscript | Wrap-up or revive narrowly | Planning and prototype state are documented. The web app type-checks but current WIP breaks build after deleting styles/config/data-pipeline pieces. Either restore/fix the static build prototype or archive as product research. |
| WP operational tools | ~/Work/WP/wpages; harduw; must-py; multiwp; wphack | Mostly wrap-up | Status files show concrete operational tools and next steps. If sites are no longer active, archive with final run instructions. If active, only harduw/wpages need light maintenance. |
| CContext / cStudy / older AI tool forks | ~/Work/Claude/CContext; ~/Work/Code/CodingTools/* | Archive unless a specific dependency exists | Mostly older or fork-derived work. Keep only if another active project imports them. Fedload is no longer included here; it belongs to the Fedload/labor/specification cluster above. |

## Clearly Superseded Or Discounted

| Work | Paths | Assessment |
|---|---|---|
| CodeSess duplicate | ~/Work/Code/CodeSess | Resolved: `CodeSess` matches GitHub `origin/main` at `3f1991a`; the stale lowercase checkout was removed on 2026-07-05. |
| Clean OSS research packs | ~/Work/Spank/sOSS; ~/Work/Claw/Emails; ~/Work/Claw/Claws; most ~/Work/ZK/ZKs | Discounted. Useful for rapid review, but not revival candidates without local changes or own remotes. |

## Current Codex Session Anchors

| Title | Path | Updated | Git | Tokens |
|---|---|---|---|---|
| how to share sessions between this laptop and this application and with online and with other... | `~/Work/Spank/spank-rs` | 2026-07-05 15:22 | gh:fear-ai/spank-rs | 70076332 |
| Review Algorithms | `~/Work/Spank/spank-rs` | 2026-07-02 03:37 | gh:fear-ai/spank-rs | 5288784 |
| /Users/walter/Work/Spank/HECpoc, start with HECpoc.md working on a standardized test harness ... | `~/Work/Spank/spank-rs` | 2026-06-25 06:35 | gh:fear-ai/spank-rs | 225540426 |
| Spank Max | `~/Work/Spank/spank-rs` | 2026-06-06 00:31 | gh:fear-ai/spank-rs | 929195176 |
| Read Setpack and ClawInfo.md | `~/Work/Claw/setpack` | 2026-04-28 19:19 | gh:fear-ai/setpack | 297236069 |
| review ClawInfo.md; update all information and credential fields and values from files in ~/... | `~/Work/Claw` | 2026-04-12 22:13 | none | 102503620 |
| update | `~/Work/Claw/openclaw` | 2026-04-11 00:06 | gh:fear-ai/openclaw | 22844830 |
| explain /fast performance and cost | `~/Work/Claw/openclaw` | 2026-04-09 22:58 | gh:fear-ai/openclaw | 210536382 |
| /model gpt-5.3 | `~/Work/Claw/openclaw-docs` | 2026-03-13 13:54 | gh:fear-ai/openclaw | 28454502 |
| codex app | `~/Work/Claw/openclaw-docs` | 2026-03-11 21:09 | gh:fear-ai/openclaw | 15504 |
| restart | `~/Work/Claw/openclaw` | 2026-03-05 19:01 | gh:fear-ai/openclaw | 35179871 |
| review README and AGENTS | `~/Work/Claw/openclaw` | 2026-02-21 01:17 | gh:fear-ai/openclaw | 234024510 |
| echo hello | `~/.openclaw-repo/workspace` | 2026-02-15 11:44 | none | 19318 |
| Write a single-file Python script called hello.py that prints 'Hello from Codex' and the curr... | `/private/var/folders/yv/_m_tr_gd78n0k4823cvcz26h0000gn/T/tmp.b33iQ5imk1` | 2026-02-12 12:02 | none | 33830 |
| check ~/.codex/config.toml | `~/Work/Claw/openclaw` | 2026-02-05 01:37 | gh:fear-ai/openclaw | 244416 |
| feature | `~/.codex` | 2026-02-05 01:30 | none | 20146 |
| read AGENTS.md | `~/Work/WP/harduw` | 2026-01-03 18:07 | gh:wkarshat/harduw.git | 519183 |
| read AGENTS.md WPages.md Status.md | `~/Work/WP/wpages` | 2026-01-02 02:25 | gh:fear-ai/wpages | 61995607 |
| restart | `~/Work/WP/wpages` | 2025-12-29 09:32 | gh:fear-ai/wpages | 63965 |
| report status | `~/Work/WP/wpages` | 2025-12-26 13:29 | gh:fear-ai/wpages | 94933919 |
| Read WPages.md and two Python scripts | `~/Work/WP/wp` | 2025-12-22 12:20 | gh:fear-ai/wpages | 4988474 |
| for WordPress site zero.directory db.out file contains output of mysql ... | `~/Work/WP/ZD` | 2025-12-21 17:32 | none | 1776804 |
| directories 2016-2021 contain image subdirectories ... | `~/Work/zduploads` | 2025-12-20 19:17 | none | 75889 |
| explain this codebase to me | `~/Work/CODE/codex/codex-rs` | 2025-11-16 00:25 | gh:openai/codex | 3720871 |

## Owned / Extended Repo Evidence

| Name | Path | Branch | Remote | Dirty | Last commit | Codex trace | Description |
|---|---|---|---|---|---|---|---|
| CContext | `~/Work/Claude/CContext` | main | gh:fear-ai/ccontext | 0 | 2026-03-25 41f13ce Updates |  |  |
| openclaw | `~/Work/Claw/openclaw` | codex/preserve-openclaw-april-fixes | gh:fear-ai/openclaw | 0 | 2026-07-06 2625fd92bb7 ignore local coding-session directories | review ClawInfo.md; update all information an; update | Preserved April Gmail, channel-secret, launchd, and UI work in four pushed commits. |
| openclaw-docs | `~/Work/Claw/openclaw-docs` | claw_emails | gh:fear-ai/openclaw | 0 | 2026-07-06 5d2592cb024 save OpenClaw email and repository state | explain /fast performance and cost; /model gpt-5.3 | Email/OpenClaw documentation checkpoint committed and pushed. |
| setpack | `~/Work/Claw/setpack` | codex/preserve-setpack-april-ops | gh:fear-ai/setpack | 0 | 2026-07-06 eac9afd mark Setpack shutdown checkpoint saved | Read Setpack and ClawInfo.md; review ClawInfo.md; update all information an | Runtime, repack, documentation, and shutdown state committed and pushed. |
| CodeSess | `~/Work/Code/CodeSess` | main | gh:fear-ai/codess | 2 | 2026-04-13 3f1991a Updates |  | Codess - Session record store |
| cStudy | `~/Work/Code/CodingTools/Cursor/cStudy` | main | gh:fear-ai/cStudy | 0 | 2026-02-15 e5492a7 Initial |  |  |
| claude-code | `~/Work/Code/CodingTools/claude-code` | main | gh:fear-ai/claude-code | 0 | 2025-07-07 ecaf0d8 chore: Update CHANGELOG.md |  | Claude Code |
| claude-deob | `~/Work/Code/CodingTools/claude-deob` | main | gh:fear-ai/claude-code-deobfuscation | 0 | 2025-03-01 ced7586 don't mix up the terms silly. |  | Claude Code (Research Preview) Cleanroom Deobfuscation |
| codex-rs0 | `~/Work/Code/CodingTools/codex/codex-rs0` | notes | gh:wkarshat/codex-rs0 | 0 | 2025-11-16 5386f537 Added Codex Resource and Shell files |  | Quickstart |
| geminiCLI | `~/Work/Code/CodingTools/geminiCLI` | main | gh:fear-ai/geminiCLI | 0 | 2025-07-08 f7ad9a7 Fix infinite loop in start.js on Windows (#3506) |  | Gemini CLI |
| mcpconf_cl | `~/Work/Code/MCP/MCPs/mcpconf_cl` | develop | gh:fear-ai/mcpconf_cl | 0 | 2025-08-11 0231179 mypy and isort Python code |  | Project Status - mcpconf MCP Server Registry |
| mcpconf_gpt5 | `~/Work/Code/MCP/MCPs/mcpconf_gpt5` | develop | gh:fear-ai/mcpconf_gpt5 | 0 | 2025-08-13 35386f8 Text fixes and docs |  | Project status |
| mcpred | `~/Work/Code/MCP/MCPs/mcpred` | develop | gh:fear-ai/mcpred | 2 | 2025-08-13 6ed3cb9 Undate Docs |  | mcpred - MCP Red Team Client |
| apps-examples | `~/Work/Code/MCP/apps-examples` | main | gh:wkarshat/apps-examples | 0 | 2025-11-17 2724141 Merge pull request #121 from openai/chore/readme-update |  | Apps SDK Examples Gallery |
| apps-ui | `~/Work/Code/MCP/apps-ui` | main | gh:wkarshat/apps-ui | 0 | 2025-11-23 4084ad5 0.2.0 |  | Apps SDK UI |
| Misses | `~/Work/Code/Misses` | main | gh:fear-ai/falla | 6 | 2026-06-27 55101b0 Updates |  | Misses - README |
| Transcript | `~/Work/Github/Transcript` | develop | gh:fear-ai/transcript | 1 | 2025-09-15 2d173f8 Copyright notices |  | Transcript Platform - Project Status |
| avtranscript | `~/Work/Github/Transcript/avtranscript` | develop | gh:fear-ai/avtranscript | 12 | 2025-08-21 f404e2e STATUS |  | Transcript Platform - Project Status |
| fedloadw | `~/Work/Github/fedloadw` | develop | gh:fear-ai/fedloadw | 2 | 2025-06-19 7ca6725 docs: update all documentation files to use consolidated shell commands |  | FedLoad |
| HECpoc | `~/Work/Spank/HECpoc` | main | gh:fear-ai/hecpoc | 3 | 2026-06-24 e57799e working state |  | HECpoc - Focused HEC Receiver Design |
| spank-py | `~/Work/Spank/spank-py` | main | gh:fear-ai/spank-py | 5 | 2026-04-19 95a4734 naming and pipeline / index redesign |  | Spank |
| spank-rs | `~/Work/Spank/spank-rs` | main | gh:fear-ai/spank-rs | 1 | 2026-06-06 5c788fd Initial and Updates | Share sessions across devices; Review Algorithms; HECpoc |  |
| claudec | `~/Work/WP/claudec` | main | gh:fear-ai/claudec | 0 | 2026-01-03 c6b80da Initial |  |  |
| harduw | `~/Work/WP/harduw` | main | gh:wkarshat/harduw | 0 | 2026-01-13 95f44d0 Update Harden | read AGENTS.md | Status |
| multiwp | `~/Work/WP/multiwp` | main | gh:fear-ai/multiwp | 0 | 2026-01-25 982048c load |  | WordPress Multisite Tools |
| must-py | `~/Work/WP/must-py` | main | gh:fear-ai/must-py | 0 | 2026-02-04 096b3d0 Implementation |  | Must - Multisite Ubuntu Server Tools |
| wpages | `~/Work/WP/wpages` | main | gh:fear-ai/wpages | 0 | 2026-01-02 0138def Final tweaks | read AGENTS.md WPages.md Status.md; restart | Status for WPages tooling and tests |
| wphack | `~/Work/WP/wphack` | main | gh:fear-ai/wphack | 4 | 2025-11-07 ce891a9 hacker remove about.php notes.php |  |  |
| Docs | `~/Work/ZK/Docs` | master | gh:zerocurrencycoin/Docs | 1 | 2026-06-08 ec31306 Initial - Zero community designs |  | Zero-Docs |
| bitcore-lib-zero | `~/Work/ZK/ZKs/insight/bitcore-lib-zero` | master | gh:zerocurrencycoin/bitcore-lib-zero | 0 | 2026-06-23 5e80363 Transaction.fromBuffer: re-throw parse failure with parsed version + bu |  | Get Started |
| bitcore-node-zero | `~/Work/ZK/ZKs/insight/bitcore-node-zero` | master | gh:zerocurrencycoin/bitcore-node-zero | 0 | 2026-06-23 3f40bc5d bitcoind hardening: _initZmqSubSocket closes any stale sub socket befo |  | Install |
| insight-api-zero | `~/Work/ZK/ZKs/insight/insight-api-zero` | master | gh:zerocurrencycoin/insight-api-zero | 0 | 2026-06-23 901a3cc Crash #3 (oversized-response OOM): bound the address-summary txid list  |  | Insight API (Zero) |
| insight-ui-zero | `~/Work/ZK/ZKs/insight/insight-ui-zero` | master | gh:zerocurrencycoin/insight-ui-zero | 0 | 2026-06-23 48f226a Versions and updates |  | Install |
| Zero400 | `~/Work/ZK/Zero400` | 401-tests | https://tearodactyl@github.com/zerocurrencycoin/Zero | 0 | 2026-06-22 110b588e0 Initial |  | -LAUNCH DATE: 2017-02-19 |
| ZeroMac | `~/Work/ZK/ZeroMac` | zero-merge | gh:zerocurrencycoin/Zero | 9 | 2026-03-09 147cf9932 Docs |  | -LAUNCH DATE: 2017-02-19 |
| insight-api-zero | `~/Work/ZK/insight/insight-api-zero` | master | gh:zerocurrencycoin/insight-api-zero | 0 | 2020-07-16 dec6b29 update readme |  | Insight API |
| zerowallet400 | `~/Work/ZK/zerowallet400` | zerowallet-400names | gh:zerocurrencycoin/zerowallet | 0 | 2026-03-11 e3c0b22 .gitignore Makefile |  | Installation |
| zerowalletmac | `~/Work/ZK/zerowalletmac` | wallet-smallqt | gh:zerocurrencycoin/zerowallet | 0 | 2026-03-10 f244791 Merge zerowallet-merge into wallet-smallqt |  | Installation |

## Reference-Pack Audit

### Claw Project State: 2026-07-06

`~/Work/Claw` contains three different classes of material that should not be managed as one project root: authored integration work, replaceable upstream references, and runtime-pack state.

The non-archival scan found 40 Git working roots: 16 under `Claws`, 18 under `Emails`, the two linked OpenClaw worktrees, `setpack`, and three repositories embedded in Setpack runtime/cache directories. Because the OpenClaw worktrees share one common Git repository, working-root count is intentionally not the same as independent-project count.

| Path | Git state | Disposition |
|---|---|---|
| `openclaw` | Clean `codex/preserve-openclaw-april-fixes`, pushed to `fear-ai/openclaw`; four preservation commits on top of `feat/mails` | Keep branch as the durable April code record. Port individual fixes to current upstream only after revalidation. |
| `openclaw-docs` | Clean `claw_emails`, pushed at `5d2592cb024` | Keep as the durable Gmail/auth/runtime and repository-status checkpoint. |
| `setpack` | Clean `codex/preserve-setpack-april-ops`, pushed at `eac9afd` | Syntax, generation, sourcing, PATH, and idempotence checks pass. The destructive full `--force` lifecycle test remains deferred. |
| `Claws/NemoClaw` | Local-only `nemow13` branch contains commit `24d5f3f` adding the 638-line `NemoClaw.md`; one lockfile line remains uncommitted | Preserve the branch through a personal fork or private bundle before treating the clone as replaceable. |
| `Emails/himalaya` | One tracked build override: Rust 1.82.0 -> 1.90.0 | Keep as an explicit local patch only if current builds require it. |
| `Emails/neverest` | Upstream-clean except untracked `.DS_Store` | Remove the incidental file; source is replaceable. |
| `Setpacks/openclaw/ocrepo/openclaw/workspace` | Repository has no commits and eight untracked workspace/runtime entries | Not a project repository. Never publish `.openclaw` state; either initialize a deliberately filtered private history or remove the accidental `.git`. |
| `Setpacks/openclaw/today/openclaw/workspace` | Local history plus 3,202 tracked deletions and nine untracked entries | Treat as private operational history. Decide whether its deleted email exports are an archive before removing or retaining `.git`. |
| `Setpacks/openclaw/apr20/.../.codex/.tmp/plugins` | Clean temporary clone of `openai/plugins` | Regenerable cache; safe to remove when the pack is inactive. |

The two OpenClaw worktrees share the same repository and branch namespace. They are separate working directories, not independent clones or projects.

The four explicit reference packs contain 128 Git repositories. Remote ownership distinguishes 121 upstream clones from seven locally controlled Zero repositories. A clean upstream clone is a replaceable reference cache; a locally controlled remote or dirty worktree is not.

| Pack | Repositories | Upstream clones | Locally controlled | Dirty |
|---|---:|---:|---:|---:|
| `~/Work/Spank/sOSS` | 55 | 55 | 0 | 1 |
| `~/Work/ZK/ZKs` | 39 | 32 | 7 | 2 |
| `~/Work/Claw/Claws` | 16 | 16 | 0 | 1 |
| `~/Work/Claw/Emails` | 18 | 18 | 0 | 2 |

The seven locally controlled repositories inside `ZKs` are `tearodactyl/insight` plus six `zerocurrencycoin` repositories: `zerowallet-light-cli`, `lightwalletd`, `bitcore-node-zero`, `bitcore-lib-zero`, `insight-api-zero`, and `insight-ui-zero`. Keep them out of bulk upstream-clone cleanup.

### Modified Pack Repositories

| Repository | Remote/class | Local state | Assessment |
|---|---|---|---|
| `ZKs/insight` | `tearodactyl/insight`; locally controlled | Four modified documentation/config files; 71 additions, 25 removals | Intentional Zero Insight work. Preserve and commit or patch; not a disposable reference clone. |
| `ZKs/bitcoin-src` | `bitcoin/bitcoin`; upstream, detached | Untracked 13 KB `Zeros` multisig/signet tutorial | Unique local test/tutorial material. Move or commit it before replacing the clone. |
| `Emails/himalaya` | `pimalaya/himalaya`; upstream | `rust-toolchain.toml` changes Rust 1.82.0 to 1.90.0 | Deliberate local build override. Record as a patch or revert after testing; never delete with the clone unnoticed. |
| `Claws/NemoClaw` | `NVIDIA/NemoClaw`; upstream plus local-only branch | `nemow13` commit adds `NemoClaw.md`; `package-lock.json` adds the already-declared direct `ajv` dependency | Preserve the authored document commit outside this untracked local branch. The lockfile line is secondary and can be kept only with a reproducible dependency reason. |
| `sOSS/python-json-logger` | `nhairs/python-json-logger`; upstream | One trailing blank line in `defaults.py` | No semantic change; safe to revert after confirmation. |
| `Emails/neverest` | `pimalaya/neverest`; upstream | Untracked `.DS_Store` only | Incidental metadata; safe to remove. The source clone is otherwise clean. |

### Particularly Large Repositories

Sizes include generated content and Git history, so they are not measures of unique work.

| Approx. size | Repository | Class / main cause |
|---:|---|---|
| 687 MB | `sOSS/otel/opentelemetry-collector-contrib` | Clean upstream source/history |
| 495 MB | `ZKs/insight` | Locally controlled extended work |
| 462 MB | `sOSS/SecLists` | Clean upstream data/reference corpus |
| 360 MB | `sOSS/splunk/security_content` | Clean upstream data/reference corpus |
| 300 MB | `sOSS/wazuh` | Clean upstream source/history |
| 290 MB | `ZKs/bitcoin-src` | Upstream plus local `Zeros` tutorial |
| 275 MB | `ZKs/hush3` | Clean upstream source/history |
| 268 MB | `ZKs/pirate` | Clean upstream source/history |
| 263 MB | `Claws/ClawWork` | Clean upstream source/history |
| 226 MB | `sOSS/fluent-bit` | Clean upstream source/history |

### Dormant Generated Directories

The wider non-archival `~/Work` baseline found 108 directories named `target` or `node_modules`, totaling about 27.1 GiB. On 2026-07-05, all four listed Rust targets, all 27 `node_modules` directories under `~/Work/Code/MCP`, and the NemoClaw, sitit, and MCP servers root dependency trees were deleted. These passes removed 34 generated directories totaling about 14.20 GiB while retaining source and manifests.

One inactive/reference dependency directory remains as an exact cleanup candidate:

| Size | Generated directory | Containing work |
|---:|---|---|
| 55 MiB | `ZK/ZKs/insight/ecosystem/TENT/insight-ui-tent/node_modules` | Old nested upstream UI project |

It occupies about 55 MiB; the containing project retains its npm manifest and lockfile.

Excluded despite size: active `HECpoc/target` (4.6 GiB), AVTrans `node_modules` (409 MiB), the current Equihash requirements build (218 MiB), and separately handled Schema/skip work. Three Setpack bundle dependency trees total about 3.8 GiB; they are not listed because `node_modules` may be intentional bundle payload rather than a disposable development cache.

The OpenClaw source worktrees are now preservation rather than active-build environments. On 2026-07-06, their root `node_modules` directories (about 3.9 GiB) and `dist` directories (about 159 MiB) were deleted after confirming no process used either checkout. Source, manifests, lockfiles, branches, and pending documentation remain. The two `.codess` directories total about 75 MiB; two databases are byte-identical across worktrees, while the Codex database and ingest metadata differ, so consolidate only after confirming CodeSess ingestion coverage.

## Discounted Reference Clones

The 116 clean upstream clones in the four audited packs are replaceable reference caches. Within `~/Work/Claw`, 15 of 16 `Claws` repositories and 16 of 18 `Emails` repositories are clean upstream references. Keep the focused working shelf (`NemoClaw`, `nanoclaw`, `zeroclaw`, `hermes-agent`, `ClawWork`, `himalaya`, `neverest`, `gogcli`, `gmailsorter`, `inbox-zero`, `email-oauth2-proxy`, and `notmuch`/`isync`) and remove other clones as their comparison value expires. Additional clean SDK/framework clones under `~/Work/Github` and `~/Work/Code` remain outside this pack-specific count.

## Recommended Next Actions

1. Add a checked-in `STATUS.md` to `spank-rs` that points to `HECpoc`, `Bench.md`, and `SpankMax.md` and states the next three actions.
2. Preserve `~/Work/Github/truj`, then extract its 58-term labor dictionary, organization aliases, 42-item source manifest, publication schema, and three representative source fixtures into a small canonical ingestion pilot.
3. Make the first pilot milestone `raw artifact -> source mapper -> sparse normalized envelope -> JSONL -> inspection page`; defer dashboard breadth and database selection.
4. Extend canonical `CodeSess` to summarize Codex app `state_5.sqlite` and project `.codess` databases; the stale lowercase checkout has been removed.
5. For each wrap-up candidate, make one final commit or `ARCHIVE.md` stating why it is paused/superseded.
6. For dirty third-party clones, either commit the patch if it is intentional, export it as a patch file, or reset/archive the clone after review.
7. Keep clean OSS clones out of the active mental load. They are reference shelves, not projects.
