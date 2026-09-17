# ryans_apps — Consolidated Handover & Reference
*One document covering all 4 apps (`bapowersuite_dev`, `bapowersuite_customer`,
`personalsuite`, `shared_api_gateway`) plus standing rules and durable
technical reference. Replaces every prior per-app handover, project-
instructions doc, and standalone rules document — see "What this replaces"
at the very end for the full list.*

**Last updated: 15:51, 17 September 2026 (UK time)** — confirmed directly by Ryan.

---

## How to use this document

- **Section 1 (Quick reference)** — repos, URLs, paths. Look here first for any command.
- **Section 2 (Standing rules)** — how Claude should work across every session, every app.
- **Section 3 (Chronological log)** — recent history, newest first within each entry.
- **Section 4 (App-by-app)** — one sub-section per app: current state, confirmed working, backlog, known bugs.
- **Section 5 (Shared technical reference)** — design system, API-Football integration, plain-English API glossary. Durable, rarely changes.
- **Section 6 (Password Changes)** — the one non-development project in scope.

On **RESUME**, read Section 2 first (the rules), then jump straight to whichever app section 4.x is in scope. Don't re-read the whole document every session — it's organised so you don't have to.

---
---

# SECTION 1 — Quick reference
*SOURCE: `overview.md` · `ways-of-working.md` · `RESUME___FINISH_Commands_in_ClaudeAI.md` · `Ryan_s_Manual_Consolidation.md` · `RH-Consolidated-Documentation-LATEST.md` (B§0)*


All 4 repos now live under one local root:
`\\Mac\Home\Desktop\Claude.AI Projects\ryans_apps\` (Windows VM UNC path)
`/Users/cheekyry/Desktop/Claude.AI Projects/ryans_apps/` (Mac Terminal)

| App | Repo | Live URL(s) | Local subfolder |
|---|---|---|---|
| BA PowerSuite (dev) | `github.com/cheekyry/bapowersuite_dev` | `bapowersuite-dev.vercel.app` (also `rhayes-bapowersuite.vercel.app`) | `ryans_apps\bapowersuite_dev` *(inferred from naming convention — not personally verified this session; confirm at first BA PowerSuite session)* |
| BA PowerSuite (customer) | `github.com/cheekyry/bapowersuite_customer` | `bapowersuite-customer.vercel.app` (also `customer-bapowersuite.vercel.app`) | `ryans_apps\bapowersuite_customer` *(same caveat)* |
| Personal Suite | `github.com/cheekyry/personalsuite` | `rhayes-personalsuite.vercel.app` (also `rhayes-personal-suite.vercel.app`) | `ryans_apps\personalsuite` ✅ *verified live 17 Sep* |
| Shared API Gateway | `github.com/cheekyry/shared_api_gateway` | `shared-api-gateway.vercel.app` (also `rhayes-api-gateway.vercel.app`, `api.bapowersuite.com`) | `ryans_apps\shared_api_gateway` ✅ *verified live 17 Sep* |

`ryans_apps\docs\` — handover docs live here (this file goes here).
`ryans_apps\brand_assets\` — real brand assets (logo etc).
`ryans_apps\push_ryans_apps.ps1` — one script, pushes all 4 repos in one command, skipping any with nothing changed.

**Supabase:** one project shared by BA PowerSuite and Personal Suite — `rhayes-suite`, ID `qnpxprxhaciwtchrdqzn`, West EU/Ireland. Unaffected by the folder/repo/domain reorg (Supabase project identity is separate from any of that).

**git user.email** in all 4 repos: `ryan.hayes@bapowersuite.com` — verified correctly set in all 4 on 16.09.2026.

**Standard deployment sequence** (one command per code block, always):
```
pushd "\\Mac\Home\Desktop\Claude.AI Projects\ryans_apps\[app-folder]"
```
```
git add [filename]
```
```
git commit -m "[descriptive message]"
```
```
git push origin main
```
Mac Terminal: same, but `cd` with escaped spaces instead of `pushd`, and full literal paths (never `~`/`$HOME`).

**Before running `push_ryans_apps.ps1` in a fresh PowerShell window:** run `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` first, every time — only lasts that one window.

---
---

# SECTION 2 — Standing rules
*Applies to every project below unless a rule says otherwise. Development-only rules (git, device/paths, deployment) don't apply to Password Changes (Section 6).*

## 2.1 Command discipline
*SOURCE: `ways-of-working.md`*

- **ONE COMMAND PER MESSAGE, ALWAYS, NO EXCEPTIONS** — never give 2+ terminal/PowerShell commands in one reply, even for "quick verification checks." One command, wait for actual pasted output, then the next.
- Git push/deployment commands delivered in individual code blocks after every file delivery, without exception.

## 2.2 Naming & format
*SOURCE: `ways-of-working.md` · `RH-Consolidated-Documentation-LATEST.md` (A§6)*

- Naming convention: underscores, not hyphens, everywhere technical (folders, repos, keys) — e.g. `shared_api_gateway`, `bapowersuite_dev`. Naming consistency is a first-class requirement everywhere — local folders, repo names, Vercel project names, live domains, even secondary metadata (a GitHub repo's Website link) — since consistent naming is what makes the whole system comprehensible to Ryan as a non-developer.
- Date/time format: UK, with dots (`16.09.2026`), 24-hour time.
- Version numbers in filenames use dot notation (`v1.2`, never `v1_2`).
- Ryan's client UI calls the file-upload area for a Project **"Context"** — not "Project Knowledge." Always say "Context."
- Ryan uses a MacBook Pro — Mac shortcuts (Cmd not Ctrl, Option not Alt). Give exact PowerShell commands, never generic Git instructions.

## 2.3 Timestamp Workflow Rule — non-negotiable
*SOURCE: `Timestamp-Workflow-Rule.md` (originating document) · `ways-of-working.md` · `RH-Consolidated-Documentation-LATEST.md` (A§4)*

Confirm the current UK date/time directly with Ryan before stamping ANYTHING — every code delivery, every handover, and (expanded 17.09.2026) every feature request and decision too. **Never guess, estimate, or web-search for it** — search only returns stale cached pages, confirmed unreliable by direct test. If a reliable anchor already exists in the conversation (a timestamp Ryan shared), reason forward conservatively from it but say so plainly and still ask rather than presenting an estimate as confirmed. Log things chronologically as they happen, not reconstructed afterward from a long transcript.

*Why this exists:* an incorrect timestamp once caused two separate coding sessions to be assumed where there was only one — a wrong timestamp actively misleads later reasoning, it isn't cosmetic.

## 2.4 Session file discipline — the most critical rule
*SOURCE: `ways-of-working.md` · `RH-Consolidated-Documentation-LATEST.md` (A§5)*

Within a single session, every fix or feature must be built ON TOP OF THE LAST FILE CLAUDE ITSELF DELIVERED IN THAT SESSION — never re-pulled from Context/uploads mid-session, even to double-check. Context is read once, at session start; after that, don't touch it again until FINISH.
- Never reference `/mnt/user-data/uploads/` again after the initial copy to `/home/claude/`. Every edit chains from the previous one.
- If ever unsure which version is current, check for a specific known marker (a recent fix's code) — don't assume.

*Why:* re-pulling from Context mid-session has already caused a real, confirmed data-loss incident — a completed fix silently discarded.

## 2.5 Working style — asking, assuming, epistemics
*SOURCE: `RH-Consolidated-Documentation-LATEST.md` (A§6) · `ways-of-working.md`*

- **Never assume.** If anything is unclear, ambiguous, or a needed file/screenshot is missing — ask.
- Read screenshots fully and carefully before responding. If unclear or cut off, say so and ask Ryan to re-share.
- **Never guess and present it as a confident diagnosis.** If a bug's real cause isn't verified from actual evidence (error messages, test results, direct research), say so explicitly rather than a plausible-sounding theory stated with more confidence than earned. A wrong hypothesis stated confidently costs real time and real API money to disprove. Propose a way to gather evidence *before* proposing a fix.
- A confident-looking check can still be wrong — verify what a check is actually confirming, not just that it shows a tick.
- Distinguish "genuinely unavailable data" from "a bug" before reaching for a fix — they can look identical but be different in kind, and "fixing" correct behaviour by papering over it with stale/misleading data is actively harmful.
- **Proactive impact analysis on every new feature request**, and before any change with wider consequences: explain what will happen and get confirmation first. Propose first, get explicit confirmation, then build — never decide scope unilaterally.
- New feature requests raised mid-testing go on a running to-do list, not built immediately, unless explicitly asked for now.
- **Track confirmations explicitly.** Ryan says "confirmed" for something that works; don't assume something is confirmed just because he moved on to a new topic.
- Ryan strongly prefers interactive, clickable JSX/React artifacts over static exports or plain text.
- Use the interactive click-to-answer question tool for genuine either/or decisions, with pre-defined options — standing preference, not just a nice-to-have for any one task.

## 2.6 Validation before delivery — real execution required
*SOURCE: `RH-Consolidated-Documentation-LATEST.md` (A§7)*

Babel/syntax checking alone is not enough for anything touching React hooks, state ordering, or variable scope. Before delivering:
1. **Actually execute in a simulated browser** for meaningful component/scope changes — install `@babel/core`, `@babel/preset-react`, `react`, `react-dom`, `jsdom`; stub `getComputedStyle`/`localStorage`/`fetch`; run the transpiled script via Node's `vm` module; confirm `#root` genuinely receives rendered content, not just that the script didn't throw. Give it a moment via `setTimeout` to catch async render errors too.
2. **For scope bugs** (a component using a variable it doesn't have): a brace-accurate scan of every top-level component's variable usage against its own destructured params/local consts, using real brace-depth counting for function boundaries.
3. When fixing matching/scoring/aggregation logic, test with realistic mock data before delivering — don't just read the code and reason it looks right.

*Why:* a broad theming sweep across ~430 locations parsed and transpiled cleanly, but shipped a runtime `ReferenceError` (a component never received `theme` as a prop) that a syntax check cannot catch — Document tabs went black in production until found. A separate scoring fix looked correct on review but scored zero for everything when actually run (accent-normalisation bug, only caught by testing).

## 2.7 Handover documents
*SOURCE: `RH-Consolidated-Documentation-LATEST.md` (A§8) · `ways-of-working.md` (decision to unify into one document, 17.09.2026)*

When a chat limit is approaching, when starting a new chat, or on FINISH: produce a handover covering the entire session, and **overwrite this document — never append, never keep old versions.** One unified document now (see decision log, Section 3), not one per app.

## 2.8 RESUME / FINISH protocol
*SOURCE: `Session-Workflow-Rule-RESUME-FINISH.md` (originating document) · `RESUME___FINISH_Commands_in_ClaudeAI.md` · `ways-of-working.md` · `RH-Consolidated-Documentation-LATEST.md` (A§2, A§3)*

**On "RESUME" (any case):**
1. Ask which device Ryan is on right now (MacBook/Windows VM PowerShell, or iPad Working Copy+Textastic) — never assume from a previous session.
2. Ask Ryan to confirm he's pulled the latest on that device.
3. Confirm which app/repo is in scope, and that current working files are uploaded to Context — if either is missing, **stop and ask for both.**
4. Read this handover and the uploaded working file(s) fresh from Context — not from memory of prior conversation.
5. Copy the uploaded file(s) to `/home/claude/` immediately.
6. Confirm back: current line count(s), what's confirmed working, what's fixed-but-untested, what's outstanding, recommended next step — **before doing or building anything.**
7. A standing-rule document present in Context must be genuinely read, not just copied — a copy step alone doesn't make a rule active.

**On "FINISH":**
1. Summarise the session in three explicit buckets: confirmed working / fixed but not yet retested / still to do.
2. Update this handover — full replacement (Section 2.7).
3. Re-deliver the latest file(s) worked on, with filename + line count.
4. Give device-correct sync steps for whichever device was confirmed at RESUME — PowerShell `pushd` blocks for laptop/VM, Working Copy app-steps for iPad (Section 2.11).
5. Remind Ryan to verify the deployment is live at the project's URL (~60s after push) and that the new feature is actually there.
6. Remind Ryan to update Context (this handover + latest files) and the local folder on the device in use.
7. Remind Ryan never to leave uncommitted changes on one device overnight before switching — the "baton" principle.

## 2.9 Impact analysis
*SOURCE: `ways-of-working.md`*

Whenever Ryan requests a new feature, give a brief impact analysis alongside it, proactively surfacing closely-related functionality that would round it out. For anything beyond a small, obviously-safe addition, propose first and get confirmation before building.

## 2.10 Git discipline — the daily habit
*SOURCE: `Global-Rules.md` · `iPad-Mac-Git-Workflow-Quick-Reference.docx` · `Working-Copy-Textastic-Full-Setup-Handover.docx` · `Folder-Reorg-Handover-FINAL.md` · `ways-of-working.md` · `RH-Consolidated-Documentation-LATEST.md` (A§9)*

**The Golden Sync Rule: Pull → Work → Push → Switch → Pull → Work → Push.**
- Always `git pull` before starting work on any device — never assume local is current.
- Always push before switching devices. GitHub is the single source of truth — devices never sync directly with each other, and never via iCloud Drive.
- Never leave uncommitted changes on one device overnight.
- **A silent no-op pull is a red flag, not a clean result.** If `git pull` reports success but nothing changes despite known new commits, run `git branch -vv` to check the local branch tracks the correct remote (e.g. `origin/main`, not a stale `origin/master`). *Real incident: `personalsuite`'s `main` was tracking `origin/master` after an old default-branch rename — pulls silently reported "Already up to date" without merging. Fixed with `git branch --set-upstream-to=origin/main main`.*
- Add a `.gitignore` for local-only reference docs and OS junk (`.DS_Store`) so `git status` stays meaningful.
- Merge conflicts: on iPad, Working Copy offers "use mine"/"use theirs"/manual merge. For a single-file app, manually copying in the changes you want is usually easier than a line-by-line iPad merge. Treat it like a baton — only one device active per change.
- Sync direction between the two BA PowerSuite builds: always build/fix in `bapowersuite_dev`'s `baps_app.html` first, then manually copy the equivalent section into `bapowersuite_customer`'s `customer_baps_app.html` second — dev is canonical, customer is a trimmed derivative. No git-native sync between them (separate repos) — this is a manual checklist item at the end of any session touching shared code.
- When a downloaded file is manually moved into place, verify it landed correctly using a check specific to that exact file's own unique content (a comment string that ONLY exists in that file) — never a generic check that could pass on the wrong file. *Real incident: a file named `claude-batch-results.js` actually contained a different file's code, and a shared-pattern check missed it.*

## 2.11 Device handling, paths, and iPad workflow
*SOURCE: `Global-Rules.md` · `iPad-Mac-Git-Workflow-Quick-Reference.docx` · `Working-Copy-Textastic-Full-Setup-Handover.docx` · `RH-Consolidated-Documentation-LATEST.md` (A§10, A§12)*

- Confirm at the start of every session whether Ryan is on Mac Terminal, Windows VM (PowerShell), or iPad — syntax and paths differ, and iPad has no shell at all.
- Mac Terminal: full literal paths, never `~`/`$HOME`. Windows VM: `pushd` with full UNC path, never `cd`/relative paths.
- The VM reaches Mac folders over a network share — moving/renaming a folder on the Mac changes both paths together.
- Expect a "detected dubious ownership" git warning the first time a newly-named/moved path is used from the VM — normal SMB behaviour, fix once per path with the `git config --global --add safe.directory ...` command git provides in the error.

**iPad (Working Copy + Textastic) — daily workflow:**
1. Working Copy → open the repo → tap **Pull** (download-arrows icon) — every session, before opening Textastic.
2. Get the updated file from Claude → save to Files app.
3. In Files, move/replace into the correct Working Copy repo folder (confirm "Replace").
4. Working Copy — changed file shows flagged orange.
5. Tap **Commit** (speech-bubble icon) → message → confirm.
6. Tap **Push** (upload-arrow icon).
7. Safari → vercel.com/dashboard → confirm new deployment.
8. Open the live URL, check the feature is actually there.

Key iPad facts: Working Copy's storage is separate/sandboxed, never an alias for iCloud Drive on either device. Never store a git repo inside an iCloud-synced folder — can corrupt the hidden `.git` history. Fetch only downloads; Pull downloads *and* merges — Pull is what you want before editing. Working Copy is per-device — a new device needs its own clone of all repos.

## 2.12 GitHub authentication & secrets
*SOURCE: `Global-Rules.md` · `Folder-Reorg-Handover-FINAL.md` · `RH-Consolidated-Documentation-LATEST.md` (A§11)*

- Authentication via **Git Credential Manager** — never a token in the remote URL. `git remote -v` should always show a clean URL.
- Any secret exposed in plain text (chat, screenshot, logs, a Context document) is treated as compromised immediately: revoke/regenerate at source, re-point every affected repo's remote, re-authenticate via Credential Manager. *Already happened once — a fine-grained PAT covering all repos was exposed via a `git remote -v` paste and was rotated.*
- Secrets live in **Vercel environment variables only** — never in a repo, never in a Context document, never in chat.

## 2.13 Structure and safety
*SOURCE: `Global-Rules.md` · `Folder-Reorg-Handover-FINAL.md` · `RH-Consolidated-Documentation-LATEST.md` (A§13)*

- Moving/renaming a **parent** folder (not touching contents) is always safe — GitHub/Vercel/git history don't care about local paths, only the remote URL.
- **Never move, rename, or restructure anything inside a folder literally named `api/`** in a Vercel-deployed project — every file in it is a live serverless endpoint.
- Keep app repos and gateway/API repos separate — never merge into one repo.

## 2.14 End-of-session sync habit
*SOURCE: `Global-Rules.md` · `RH-Consolidated-Documentation-LATEST.md` (A§14)*

At the end of every development session: (1) pull latest on whichever device is used next, (2) re-upload changed file(s) into that project's Context. Proactively remind Ryan of both — never wait to be asked.

## 2.15 Proactive Context-refresh flagging
*SOURCE: `ways-of-working.md`*

Never wait for Ryan to ask whether Context needs refreshing. Flag it proactively after a significant round of file changes, before an important new chat, or whenever live files have meaningfully diverged from Context — and always spell out the complete steps: which files changed, the exact commands to rebuild locally, and a reminder to re-upload.

---
---

# SECTION 3 — Chronological log
*SOURCE: this session's own record, plus dated entries drawn from `ryans_apps_handover.md` (prior draft) · `RH-Suite-Handover-Template.md` · `BA-PowerSuite-Handover-Template.md` · `BA-PowerSuite-Handover-BoE-Checklist.md` · `Folder-Reorg-Handover-FINAL.md` · `Session-Workflow-Rule-RESUME-FINISH.md` · `Timestamp-Workflow-Rule.md`*

*Most recent first. Older entries condensed once fully superseded; nothing here duplicates Section 4's current-state detail — this is sequence, not status.*

- **15:51, 17.09.2026** — Uploaded all ~19 remaining documents from the local "Claude - Handovers, Instructions & Memory" folder. Read all 26 documents (including this doc's own prior draft and `RH-Consolidated-Documentation-LATEST.md`, itself an earlier full consolidation of 18 documents into Parts A–D). Consolidated everything into this single document, confirmed with Ryan that BA PowerSuite's backlog and Personal Suite's ML prediction tracking are both still exactly as their source documents describe (nothing touched since), and confirmed dropping the verbatim 22-theme-config backup appendix (superseded by the planned theme-builder feature, logged in 4.1's backlog) since the live app's `THEMES` array is the real source of truth.
- **03:30, 17.09.2026** — Previous session closed. Cross-device state persistence for Personal Suite's Football tab (Scout→Build) confirmed working end-to-end, laptop→iPad. `shared_api_gateway`'s CORS fix and the `_cors.js` refactor confirmed working across all 3 frontends. Decided to retire the per-app handover pattern in favour of this single document.
- **17.09.2026, earlier** — Diagnosed and fixed `shared_api_gateway/api/fixtures.js`'s stale CORS allowlist (broke Football fixtures for every competition at once after the repo/domain reorg). Extracted the duplicated CORS logic out of all 8 gateway endpoints into a new shared `api/_cors.js` module. Built cross-device state persistence for Personal Suite (new `personal_football_session` table; hit and fixed a real RLS-vs-GRANT permissions gotcha along the way).
- **16.09.2026** — The 4-app folder/repo/domain reorg completed: `rhayes-bapowersuite`→`bapowersuite_dev`, `customer-bapowersuite`→`bapowersuite_customer`, `rhayes-personal-suite`→`personalsuite`, `rhayes-api-gateway`→`shared_api_gateway`. All under one `ryans_apps` root and one merged Claude project. git `user.email` verified correct in all 4.
- **22:55, 11.09.2026 (Personal Suite)** — Major session: full ML prediction tracking built (`personal_predictions` table, logging, lenient grading, expanded market coverage including corners/cards/player markets with fuzzy name matching, "Check results" + score backfill) and a full second analytics build ("Prediction Analytics" — by team/market/competition/confidence, calibration chart, drilldown everywhere, weekly trend). Several real bugs found and fixed along the way (a donut-vs-header accuracy mismatch, a hooks-in-conditional-render crash). See 4.3 for full current state.
- **10.09.2026 (BA PowerSuite)** — Customer-facing build (`customer_baps_app.html`) created as a separate repo/Vercel project; CORS added for it across the gateway; a tier/licence display bug fixed (cosmetic only — real tier-gating still doesn't exist); duplicate branding removed. The 16-feature tiering review completed and fully decided. See 4.1/4.2 for full detail.
- **7–8.09.2026 (BA PowerSuite)** — The old AI Generator / Agile Backlog / Batch Generate tabs fully retired (navigation + ~3,470 lines of dead code deleted), replaced by the unified 🧭 Generate + 📋 Jobs screen. Full in-place editing built for all four content types in the Library Browser — the change that actually unblocked the old tabs' retirement.
- **24.08.2026 (BA PowerSuite side-chat)** — BoE prep tooling planned (tiered 29-product list for Ryan's new Bank of England role); later built as a dedicated, Ryan-only "BoE Prep" tab (1 Sep), excluded from the customer build (10 Sep) — closed.
- **5–7.09.2026** — The Timestamp Workflow Rule and the RESUME/FINISH session protocol both formally established, after real incidents (a wrong handover date caused a false "two sessions" read; device confusion risked wrong commands).
- **Earlier (6.09.2026 and before)** — Full Mac/Windows VM/iPad folder reorganisation completed (three repos at the time), GitHub token rotated after an accidental exposure, auth migrated to Git Credential Manager, a stale branch-tracking bug found and fixed, Working Copy + Textastic rebuilt from scratch on iPad. Closed project — see 2.10/2.11 for the durable lessons; no further action needed.

---
---

# SECTION 4 — App-by-app reference

## 4.1 BA PowerSuite — dev (`bapowersuite_dev`)
*SOURCE: `BA-PowerSuite-Handover-Template.md` (2,541-line original, sessions to 10 Sep 2026) · `BA-PowerSuite-Handover-Template-LATEST.md` · `RH-Consolidated-Documentation-LATEST.md` (B§1, B§1a–B§1f, B§7) — which itself absorbed `BA-PowerSuite-Project-Instructions.md` and its duplicate `.txt`*


**Identity & environment**

| | |
|---|---|
| Company | BA PowerSuite Ltd |
| git user.email | `ryan.hayes@bapowersuite.com` |
| App file | `baps_app.html` — single file, ~15,995 lines as of the last confirmed count (7 Sep) |
| DNS | GoDaddy — `bapowersuite.com`; `api` CNAME → Vercel (`api.bapowersuite.com`) |

**Stack:** plain HTML/JS, no bundler/npm/build step. React 18 UMD via cdnjs. Babel Standalone 7.23.5, in-browser transpile. SheetJS (`xlsx.full.min.js`) for client-side Excel exports. Supabase queried directly from the browser via `fetch()`. **Babel + Web Workers don't mix — never use Web Workers.**

**Local Flask server** (`ba_powersuite_server.py`, `localhost:7842`) — runs only on Ryan's Mac, **not** on Vercel. Powers SDLC Templates / Requirements→RTM / Encyclopedia only — all three therefore **fail immediately for every real deployed user**, since the deployed app can't reach `localhost`. This is also what breaks the licence/tier fetch (see 4.2). All heavy exports (draw.io, Visio, Excel step table) are fully client-side and don't need Flask.

**Key constants:** `SUPABASE_URL = "https://qnpxprxhaciwtchrdqzn.supabase.co"`; `API = "http://localhost:7842/api"` (the dead local-only address above).

**Supabase tables:** `baps_requirements`, `baps_workflows` (one row per product per detail level each), `baps_agile_backlog` (`content_type`: `agile_backlog`|`gherkin_only`), `baps_generate_batch_jobs`, `baps_batch_jobs`, `baps_custom_products`.

**`vercel.json`** — `{ "version": 2, "rewrites": [ { "source": "/", "destination": "/baps_app.html" } ] }`. **Load-bearing** — this project has no `index.html`, so `/` depends entirely on this rewrite. If ever touched again: verify `/` itself loads afterward (not just the changed route), and check Vercel's **Source** tab for what's actually deployed rather than trusting the browser (caching masks failures). The `/library` redirect was never re-added after an earlier emergency fix — low priority, the standalone page is gone anyway, but worth fixing properly next time this file is touched.

**Current navigation:**
- **🧭 Generate** (unified, sub-tabs 🎯 Generate / 📋 Jobs) — replaced the old AI Generator/Agile Backlog/Batch Generate tabs entirely (retired 7–8 Sep)
- **ANALYSE:** Analysis Tools, Process Tools, Quality Tools, Delivery Tools (each a multi-tool group — see feature-review table below)
- **DOCUMENT:** SDLC Templates, Requirements→RTM, Encyclopedia — all three **non-functional in production** (dead `localhost` dependency), decided HIDE
- **MANAGE:** Custom Products (dead code — superseded by Generate + Library Browser's working custom-product mechanism, recommended for retirement), Library Browser, Settings, 🏛️ BoE MBPR Prep Checklist (Ryan-only)

**AI generation:** `genR()` (requirements) and `genW()` (workflow steps) both do a complexity-analysis step first (→ module/phase list with counts calibrated to Basic/Intermediate/Full/Expert tiers), then per-module/phase generation calls, with progressive partial results.

**Export functions (all client-side):** `buildBAPSSVG`, `buildDrawioXMLAsync` (must stay async with `yieldToBrowser()` between phases — sync version crashes the tab at 60+ steps), `buildStandardBPMN20XML` (**primary export for Bank of England use** — see below), `buildLucidCSV`, `buildVisioCSV`, `buildStepTableXLSX`.

**Library Browser** (`UnifiedLibraryBrowser`) — Command View + Dashboard View + 🕒 Batch History. Supabase-only, no Flask dependency. **Full in-place editing for all four content types** lives here — the single biggest capability addition since the Generate screen, and what unblocked retiring the old tabs. Includes Epic-level insert/delete/move with cascading renumber, flattened Gherkin scenario editing, a genuinely separate Workflow Steps draft+Apply editor, Requirements editing including a fixed numbering bug, and a confirmation warning before discarding unsaved edits. **Revert/Save are always visible during editing — only the "Unsaved edits" badge is conditional** (a past bug had both conditioned on `dirty===true`, making them vanish on save).

**Custom product/process entry** — reuses the exact same generation prompts as registry products, no different treatment. `baps_custom_products` table; `getEffectiveProducts()` is the one centralised place registry+custom products merge.

**Vertical short codes** — 14 hand-curated 4-letter codes (`VERTICAL_CODE`/`getVertCode()`), applied across 9 real call sites. **Product-level codes (`prodCode`) have NOT been collision-checked across ~562 products** — backlog item.

### Bank of England tooling
*SOURCE: `BA-PowerSuite-Handover-BoE-Checklist.md` · `RH-Consolidated-Documentation-LATEST.md` (B§1a)*

Ryan's BoE role (MBPR — Markets, Banking, Payments & Resolution, Leeds) uses **Sparx Systems Enterprise Architect**, not draw.io/Lucidchart/Visio. `buildStandardBPMN20XML()` is therefore the primary export for real BoE work — confirmed working with a real EA trial (imports cleanly, correct shapes, drilldown via `callActivity`/`calledElement`). One still-open question: whether EA's drilldown auto-wires or needs a manually-set Tagged Value — Ryan to check via right-click → "Navigate to Called Element" and the Properties → BPMN2.0 tab.

The BoE Prep tab itself (29-product tiered checklist, derived from Supabase) was built and is Ryan-only, excluded from the customer build — **closed**, not outstanding.

### Confirmed working (as of the 10 Sep BA PowerSuite session, unchanged since)
Unified Generate+Jobs screen, full submission/retrieval/auto-retrieval for all four content types · full in-place editing for all four types · custom product entry · 23-theme rollout + Instant Theme Preview Panel · `panelAccent`/`cardAccent` theming (88 sites) · vertical short-code table (9 call sites) · customer-facing build deployed and regression-checked.

### Fixed but not individually retested
The 44-instance `T.amber`/`T.blue` hex-fallback sweep (Delivery Tools especially) — deployed on Ryan's own call. Theme Preview Panel touch/long-press on mobile — untested on the Claude mobile app.

### Backlog — confirmed still fully open (per Ryan, 17.09.2026)

**Next, in order:**
1. **Test every export function in the Library Browser — highest priority, nothing verified since the app moved to web/cloud.** Priority order and findings so far:
   - **BPMN 2.0 XML** — structurally fine but needs a genuine hands-on EA import test, not just well-formedness. Highest stakes (the BoE path).
   - **Visio CSV** — likely needs to be XLSX, not CSV. Ryan wants to research the correct format together before any code change.
   - **Jira CSV** — well-formed, untested against a real import (no Jira access yet). Epic Link vs Epic Name field may need adjusting.
   - **ADO CSV** — generated, untested (no ADO access).
   - **Excel Step Table** — genuinely good; two cosmetic fixes agreed: clickable Overview links to phase tabs, and showing the real phase name alongside "Phase NN" in the Summary sheet and within each phase's own sheet.
   - **Lucidchart CSV** — **confirmed genuinely broken** (imports as unlabelled identical squares, no shapes/labels/flows). Ryan wants a real-demand assessment before deciding whether to keep investing here.
   - **draw.io** — layout fixes applied, not re-confirmed.
   - **Proprietary BA PowerSuite SVG** — Ryan increasingly doubtful this is worth continued investment (a bank is unlikely to accept a proprietary format). Not decided.
   - **JSON (all 4 types)** — well-formed, real-world use case not yet settled (data portability / custom tooling / backup / debugging — not confirmed with Ryan).
2. **End-of-review discussions** — whether tiers should be genuinely two-dimensional (price × role); naming the second unnamed feature group (Policy Translator/AS-IS-TO-BE/Workshop Questions); Data Dictionary's own area.
3. **Build the feature-visibility config screen and real tier-gating** — the destination the whole feature review has been building toward. Nothing built yet.
4. **Proof of concept** (packaging/licensing) — Supabase Auth + `customer_id` schema + RLS → Lemon Squeezy checkout/webhook → `orders` table (gate generation on **confirmed payment only**) → stripped customer Library Browser → `customer_id` tagging on saves → a real end-to-end test as Ryan's own customer. Cost-bearing is decided (centralised on Ryan's key, manual review first — **any future flat-price tier needs a hard quota, non-negotiable**). Master content pool is bidirectional by design (customer-generated content becomes visible to Ryan too, structurally — no customer ID on master rows, a separate link table records access). Needs a real, verified (non-sandbox) Lemon Squeezy account, which can't be accelerated by a build session.
5. **Cosmetic review pass** — deliberately deferred.
6. **Cost measurement** — Agile-from-Requirements/Workflow not yet measured (the per-story prompt is unchanged so ~$0.085/story should roughly hold, but total now scales with source-item count — worth a real test before trusting by inference); several tiers across Requirements/Workflow/Gherkin still unmeasured. See the measured-so-far table below.
7. **NEW (17.09.2026, Ryan's request):** a full **theme-builder feature** — let users customise the colour of every individual UI element, not just pick a preset theme. Explicitly an accessibility requirement (colourblind users need their own colour choices), not just personalisation. This is *why* `panelAccent`/`cardAccent` were originally built as named, explicit fields on each theme object rather than computed inline — a picker needs a concrete field to point at and override. **Standing convention: every new themeable concept must be a real named field on the theme object, never derived/inline.** The old 22-theme verbatim backup was deliberately dropped from this document (17.09.2026) in favour of this planned rebuild — the current `THEMES` array in the live app is the only source of truth until the builder replaces it.

**Known gaps from the 16-feature review, not yet fixed:**
Requirements Quality Checker takes pasted text rather than pulling from the Library automatically · Policy Translator doesn't save directly to the Library · AS-IS/TO-BE has no export at all (plus an enhancement request: let Ryan supply a real, already-documented AS-IS process — free text or an Excel file shaped like the Step Table export — rather than only AI-generating one) · Data Dictionary has no export at all · RACI Matrix's CSV export is mislabelled in the UI as "Excel."

**Backlog, low priority, not forgotten:**
Product-level short-code (`prodCode`) collision check across ~562 products · orphaned superseded rows accumulating silently (every save is a plain POST, no upsert/delete — functionally fine since reads always take the newest row, but old rows persist and count toward storage; low priority, confirmed by Ryan) · workflow step-type summary colours too subtle against at least one dark theme (keep the shared hex values matching the draw.io export; add a separate darkened display-only variant instead) · a targeted "regenerate only what's missing" action preserving existing IDs (distinct from full regeneration; needs its own prompt design and a decision on how it interacts with `original_*` Revert baselines) · exports should include the banking vertical (filename + a field/column), all formats, all 4 types — "not now, only when we find an issue" · export filename convention should append content-type consistently, matching how Requirements already does it · Excel formatting + branded header row (see boxed decision below) · EA callActivity drilldown open question (above) · draw.io/Lucidchart/Visio re-tests · S53 warnings · AC-count-6 tuning · Structured Outputs migration · `/library` redirect still broken · specific unregenerated items (EP-CB-DD-01-GH16, EP-CB-MB-01-US07, EP-CB-MB-02-US05) · Bug 12 · Bug 10 (participant dropdown in Step Editor) · Bug 11 (auto-scroll/expand on Add Step at End).

> **Excel formatting/branding — investigation already done, don't redo it.** Ryan's own reasoning: his logo/branding genuinely represents his company and effort — this isn't cosmetic polish to him. Confirmed achievable with the current library (`xlsx.full.min.js`): AutoFilter dropdowns, sensible column widths. Confirmed **NOT** achievable with it (empirically tested by building and inspecting real output XML): any cell styling at all — bold, fill, wrap, alignment all silently dropped on write. Three options, not yet decided: **A** — `xlsx-js-style` fork, same API, styling confirmed working, but no embedded images so a real logo graphic likely isn't achievable; **B** — stay put, filters/widths only; **C** — investigate ExcelJS (confirmed via research to support both styling and embedded images, but not yet empirically tested the same rigorous way as A/B). **Given Ryan's priority on a genuine logo, C is the likely right starting point**, but hasn't been build-and-inspect verified yet.

### Real measured cost data (record every real before/after comparison here, without exception)

| Content type | Tier | Measured cost | Confidence |
|---|---|---|---|
| Requirements | Basic | $0.06/product | Confirmed 3× |
| Requirements | Expert | $0.37/product | Real — 54-product run, $19.87 total |
| Requirements | Intermediate/Full | not measured | — |
| Workflow Steps | Basic | ~$0.06/product | Small sample only, never re-validated at scale |
| Workflow Steps | other tiers | not measured | — |
| Agile Backlog | From Scratch (legacy) | $4.68/product · $0.0851/story | Still accurate for manual use |
| Agile Backlog | From Req/Workflow | not measured | Prompt unchanged, should roughly hold — worth a real test |
| Gherkin | From Requirements, Basic | $0.0935/requirement | Real |
| Gherkin | From Workflow Steps, Basic | $0.0799/step | Real |
| Gherkin | Intermediate/Full/Expert | not measured | — |

### Feature review — all 16 decided (10 Sep 2026)

Ground rules: at least two versions long-term (customer + Ryan's full build); a hide-ability config screen in Settings (Ryan-only); customer version shows only purchased-tier features; **never lose code**, only hide/disable unless explicitly confirmed gone for good; discuss each feature, decide keep/hide then tier; every decision provisional until a final reorganisation pass.

| # | Feature | Decision | Tier | Area |
|---|---|---|---|---|
| 1 | Stakeholder Analysis | KEEP | Upper | — |
| 2 | Requirements Quality Checker | KEEP | Upper | assesses against IIBA BABOK criteria; CSV+Word export |
| 3 | Project Initiation Pack Generator | KEEP | Upper | — |
| 4 | Gap Analysis | KEEP | Upper | Procurement/Vendor Evaluation |
| 5 | Vendor Comparison | KEEP | Upper | Procurement/Vendor Evaluation |
| 6 | Business Case | **HIDE** | — | AI-calculated NPV/IRR is a real-money risk class Ryan can't currently validate — see reasoning below |
| 7 | Policy Translator | KEEP | Upper | unnamed group |
| 8 | AS-IS/TO-BE | KEEP | Upper | same unnamed group |
| 9 | Workshop Questions | KEEP | Upper | same unnamed group |
| 10 | Meeting Minutes | KEEP | **ALL tiers** | genuinely universal, low-friction |
| 11 | Data Dictionary | KEEP (export needed) | Upper | area still undecided |
| 12 | RACI Matrix | KEEP | Upper | — |
| 13 | Sprint Planning | KEEP | Upper | — |
| 14 | SDLC Templates | HIDE | — | dead localhost dependency; banks likely have own templates anyway |
| 15 | Requirements→RTM | HIDE | — | same dead dependency |
| 16 | Banking Encyclopedia | HIDE | — | same dead dependency |
| — | BoE Prep | Ryan-only | — | excluded from all customer tiers |

*Not candidates at all — core infrastructure:* Custom Products, Library Browser, Settings.

**Business Case reasoning, preserved:** NPV/IRR/payback/sensitivity are AI-calculated within the text response, not a deterministic formula engine — LLMs are genuinely unreliable at precise multi-step arithmetic, and a confidently-wrong NPV in a real investment document is a worse error class than anything else reviewed. Ryan's own call: given the complexity and his own lack of expertise to validate it, he doesn't feel confident shipping it — not a verdict on the feature's value. Revisit if the calculation is ever made deterministic or independently validated.

**Product-level observation (Ryan's):** even within "upper tier," features split by *who'd* use them (BA-oriented vs PM day-to-day), not just value/complexity — worth a two-dimensional tier (price × role) at the final reorganisation pass.

### Known bugs & durable engineering patterns (read before any theming/scope-sensitive change)
- **`T.amber`/`T.blue` exist only on `rhayes_dark`** — any code referencing them renders invisible text on the other 22 themes. Fixed (46 occurrences, literal hex fallbacks) but not individually retested — watch Delivery Tools especially.
- **A component not receiving `theme`/`T` as a prop is a proven crash risk** if anything inside references `T.xxx` — always check scope before assuming a token substitution is safe (this is the root cause of the black-screen incident in 2.6).
- **`useEffect` dependency arrays are evaluated eagerly** — a new effect referencing a `useState` variable declared further down the same function is a genuine reference-before-initialization bug. New effects must go after the state they reference.
- **Unguarded async effects → stale-response races** — found independently 3× (Library Browser pill nav, both tier-loading pickers). Apply a cancellation guard by default in any async effect.
- **`fetch()` only throws on network failure, never on an HTTP error response** — always check `response.ok` explicitly; a bare `catch{}` made real Supabase rejections invisible, very likely the cause of a "0 succeeded" count-reversion bug.
- **Postgres `eq.full` never matches NULL** — remember an OR-null filter when a column may be legitimately unset on older rows.
- **State inside a conditionally-rendered tab component is destroyed on tab navigation** (full unmount). Anything that must survive navigation belongs at App level.
- **Babel blank-screen** — usually a backtick parity error in JSX/template literals; check before delivery. **Babel + Web Workers don't mix.**
- **A React component defined inside another remounts every render**, losing input focus — always define components at top level.
- **draw.io export must stay async** with `yieldToBrowser()` between phases (sync crashes the tab at 60+ steps).
- **SheetJS writes to `Uint8Array`** — wrap in a `Blob` for download.
- **Supabase POSTs should use `Prefer: return=minimal`.**
- **Filenames:** sanitise with `.replace(/[^a-z0-9]/gi,"_").replace(/_+/g,"_").replace(/^_|_$/g,"").toLowerCase()` to avoid triple-underscores from special characters.
- **openpyxl writes `inlineStr`** — `COUNTIF` won't work; convert to shared string refs for Excel formulas.
- **Phase names** must be stored in both `phaseStepsMap[]` and the workflow object's `phases[]` — required for multi-page exports to show real names.
- **BPMN 2.0 XML:** `<bpmndi:BPMNDiagram>` needs an explicit `name=`, and sequence-flow labels need explicit `<bpmndi:BPMNLabel><dc:Bounds>` or converging labels overlap visually.
- **Never break Personal Suite** when touching the shared gateway.

---

## 4.2 BA PowerSuite — customer (`bapowersuite_customer`)
*SOURCE: `BA-PowerSuite-Handover-Template.md` (customer-build session, 10 Sep 2026) · `RH-Consolidated-Documentation-LATEST.md` (B§2)*


| | |
|---|---|
| App file | `customer_baps_app.html` |
| `vercel.json` | rewrites `/` → `/customer_baps_app.html` |

**What it is:** a full copy of `baps_app.html` with Business Case, SDLC Templates, Requirements→RTM, Encyclopedia and BoE Prep removed from navigation — code untouched everywhere else, nothing deleted (ground rule 4, section 4.1). A genuinely separate GitHub repo/local folder/Vercel project, not a branch — Ryan's explicit preference for cleaner separation.

**Sync convention:** always fix in `baps_app.html` (canonical) first, then manually copy the equivalent section into `customer_baps_app.html` second. Manual checklist item, not automatic.

**CORS:** origin added to the gateway's allowlist (now centralised in `shared_api_gateway/api/_cors.js` — see 4.4), confirmed live with a real generation call and no regression on the dev site.

**🚨 No real tier-gating exists in either build.** Both fetch licence/tier info from the same dead `localhost:7842/api/status` — the call always fails silently, so `isUnlocked()` always returns true for everything. A tier/licence *display* bug (showing "Command Centre · DEV · Developer" on the live customer site) was fixed cosmetically — both files now default sensibly (`baps_app.html` → "professional"/"Ryan Hayes"; `customer_baps_app.html` → "customer"/a placeholder name) — **but the underlying no-real-licence-data gap is unchanged.** Real tier-gating is backlog item 3 in section 4.1.

Duplicate branding (a redundant small logo block under the main header) was removed from both files.

---

## 4.3 Personal Suite (`personalsuite`)
*SOURCE: `RH-Suite-Handover-Template.md` (11 Sep 2026, most detailed) · `RH-Suite-Handover-Template-LATEST.md` · `RH-Consolidated-Documentation-LATEST.md` (B§3, B§4) — which itself absorbed `RH-Suite-Project-Instructions.md` · `Personal_Apps_-_Football_Tab.txt` (accumulator rule) · this session's work (state persistence)*


**Identity & environment**

| | |
|---|---|
| App files | `app.js`, `fixtures.js` (now split across `shared_api_gateway`'s `api/` — see 4.4) |
| PWA files | `manifest.json`, `sw.js` (pass-through, no caching), `icon.svg` |
| AI | Anthropic API (`claude-sonnet-4-6`) via the gateway |
| Fixtures | API-Football Pro ($19/mo, 7,500 req/day) via the gateway |
| Bookmakers | **Betway, Betfred, SpreadEx.** Midnite is fully retired — never reference it. |

**Stack:** plain HTML/JS, single `app.js`, no bundler/npm. React 18 UMD via **unpkg**. Babel Standalone 7.23.6, in-browser JSX. React hooks destructured globally in `index.html` before the Babel script tag. **Never suggest npm/Node/webpack/any build step.**

**Supabase tables:** `personal_shopping`, `personal_pantry`, `personal_budget`, `personal_health`, `personal_tasks`, `personal_football`, `personal_bets` (already migrated — don't re-suggest), `personal_predictions` (ML prediction tracking, see below), `personal_football_session` (cross-device state persistence, new 17.09.2026 — see below).

**⚠️ Standing behavioural rule for AI bet recommendations (Ryan's explicit correction, preserved verbatim in spirit):** never put all analysed legs into one straight accumulator — **6 legs is the maximum for any single straight acca.** Not every analysed/selected match has to be used in the final recommendation — use judgement to leave out legs that aren't confident enough, exactly as if betting real personal money, rather than force-fitting everything in.

### Football tab — current state
AI-powered analysis via the gateway; fixture *data* from API-Football. Live tab in-play stats are still manual entry (screenshot upload) — no live data feed exists for that.

**Cross-device state persistence (NEW, 17.09.2026, confirmed working end-to-end):** one row (`id='current'`) in `personal_football_session`, debounced 1.5s autosave, restore-on-load — covers Scout's fetched fixtures and full analysis through Build's legs, stake plan, and AI verdict. Works symmetrically in either direction (laptop↔iPad); starting a genuinely new Scout search simply overwrites the saved session on the next autosave. **Known limitation, by design:** if the app is open on two devices simultaneously, last-to-autosave wins with no merge and no warning — built for sequential use, not concurrent. **New-table gotcha to remember:** an RLS "allow all" policy alone isn't enough — Postgres also needs an explicit `GRANT` to the `anon` role before RLS is even evaluated ("permission denied for table" is the signature). `ALTER DEFAULT PRIVILEGES ... GRANT ... TO anon` has been run for this project, so future new tables should inherit this automatically — worth a sanity check if a brand new table ever silently fails to save.

**ML prediction tracking (`personal_predictions`) — fully built, confirmed working (11 Sep session, reconfirmed accurate 17.09.2026):**
- "📝 Log all predictions" on Scout results logs the main Home/Draw/Away call *and* every structured market tip, grouped by fixture. Free-text main predictions are translated to canonical Home/Away/Draw by matching real team names — falls back to ungraded raw text if genuinely ambiguous, never guesses.
- Market-tip format tightened to exact canonical market/selection pairs; grading  made lenient as a safety net for older data/slip-ups.
- Grading coverage: Match Result, BTTS (+ 1st/2nd half variants, Team-to-Score-in-Both-Halves, Score-in-Both-Halves — these were a real bug, now correctly distinguished from plain BTTS), Both-Teams-to-Score-&-Result, Asian/European Handicap, Corners/Cards/Player markets (selective data fetch to avoid rate limits; player markets need 80%+ fuzzy-name-match confidence or stay manual).
- **Permanently manual by design, not a bug:** First/Last Goalscorer, First Corner, First Card (need event-timing data this app doesn't fetch), Bet Builder, free text.
- "🔄 Check results" (same review-then-apply-all pattern as bets) also stores the real final score, enabling drilldown. "🧩 Fill in missing scores" backfills anything graded before scores were saved.
- **Prediction Analytics tab** — by side/market/competition/team(no threshold)/confidence-band, main-vs-market-tips split, weekly accuracy trend, confidence calibration chart, outcome donut, full drilldown on every breakdown including calibration. Hand-rolled SVG/CSS (no charting library — no build step to bundle one).

### Confirmed working (carried forward, unless superseded above)
Belgian League/Saudi Pro League/USA-MLS additions · Stake Plan grouping + in-app chat · batch analysis retry-and-split on parse failure · top-ranked fixture shown in Scout's results header · "Add fixture manually" with autocomplete · EFL Cup + MLS league-ID overrides (`LEAGUE_ID_OVERRIDES`).

### Backlog — still open
- **Standalone screenshot/leg analysis** — upload any screenshot, describe the bet, assess/re-assess, without it needing to be part of a saved/built bet.
- **Live tab** — ability to clear the list of bets from the "WHICH BET IS THIS" dropdown.
- Duplicate/copy a logged bet.
- "Last edited" trail on History cards.
- **Bet Group display bug** — the group wrapper sometimes stops showing after Phase 3 auto-apply, even though `bet_group_id` is confirmed intact in Supabase. Confirmed client-side display bug, not data loss — root cause not yet found.
- Deterministic BACK/MARGINAL/AVOID verdict logic testing (Tests A–E) — postponed by Ryan to a dedicated session.
- Leg Analytics (Phase 2) — built, waiting on real bet volume to be meaningful.
- Live tab and History tab testing — still pending.
- EV nudge 15-point threshold — may need retuning against real-world results.
- Photos app — parked pending Expo native setup.
- Club Friendlies zero-fixtures, occasionally missing standings — likely a genuine API-Football coverage gap, not a bug (see 5.2's shot-stats/standings fallback note for why "no standings yet" is sometimes the honest, correct answer).

---

## 4.4 Shared API Gateway (`shared_api_gateway`)
*SOURCE: `RH-API-Gateway-Handover-Template-LATEST.md` · `RH-Consolidated-Documentation-LATEST.md` (B§5) · this session's work (`_cors.js` refactor)*


| | |
|---|---|
| Hosting | Vercel Pro |
| Model | `claude-sonnet-4-6` |
| Repo structure | `.js` files live in `api/` (Vercel requirement — one file = one live serverless endpoint). `package.json`/`vercel.json` at repo root. ES module project (`"type":"module"`). |

**8 endpoints**, all now importing a shared `api/_cors.js` module (`ALLOWED_ORIGINS` array + `applyCors()` helper) rather than each carrying its own duplicated CORS allowlist — built 17.09.2026 specifically because `fixtures.js`'s own copy had gone stale during the reorg while the other 7 stayed current, breaking every Football fixture at once:

| File | Endpoint | Purpose |
|---|---|---|
| `claude.js` | `/api/claude` | Main single-call Anthropic gateway. What every "Generate" button across all 3 frontends hits. |
| `claude-batch-submit.js` / `-status.js` / `-results.js` | `/api/claude-batch-*` | Anthropic Message Batches API — submit / poll / fetch |
| `fixtures.js` | `/api/fixtures` | API-Football data. **Serves Personal Suite only.** Modes: normal fetch, `lookupOnly`, `enrichFixtures` (batch standings/H2H/prediction/shot-stats), `listCountry` (debug). |
| `resolve-login.js` | — | Username→email lookup for BA PowerSuite login (dev/customer) |
| `create-user.js` / `manage-users.js` | — | User account management for BA PowerSuite |

`create-user.js` and `manage-users.js` pass `{ allowAuthHeader: true }` to `applyCors()` to keep their extra `Authorization` header requirement — every other endpoint only needs `Content-Type`.

**🚨 SHARED — the single most important constraint on this repo:** serves BA PowerSuite (dev), BA PowerSuite (customer), and Personal Suite. Any change must stay backward-compatible with all three, especially **never break Personal Suite's Football Bet Analyser.** No staging environment, no test suite — a push goes straight to production for all three. Regression-check against at least one other frontend before considering any change done.

**Secrets** — `ANTHROPIC_API_KEY` (Ryan's key bears all generation cost across every frontend — why any flat-price tier needs a hard quota, see 4.1) and `API_FOOTBALL_KEY` (sent as `x-apisports-key`) — both in Vercel environment variables only.

**Rate limiting has been hit directly** against API-Football — `fixtures.js` caches league lookups and limits concurrency rather than firing every request simultaneously.

**Open items:**
- `claude-batch-results.js` discards Anthropic's per-response `usage` data — passing it through would let the apps compute real dollar cost automatically (verify current Batch API pricing at implementation time, don't rely on memory).
- `vercel.json`'s specific contents have never been reviewed.

---
---

# SECTION 5 — Shared technical reference
*Durable, rarely changes. Read once, not every session.*

## 5.1 Design system — the R Hayes theme
*SOURCE: `Theming-Handover.md` (authoritative, copied from Personal Suite's live code) · `BA-PowerSuite-Theme-Handover.md` · `RH-Consolidated-Documentation-LATEST.md` (B§6)*

Apple Dark Mode: black/white/red, Calibri. Personal Suite is the source of truth; BA PowerSuite's default theme (`"R Hayes"`, id `rhayes_dark`) is aligned to match it exactly.

**Design tokens** — one `T` object, everything references it, nothing hardcodes hex inline:
```javascript
const T = {
  bg: "#000000", surface: "#1c1c1e", surfaceAlt: "#2c2c2e",
  border: "#3a3a3c", borderAccent: "#555558",
  text: "#ffffff", textMid: "#ebebf5cc", textDim: "#ebebf599", textFaint: "#3a3a3c",
  accent: "#ff3b30", accentDim: "#3a0a08", accentGlow: "rgba(255,59,48,0.13)",
  gold: "#ff3b30", goldDim: "#3a0a08",
  green: "#32d74b", red: "#ff3b30", amber: "#ff9f0a", purple: "#ff3b30",
  font: "'Calibri', 'Segoe UI', sans-serif",
  mono: "'Calibri', 'Segoe UI', sans-serif",
};
```
`gold`/`red`/`purple`/`accent` are all literally the same hex — a red-accented dark theme, not multi-hue; the extra names exist for a possible future split, don't assume distinctness. `textMid`/`textDim`/`textFaint` are the same white at different opacities — hierarchy via opacity, not colour. A separate blue `#5ac8fa` (not in `T`) covers a neutral/Void state. Font is Calibri throughout, no separate monospace face.

**Shared style objects** (defined once per render function, reused everywhere): `inp`, `btnPri` (solid accent fill), `btnGhost` (transparent/bordered, secondary actions), `card` (surface/border/radius/padding — every discrete item is a card, never a raw row), `lbl` (tiny/bold/uppercase/letter-spaced section labels), `tabBtn`/`subTabBtn`.

**Layout conventions:** cards not tables/bare lists · buttons sized by role not page (`btnPri` for primary, `btnGhost` for secondary, never one-off styles) · inline emoji icons (🔍📋⚡🎯✏️🗑📊⚠️✅❌), no icon font/SVG library · semantic colour mapping (green/red outcomes, amber warnings/in-progress, blue `#5ac8fa` neutral/void) used consistently for anything win/loss/warning/neutral-shaped.

**⚠️ Status colour must be a badge, separate from any control showing that status** — setting a `<select>`'s own text colour bled into every option on native dropdown-open (a browser quirk, not CSS-fixable). Pattern: a small coloured `<span>` badge next to the control, never colour the control itself. No emoji inside `<option>` elements either (inconsistent cross-browser rendering caused a real alignment bug).

**BA PowerSuite's theme architecture** (differs — it's multi-theme): `THEMES` array (23 presets) + `useTheme()` + `applyThemeVars()` (CSS custom properties) + a shared `S={}` object using `tv()` for components not receiving `theme` as a prop. **BPMN diagram notation colours are deliberately NOT themed** — that's BPMN standard convention, not app chrome. **Known deferred gap:** a hardcoded gold constant (`G`/`GL`/`GOLD`/`GOLDL`) near the top of `baps_app.html` doesn't reflect the live theme in a few older tabs — fix is `tv("--theme-accent")` etc., deferred at Ryan's request. **The planned theme-builder feature** (4.1 backlog) is why every new themeable concept must be a real named field on the theme object, never derived/inline.

*Scope boundary:* this is theming only — doesn't cover either app's feature logic, data model, or schema. Build new components fresh with these tokens rather than porting one app's component into the other wholesale.

## 5.2 API-Football integration — permanent reference
*SOURCE: `RH-Suite-Project-Instructions.md` (§7a, absorbed into RH-Consolidated-Documentation-LATEST.md B§4) · `RH-Consolidated-Documentation-LATEST.md` (B§4)*

- Base URL `https://v3.football.api-sports.io`; auth header `x-apisports-key` (never in chat/docs, Vercel env var only).
- `country` param can't contain spaces — hyphens (`Czech-Republic`).
- Competition labels use `"Country - Name"`, parsed by splitting on `" - "`.
- Broad regions (Europe, South America, International) map to the literal value `"World"`.
- **Season year must be derived from the actual date queried** — most European leagues label by start year (Aug–May); South America/Scandinavia/Ireland/South Korea use calendar-year seasons. Getting this wrong looks exactly like "no fixtures found."
- When name-matching fails: anchor on a known real team via `/teams` + `/leagues?team={id}&season={year}` rather than guessing more name variants, but score results by name too (a team can play multiple simultaneous competitions). Use "Verify All League IDs" to check every competition in one pass rather than spot-checking; use "Debug: List All Leagues For A Country" to see real API-side names rather than guessing a third alternate.
- `normalize()` strips accents via **NFD decomposition, not deletion** — a naive strip would make "Série B" and "Serie B" fail to match each other. Don't regress this.
- **No true xG exists in this API** — the app uses a clearly-labelled shot-volume/placement proxy. A real xG source would need a separate subscription (e.g. TheStatsAPI, ~$50/mo) — undecided, separate from this.
- Recent-form shot stats deliberately span both current and previous season, merged by date, across all competitions — most leagues barely started in July otherwise. **Standings deliberately do NOT get this fallback** — a stale table could actively mislead; "no standings yet" is the honest answer, not a gap to patch.
- The UI's fixture-renumbering step (for React keys) would silently overwrite the real API-Football fixture ID if not for it being preserved separately as `apiFixtureId`.
- **MLS gotcha, fixed:** fuzzy search resolved "USA - MLS" to league 866 ("MLS All-Star") instead of 253 (actual MLS), because "All-Star" contains "MLS" as a substring. Fixed via `LEAGUE_ID_OVERRIDES`, same pattern as the earlier EFL Cup fix.

## 5.3 Plain-English API glossary
*SOURCE: `RH-API-Guide-LATEST.md`*

*For anyone unfamiliar with API terminology — Personal Suite is "the customer," the gateway is "the waiter," API-Football/Anthropic are "the kitchen." This is why the gateway is a separate project: the apps only need to know how to order; API keys live in the gateway, never the apps.*

| Term | Meaning |
|---|---|
| Endpoint | A specific address for one job, e.g. `/api/fixtures` |
| GET / POST | "Give me info, nothing changes" / "here's info, act on it" |
| JSON | The plain-text parcel format almost every API uses |
| API key | A private password proving your app may use a service — lives in the gateway's env vars only |
| Environment variable | A secret setting supplied at run-time, never appearing in GitHub |
| Serverless function | Backend code that only runs when called — any file in Vercel's `api/` |
| Status code | 200 success · 400 malformed · 401/403 not authorised · 404 not found · 500 server error |
| Rate limit | A cap on requests per time window, set by the service you're calling |

---
---

# SECTION 6 — Password Changes
*SOURCE: `RH-Consolidated-Documentation-LATEST.md` (B§8) — itself reconstructed from stored project memory, not from an uploaded document*

*Non-development project — most of Section 2's rules are inert here beyond timestamps (2.3) and general working style (2.5). No repo, no Vercel, no git workflow.*

Systematically updating passwords across 150+ sites, combining **Claude in Chrome** (browser automation) with **Norton Password Manager**, tracked in `PasswordChangeTracker.xlsx` (Password Tracker sheet — 14 columns, priority-tier colour coding, 200 pre-formatted rows; Session Log; Instructions & Prompts).

**Phased plan:** Phase 1 (tracker built) — ✅ complete. Phase 2 — refine Claude-in-Chrome prompts for reliability. Phase 3 — live execution, one test site first, then scale to the full 150+.

---
---

# What this replaces
This single document supersedes and replaces the following, all now safe to delete once you're satisfied this captures everything genuinely current from them: `BA-PowerSuite-Handover-Template.md`, `BA-PowerSuite-Handover-Template-LATEST.md`, `BA-PowerSuite-Project-Instructions.md`, `BA-PowerSuite-Project-Instructions_md.txt` (pure duplicate of the above), `BA-PowerSuite-Theme-Handover.md`, `BA-PowerSuite-Handover-BoE-Checklist.md`, `RH-Consolidated-Documentation-LATEST.md`, `RH-Suite-Project-Instructions.md`, `RH-Suite-Handover-Template.md`, `RH-Suite-Handover-Template-LATEST.md`, `RH-API-Gateway-Handover-Template-LATEST.md`, `RH-API-Guide-LATEST.md`, `Folder-Reorg-Handover-FINAL.md`, `Github___Pushd_Commands.md`, `Global-Rules.md`, `Personal_Apps_-_Football_Tab.txt`, `RESUME___FINISH_Commands_in_ClaudeAI.md`, `Ryan_s_Manual_Consolidation.md`, `iPad-Mac-Git-Workflow-Quick-Reference.docx`, `ways-of-working.md`, `Timestamp-Workflow-Rule.md`, `Theming-Handover.md`, `Session-Workflow-Rule-RESUME-FINISH.md`, `Working-Copy-Textastic-Full-Setup-Handover.docx`, `overview.md`.

**Not replaced** — still needed separately: `push_ryans_apps.ps1` (the actual script), the live app files themselves (`baps_app.html`, `customer_baps_app.html`, `app.js`, the 8 gateway `.js` files), and any SQL migration files still to be run.

**Dropped entirely, not carried forward:** the verbatim 22-theme-config backup (Ryan's decision, 17.09.2026 — superseded by the planned theme-builder feature; the live app's `THEMES` array is the only source of truth until then).
