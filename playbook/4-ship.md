# Phase 4: SHIP

## Owner
`shipper` (Sonnet).

## Inputs
- Stack from the plan, `--cloud` flag, the repo.

## Steps
1. Create the GitHub repo under `devanshchoudhary20` with `gh repo create --public --source . --push` using the personal SSH host `github.com-personal`. README must have: what it is, one screenshot from evidence, how to run, how to deploy.
2. Web app: `vercel deploy --prod` (token from `VERCEL_TOKEN` in cloud, keychain login locally). Static: Vercel or GitHub Pages. Record the URL.
3. Extension: `npm run build`, zip `dist/`, then `chrome-webstore-upload upload` if `EXTENSION_ID`, `CLIENT_ID`, `CLIENT_SECRET`, `REFRESH_TOKEN` are set. Not set: write the store listing to `.anbu/store-listing.md` and stop at the launch gate with the manual upload as step one. Never call `publish`, only `upload`; publishing is a human gate.
4. `curl -sI <url>` must return 200. Extensions: the zip exists and the upload response has an item id.
5. Write the URL and the deploy command into state.

## Gate
A URL returning 200, or a store item id, or a store listing file plus zip when credentials are absent.

## Cap
2 attempts.
