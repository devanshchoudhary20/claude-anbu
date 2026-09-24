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

1. **Allowlist the sources** in the cloud environment. There is no settings URL: at https://claude.ai/code, click the cloud icon showing `Default` in the row above the message box, hover `Default`, click the gear, set **Network access** to **Custom**, tick **Also include default list of common package managers**, and paste into **Allowed domains**:

   ```
   hn.algolia.com
   www.reddit.com
   www.producthunt.com
   huggingface.co
   cdn.playwright.dev
   playwright.azureedge.net
   api.vercel.com
   vercel.com
   www.googleapis.com
   oauth2.googleapis.com
   ```

   `api.github.com` and `registry.npmjs.org` are already on the default list. GitHub goes through its own proxy and is repository-scoped regardless.

2. **Give the routine the WebSearch and WebFetch tools.** They run on Anthropic's side, not through the sandbox egress, so they work even when curl is blocked. `scanner/SOURCES.md` now lists a WebSearch fallback query next to every curl.

## Cloud environment checklist for `/mission --cloud`

Same dialog, **Environment variables** box, `.env` format. Values are visible to any session in the environment, which on a personal Pro/Max account means only you. The **API credentials** section below it is the safer option for bearer tokens (the proxy injects them and the session never sees the value), but the Vercel CLI refuses to run non-interactively without `VERCEL_TOKEN` in env, so that one stays an env var.

| Variable | Used by | How to get it |
|---|---|---|
| `VERCEL_TOKEN` | shipper, web deploys | vercel.com/account/tokens |
| `DEVTO_API_KEY` | shipper, launch article | dev.to/settings/extensions |
| `EXTENSION_ID` `CLIENT_ID` `CLIENT_SECRET` `REFRESH_TOKEN` | shipper, Chrome Web Store upload | github.com/fregante/chrome-webstore-upload-keys |
| `POSTHOG_KEY` (public write-only) | builder, analytics | posthog.com project settings |

GitHub push works through the cloud session's proxied credentials; no token needed.

**Setup script** (same dialog, runs as root on Ubuntu 24.04, must exit 0 within 5 minutes):

```bash
#!/bin/bash
npm i -g vercel chrome-webstore-upload-cli || true
npx -y playwright install --with-deps chromium || true
``` Claude in Chrome does not run in the cloud; the tester falls back to Playwright MCP, which needs `npx @playwright/mcp` reachable, so add `registry.npmjs.org` and `playwright.azureedge.net` to the allowlist.

## Alerts

Both routines call `PushNotification`. It reaches the Claude mobile and desktop apps when `agentPushNotifEnabled` is true in `~/.claude/settings.json` (it is). For Slack or email, connect the connector at https://claude.ai/customize/connectors and attach it to the routine.
