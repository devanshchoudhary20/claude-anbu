---
name: personal-accounts-only
description: "All personal-project services (GitHub, Cloudflare, npm, Vercel, Chrome Web Store, Figma, Google) must use the user's personal accounts, never company or other accounts"
metadata: 
  type: feedback
---

Every service touched by ANBU missions uses the personal account: GitHub `devanshchoudhary20` (SSH alias `github.com-personal`), Cloudflare and npm and Vercel on `devanshchoudhary999@gmail.com`, Chrome Web Store on the gmail developer account, Figma on a personal Figma login. The `gh` CLI defaults to the company account, so switch explicitly and switch back.

**Why:** On 2026-09-25 the Chrome Web Store sign-in offered `devanshc@testmuai.com` and Figma was authorized as `devanshc@lambdatest.com`; the user said "only use my personal account for all".

**How to apply:** Before any publish, deploy, or OAuth, check which account is active and stop if it is not personal. Figma needs re-authorization on the personal account and the two mockup files (PR Preflight, sesh M0) recreated there. See [[testing-and-review-preferences]] and [[anbu-personal-agent-system]].

Claude in Chrome: two Chrome profiles have the extension. Always call `list_connected_browsers` at session start and select the personal profile: deviceId `d9f51867-6c4d-40f6-b127-b49072054a85` ("Browser 1", signed in as the gmail, verified 2026-09-25). The switch_browser name "personal" did not persist across subagents, so use the deviceId. The other instance is the company profile.
