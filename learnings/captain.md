# Learnings: captain

Reviewed lessons from past missions, read by the `/mission` captain at step 1. `/retro` is the only writer: it adds, merges, and prunes. Cap 20 lines.

- A rule that agents keep breaking moves into the build as a lint or script. (pr-preflight, 2026-09-24: the comment rule failed in 5 of 7 chunks until `check-comments.mjs`)
- The verifier and the browser run each found real bugs while unit tests were green; run both on every mission. (pr-preflight and sesh M0, 2026-09)
- Resume a stalled builder with a three-step finish list; it costs less than a fresh spawn. (pr-preflight, 2026-09-24: 600 s watchdog)
- Check the evidence path on every tester report. (sesh M0, 2026-09-25)
- On the WSL box, start a local model server only through `~/.local/bin/ollaya-safe`, which caps its memory. (flipcheck, 2026-09-27: three WSL crashes)
- Cost shape for a weekend extension: 5 chunks, 2 fix passes, 3 build and 2 test verifier rounds, about 11 hours wall clock with human gates. (pr-preflight, 2026-09-24)
