# Phase 5: LAUNCH

## Owner
`shipper` (Sonnet). Human gate before anything public.

## Inputs
- The live URL, `.anbu/plan.md` distribution channels, the best evidence GIF, `templates/launch-kit.md`.

## Steps
1. Fill `templates/launch-kit.md` into `.anbu/launch-kit.md`: Show HN title and first comment, one subreddit post per named channel with that subreddit's rules checked, a dev.to article draft, three tweets, the store listing text, a directory list.
2. Analytics: confirm the PostHog or none decision from BUILD and that the key is not in a public client bundle for anything but a public write-only key.
3. Automated posts only where an API exists and credentials are set: dev.to via API key. HN, Product Hunt, and X are pasted by hand; the kit is written for pasting.
4. Update the vault: idea file to `status: shipped` with `shipped_url`, INDEX.md row moved to Shipped, two-line "what I learned". Commit the vault.
5. Present the kit. Stop. The user posts.

## Gate
`.anbu/launch-kit.md` exists with every section filled, the vault is updated and committed.

## Cap
1 attempt.
