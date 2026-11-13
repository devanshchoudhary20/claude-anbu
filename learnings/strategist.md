# Learnings: strategist

Reviewed lessons from past missions, read by the `strategist` at the start of every spawn. `/retro` is the only writer: it adds, merges, and prunes. Cap 20 lines.

- Check that every name the plan depends on resolves before the plan ships: npm package, domain, store listing. (sesh M0, 2026-09-25: `sesh` was taken by a 2011 package, caught only at PM gate 3)
- Measure a local model's load peak under a memory cap before planning around it. (flipcheck, 2026-09-27: kev:0.8b peaked above 4.5 GB, so "runs on any laptop" was false at 8 GB)
