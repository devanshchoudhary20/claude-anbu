# Learnings: shipper

Reviewed lessons from past missions, read by the `shipper` at the start of every spawn. `/retro` is the only writer: it adds, merges, and prunes. Cap 20 lines.

- reddit.com is unreachable from this environment by every route tried. Carry subreddit rule research forward from an earlier phase, state the block in the kit, and flag it for human re-check. (pr-preflight, 2026-09-24)
- The Chrome Web Store dashboard cannot be scripted. The first submission is manual; later uploads use the API with the item id. (pr-preflight, 2026-09-25)
- `npm publish` needs a 2FA code and fails from a non-TTY runner; hand the user `npm publish --otp=<code>` to run. (sesh M0, 2026-09-25)
- `wrangler pages project create` needs `--force` for a classic Pages project. (sesh M0, 2026-09-25)
