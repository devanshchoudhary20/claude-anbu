# Cloud routines

Two routines run in Anthropic's cloud against the vault repo `devanshchoudhary20/idea-engine`. Manage them at https://claude.ai/code/routines or with `/schedule`.

| Routine | Cron (UTC) | Model | Prompt | Tools |
|---|---|---|---|---|
| `idea-scan` | `30 3 * * 2,5,6` (9:00 IST Tue, Fri, Sat) | claude-sonnet-5 | `scan.prompt.md` | Bash Read Write Edit Glob Grep WebSearch WebFetch PushNotification |
| `idea-radar` | `30 2 * * 0` (8:00 IST Sunday) | claude-fable-5-1 | `radar.prompt.md` | same |

## Verified 2026-09-24

Manual run of `idea-scan` after the rewrite: every curl (HN, GitHub, Product Hunt, Hugging Face) returned 403 from the egress proxy, the routine switched to WebSearch for each and filed ideas. The fallback is the working path until the allowlist is set.

## Why the scanner silently starved for three months

The cloud sandbox has a network egress allowlist. `hn.algolia.com` and `reddit.com` were not on it, so every `curl` returned empty and the routine committed a heartbeat and nothing else from June to September 2026, except on the days the allowlist happened to let something through. The fix is two-sided:

1. **Allowlist the sources** in the cloud environment (https://claude.ai/code/environments, environment `Default`): `hn.algolia.com`, `api.github.com`, `www.producthunt.com`, `huggingface.co`, `www.reddit.com`, `registry.npmjs.org`.
Note: `api.github.com` is repository-scoped inside a routine (the proxied token only reaches the configured repo), so the GitHub star-velocity search always falls back to WebSearch in the cloud. It works locally.

2. **Give the routine the WebSearch and WebFetch tools.** They run on Anthropic's side, not through the sandbox egress, so they work even when curl is blocked. `scanner/SOURCES.md` now lists a WebSearch fallback query next to every curl.

## Cloud environment checklist for `/mission --cloud`

Set these in the environment so a mission can ship with the laptop closed:

| Variable | Used by | How to get it |
|---|---|---|
| `VERCEL_TOKEN` | shipper, web deploys | vercel.com/account/tokens |
| `DEVTO_API_KEY` | shipper, launch article | dev.to/settings/extensions |
| `EXTENSION_ID` `CLIENT_ID` `CLIENT_SECRET` `REFRESH_TOKEN` | shipper, Chrome Web Store upload | github.com/fregante/chrome-webstore-upload-keys |
| `POSTHOG_KEY` (public write-only) | builder, analytics | posthog.com project settings |

GitHub push works through the cloud session's proxied credentials; no token needed. Claude in Chrome does not run in the cloud; the tester falls back to Playwright MCP, which needs `npx @playwright/mcp` reachable, so add `registry.npmjs.org` and `playwright.azureedge.net` to the allowlist.

## Alerts

Both routines call `PushNotification`. It reaches the Claude mobile and desktop apps when `agentPushNotifEnabled` is true in `~/.claude/settings.json` (it is). For Slack or email, connect the connector at https://claude.ai/customize/connectors and attach it to the routine.
