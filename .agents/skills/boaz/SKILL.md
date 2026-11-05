---
name: boaz
description: Headless desktop tester — launch Electron/GPUI/Qt apps on an invisible DISPLAY, screenshot, script clicks/keys, record MP4s. Use when the user says boaz, headless desktop, test a GUI app, Electron test, GPUI test, or invisible app.
---

# Boaz

Test desktop apps without ever seeing them. Boaz launches the app on its own
invisible DISPLAY (`:99`+), the agent drives it and reads screenshots, and the
human only looks when the agent verdict is READY_FOR_HUMAN. Project lives at
`/home/jemo/projects/boaz/`, runnable as `boaz` (shim in `~/.local/bin/`).

Mishpat owns the browser; boaz owns the desktop. Never confuse them.

## 1 - Orient

Confirm the CLI answers: `boaz --help`. Commands: `launch`, `wait`,
`screenshot`, `run`, `record`, `find`, `evidence`, `show`, `log`, `kill`, `ps`, `doctor`.

Run `boaz doctor` first — it reports exactly what this machine can do
(Xvfb/xdotool/ffmpeg/scrot/tesseract/compositor/GPU/Lavapipe) plus a live
render smoke-test: `X apps capturable` and `GL apps capturable` are probed
separately on scratch Xvfbs (a green toolchain with a red render path is
reported, not hidden).

Done when: help lists all twelve commands and doctor shows X apps capturable.

## 2 - Headless test loop (default)

Isolate per task, then drive (perez example):

```bash
export BOAZ_SESSION_DIR=~/.cache/boaz/sessions-<task>  # isolate parallel agents
boaz doctor; boaz kill --all --sweep
boaz launch "/abs/target/debug/perez-rs" --name t --with-wm auto --cwd /home/jemo/projects/video-psalm-reverse-eng-v-2 --env LIBGL_ALWAYS_SOFTWARE=1
boaz wait --name t --for painted --timeout 120
boaz screenshot --name t --json  # use returned absolute path (BOAZ_SHOTS overrides shot dir)
boaz run /tmp/flow.json --name t # file, never inline JSON on the CLI (or --inline '[...]')
boaz record --name t --out /abs/shots/<name>.mp4
boaz evidence --name t  # attach evidence/*.tar.gz to the PR before READY_FOR_HUMAN
```

Never claim second-monitor/video OK from boaz — mark needs-human-hardware (single-display only; `doctor` says so explicitly). `tests/boaz-flow.json` covers the perez loop: click Play-it direct → assert_changed, Display-2 pick → RandR log hint, open video → missing-file guard.

General form:

```bash
boaz launch "<cmd>" --name app          # runs in YOUR $PWD; --cwd overrides. Echoes cmd=/abs cwd= shot_dir= in the launch line.
boaz launch "<cmd>" --name slow --timeout 120 --cwd /path/to/repo   # slow cold-starts
boaz launch "<cmd>" --name gl --with-wm xfwm4   # GL/wgpu/SDL/GPUI: compositor so the GL surface composites (auto: --with-wm auto)
boaz launch "<cmd>" --name app --env VP_KEY=1 --env LIBGL_ALWAYS_SOFTWARE=1   # repeatable, echoed in launch line
boaz wait --name slow --for mapped --timeout 120    # or --for painted (mapped + non-blank frame)
boaz wait --name app --window title:VideoPsalm --timeout 60   # wait for one window, not the root
boaz screenshot --name app             # -> shots/app-NNN.png, open it to SEE
boaz screenshot --name app --window title:VideoPsalm   # target a window, not the root
boaz run tests/flow.json --name app    # wait|key|type|click|scroll|drag|screenshot|assert_changed|assert_text
boaz find --name app --text "Start"    # -> x y w h (tesseract on the live frame)
boaz record --name app --out shots/t.mp4 [--script tests/flow.json] [--window title:VideoPsalm]
boaz evidence --name app               # bundle shots+log+session into evidence/<name>.tar.gz
boaz log --name app                    # app stdout; "No log" names the dir it searched
```

Every command takes `--json` for machine-readable output
(`{window, id, rect, blank, frames}` instead of grepping tables).

`launch` polls for a mapped window (no blind sleep); `--wait-window title:Sub`
waits for one window. On timeout it exits 2, prints the window diagnostic
line and suggests `boaz wait`. The launch line shows
`session= display= pid= window= cwd=` plus `wm=` and `env=` when set, the
shot and log paths. `--with-wm xfwm4` (or `auto`) starts a compositor so
GL/wgpu/SDL/GLFW/GPUI paint reaches the framebuffer; the WM is tracked in
the session and reaped by `kill`.

`run` coordinates are **root-display coordinates as seen in screenshots**
(the window sits at +0+20 under root). Scroll nested panes with
`{"action":"scroll","x":640,"y":400,"clicks":3,"dir":"down"}` (dir up|down,
wheel buttons 4/5) — never click scrollbar tracks to page. Drag with
`{"action":"drag","x1":100,"y1":200,"x2":300,"y2":400}`.
Every step auto-screenshots to `shots/` (also archived under `evidence/<name>/`
so /tmp captures can't vanish). Every key/type/click/scroll/drag step
`windowfocus --sync`s the target first — "typed into nothing" is a loud
FAIL, never a no-op. Prove liveness without hand-rolled PIL:
`{"action":"screenshot","as":"a"}` then
`{"action":"assert_changed","vs":"a","region":[x,y,w,h],"min_delta":0.01}`
(mean-abs-diff in [0,1]) and `{"action":"assert_text","contains":"John 3:16"}`
(tesseract OCR, optional region). `run` prints PASS/FAIL and exits
0/1 — a FAIL names the step index, the specific cause, and one correct
example for that action, never a stack trace.
`record` verifies frame count with ffprobe, reports `(N frames) M/S non-blank`,
and refuses blank MP4s.

Blank captures refuse with exit non-zero (no black PNG written), name the
suspected class, and print the exact retry: `window 0x20000b "Title"
1280x760 IsUnMapped` (id, title, geometry, map state), plus a toolkit hint
when matched (Electron → `--disable-gpu`, Java →
`-Dsun.java2d.xrender=false`, Qt → `QT_QPA_PLATFORM=xcb` /
`QT_XCB_FORCE_SOFTWARE_OPENGL=1`, GL/wgpu/SDL/GLFW/GPUI → suspected
compositor issue + `boaz launch "<cmd>" --name <name> --with-wm xfwm4`).
Viewable-but-blank explicitly says "viewable != rendering".

Done when: every claim about the app is backed by a fresh screenshot or
`run` PASS, and `ps` shows the session isolated on its own DISPLAY.

## 3 - Human handoff (visible, gated)

```bash
boaz show --name app   # relaunches the same cmd on YOUR display for manual testing
```

Call `show` ONLY on agent verdict READY_FOR_HUMAN. The headless session keeps
running untouched. Never let the human click around while the agent drives.

Done when: the MP4 exists, plays, and the human confirms on the visible copy.

## 4 - Multiscreen via session pairs

One app instance can't span two DISPLAYs, so multiscreen-requiring apps
(control + projector, e.g. VideoPsalm) are tested as a session PAIR — one
session per display. Each `--name` owns its DISPLAY (`:99`–`:110`, lock +
reservation isolated), so the pair never collides; `ps` shows both, `kill --all`
reaps both. Proven by `tests/test_multiscreen.py` (different DISPLAYs, both
capturable, driven independently). A SINGLE app that opens two windows stays
on one screen: target with `screenshot --window title:` + region asserts.

```bash
boaz launch "<control-cmd>" --name ctrl --wait 30
boaz launch "<projector-cmd>" --name proj --wait 30
boaz screenshot --name ctrl            # -> shots/ctrl-NNN.png
boaz screenshot --name proj            # -> shots/proj-NNN.png
boaz run tests/flow.json --name ctrl   # drive control; projector keeps running untouched
boaz ps                                # both sessions, different DISPLAYs
boaz kill --all                        # reaps the whole pair
```

## 5 - Hygiene (parallel-agent safe)

Sessions live in `~/.cache/boaz/sessions` unless `BOAZ_SESSION_DIR` overrides
(no export needed in the common case). Each `--name` owns a DISPLAY + state
file. `ps` hides dead sessions by default (`ps --all` reveals them).
`kill` verifies `/proc` cmdlines before signalling — it would rather leave a
process than kill a stranger. `kill --all --sweep` reaps orphans. Never
`kill -9` by hand; never bind `:99` yourself.

`kill` verifies cmdline AND starttime before signalling and keeps — never
deletes — a session it refused to kill. `kill --all --sweep` reaps only
boaz-marked Xvfb servers (`argv[0]=boaz-Xvfb`); a foreign plain `Xvfb` always
survives. Blank captures AND blank recordings exit non-zero with "blank" and leave no file behind (tmp + os.replace).

Parallel agents: export a private BOAZ_SESSION_DIR per loop so pools never collide.

Internal rule for contributors: never call a typer command from another
command — `typer.Option` defaults are truthy `OptionInfo` objects off-CLI
(this once caused `launch` to `kill --all` every sibling session). Always go
through the `_shot` / `_run` / `_kill` helpers.
