---
name: dogfood
description: "Dogfood any app like the operator who depends on it - observe real behavior, harsh-score every surface, hunt the bug class, fix, verify, report. Use when user says dogfood, harsh review, 10/10 loop, fidelity audit, scroll feels fragile, look more like original, show evidence, prove it works, get to par, or audit like replacement."
---

# Dogfood

Become the most demanding user of the app and prove every claim with observed behavior. No credit for effort or approximations.

## STRICT GATE — 10/10 or stop

No step passes on partial work. Each step below has a GATE. Score that step 0-10. Advance only on 10/10. On 9 or below, loop that same step — do not advance, do not file a PR, do not babysit, do not claim done.

Final run passes only when re-scored surfaces are 10/10 on every surface (overall equals MINIMUM, never average). If 10/10 is honestly unreachable, the run FAILS unless step 6 names each blocker with its marker (TODO, status-reported no-op, documented gap) and step 7 states what still blocks 10/10 brutally.

## 1 - Orient

Read the project mandate (AGENTS.md or equivalent), whatever defines "correct" (spec, designs, docs, the original app), and recent session notes — assume prior verdicts are inflated. Claim a lane or task file before editing so parallel agents do not collide.

GATE (10/10 required to advance): you can state what "correct" looks like per surface and what the last claimed score was. If any surface has no definition of correct, score 0/10 for this step and stop.

## 2 - Build the observation harness first (reuse, do not rebuild)

Never trust a stale build or secondhand reports. Reuse the repo harness before inventing a new one:

1. Look for `tools/dogfood-harness.sh`, `tools/church-dogfood.sh`, `tools/CHURCH-DOGFOOD-MODEL.md`, `tools/church-dogfood-prompt.md`, or `DOGFOOD.md` in the repo. If found, use it as-is.
2. Only if missing, create `tools/dogfood-harness.sh` with verbs `smoke <folder>`, `shot <url>`, `pixel-diff <a> <b>` and commit it so the next session reuses it.
3. Verify it shows the FRESH build (rebuild + relaunch, then capture).

Pick the harness the framework allows:

- Web: headless browser screenshot + DOM snapshot + scripted clicks.
- Desktop: rebuild, relaunch, capture the live window backing store (headless captures often lie — verify pixels, not assumptions).
- Mobile: emulator/simulator screenshot + automation driver.
- CLI/API: scripted invocations capturing stdout, exit codes, and side effects.
- Universal fallback: computer-use (screenshot, move, click, type, key) drives ANY graphical app exactly like a human operator — prefer it when no framework driver exists or when you must prove the real user path.

Measure, don't eyeball: assert with whatever the platform offers — pixel diffs, accessibility trees, DOM snapshots, logs, metrics endpoints, profilers. A number beats an impression.

Verify every claim through TWO independent channels (e.g. screenshot AND code path, automation AND unit test, UI state AND persisted state). One channel is an anecdote; two are evidence. When channels disagree, believe the user-facing one and file the gap.

Drive it end to end: open every menu/dialog, submit every form, trigger every empty and error state.

Get creative proving it works — the happy path proves nothing. Ideas to steal: fuzz inputs (empty, huge, unicode, hostile characters); kill dependencies mid-task (close the second window, delete the file out from under it, revoke the folder); race it (double-click, spam keys, edit while projecting); restart it mid-flow and check what survived; run it with no data, corrupt data, and absurd data; time-travel its persisted state (old configs, future versions); make two parts of the app disagree and see which one lies. Invent at least one test the developers never imagined — that is where the real bugs live.

GATE (10/10 required to advance): you hold fresh, measured, dual-channel evidence from the current build, a working observe-act loop, and at least one creative test nobody asked for. Stale build, single channel, eyeball-only, or no creative test equals 0/10 — stop and rebuild the harness.

## 3 - Harsh audit, per surface

Score each surface 0-10 starting from 10, deducting per proven deviation against the closest reference — actual state vs expected state, item by item (order, labels, behavior, empty states, error paths, dismiss/cancel behavior). Overall score is the MINIMUM, never the average. Cover what the last audit skipped, not the same ground.

GATE (10/10 required to advance): every surface has a score, each deduction names its evidence, and the worst surface is identified. If overall is below 10/10 you MUST go to step 4-5 fix loop. Skipping to report on anything below 10/10 is a failed run.

## 4 - Hunt the bug class, not just bugs

Read recent session transcripts for what real users actually hit. Generalize to the class (the classics: state that silently stops meaning what the UI claims — dead handles, unpersisted input, indices shifted by edits, success messages that lie, errors swallowed into no-ops). Search the codebase for siblings of that class.

GATE (10/10 required to advance): you can name the class in one sentence and list every site that shares it. No class equals 0/10 — stop.

## 5 - Fix, test, commit, push — narrowly

Fix the worst surface or the whole bug class, nothing else. Extract pure logic so the class gets unit tests that run without the full harness. The project's suites must be green before and after — that is the only truth that counts. Commit immediately; concurrent loops clobber uncommitted work. Push the branch to GitHub immediately after commit so the fix is not local-only. Never re-litigate a committed fix.

GATE (10/10 required to advance): suites green before AND after, work committed AND pushed to GitHub (branch visible on remote), fresh evidence proves the fix live, AND re-run of steps 2-3 re-scores every touched surface at 10/10. Unpushed commit equals 0/10. Still below 10/10 equals loop the fix — do not advance to report, PR, or babysit.

## 6 - Record what is honestly unmet

List reference behaviors with no equivalent in the port, each with its marker (TODO, status-reported no-op, documented gap). Never fake a feature; a documented gap beats a silent lie.

GATE (10/10 required to advance): the gap list sits next to the score, not buried in code. Faked feature or silent lie equals 0/10 — stop.

## 7 - Report (required output, no skipping)

Do not finish without all of these, in this order. Missing item equals failed run.

1. Scores table per surface, worst deviation plus evidence link or path for each deduction.
2. Bug class in one sentence plus every sibling site found.
3. Test counts before and after (for example `cargo test 120+213 green`, `npm test 17/17`), plus fresh live proof that the fix holds.
4. Slop-media video line pasted verbatim when UI changed, or `no UI change` when logic only.
5. Gap list of honestly unmet reference behaviors.
6. Commits and PR number with branch name.

Append the same to `DOGFOOD.md` at repo root (create if missing) under a dated heading so the next session cannot inflate verdicts. The file is the memory, not the chat.

GATE (10/10 required to pass the run): the user can tell what got better, what is still missing, and exactly what to run next, and `DOGFOOD.md` matches the chat report. Claim 10/10 only when every surface re-scores 10/10 with evidence. Otherwise state FAIL plus what still blocks 10/10 — never file, babysit, or merge a sub-10/10 run as success.
