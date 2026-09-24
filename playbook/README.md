# Playbook

One file per phase. `/mission` reads the file for the phase it is entering and nothing else. Each file has the same five sections: Owner, Inputs, Steps, Gate, Cap.

| # | Phase | Owner | Gate artifact |
|---|---|---|---|
| 0 | think | strategist (Fable) | `.anbu/plan.md` with score, scope line, later list, stack, risks |
| 1 | design | designer (Sonnet) | `.anbu/screens.md` with every screen's empty, loading, error, success states and tokens |
| 2 | build | builder (Sonnet) per chunk, verifier (Fable) after | `npm run build` exit 0, `npm run lint` exit 0, verifier not RED |
| 3 | test | tester (Sonnet), verifier (Fable) after | `.anbu/evidence/` with a recording or screenshots per screen and a pass table |
| 4 | ship | shipper (Sonnet) | a live URL that returns 200 from `curl`, or a store item id |
| 5 | launch | shipper (Sonnet) | `.anbu/launch-kit.md` plus analytics wired |

The `pm` agent (Fable) gates three of these: plan review at the end of think, design review at the end of design, ship review at the end of test. Verdicts PASS / CONCERNS / FAIL / WAIVED per Rubric C.

The old weekend `PLAYBOOK.md` in the vault is superseded by this directory.
