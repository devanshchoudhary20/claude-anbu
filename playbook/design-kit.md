# Design kit

verified: 2026-11-13

Free tools the `designer` and `drafter` can drive from a shell. Every entry was checked on its repo or site on the date above. When that date is more than 60 days old, the designer re-checks the entries it plans to use and reports the stale date in its return.

## Tokens

| Tool | Licence | Use it for |
|---|---|---|
| DTCG format 2025.10 (designtokens.org) | community group spec | The `.tokens.json` shape when a product needs tokens outside CSS. |
| Style Dictionary (`style-dictionary/style-dictionary`) | Apache-2.0 | Build one token source into CSS, iOS, and Android. Only worth it past one platform. |
| `openpencil tokens` | MIT | CSS custom properties with a dark block, straight from the `.fig`. The default handoff. |

## Color

| Tool | Licence | Use it for |
|---|---|---|
| Radix Colors (`radix-ui/colors`) | MIT | 12-step scales with documented roles per step and matching dark scales. A sound starting scale. |
| Leonardo (`adobe/leonardo`) | Apache-2.0 | Generate a scale from target contrast ratios, so AA holds by construction. |
| culori (`danburzo/culori`) or Color.js (`color-js/color.js`) | MIT | OKLCH conversion and contrast math in a node one-liner. Compute ratios, never eyeball them. |

## Type and space

| Tool | Licence | Use it for |
|---|---|---|
| Fontsource (`fontsource/fontsource`) | MIT | Open fonts as npm packages, self-hosted, so no third-party request ships. |
| Utopia (utopia.fyi) | free site | Fluid type and space scales as `clamp()` values between 390 and 1280. |

## Components

| Tool | Licence | Use it for |
|---|---|---|
| shadcn/ui (`shadcn-ui/ui`) | MIT | Copy-in components over Radix primitives. The default for a new web product. |

## Drawing

| Tool | Licence | Use it for |
|---|---|---|
| OpenPencil (`open-pencil/open-pencil`) | MIT | The mockup tool. Manual in `playbook/openpencil.md`. |
| Penpot MCP (`penpot/penpot`, `mcp/`) | MPL-2.0 | Works through a plugin in an open file, so it needs a person at the app. Not for headless runs. |

## Checking

| Tool | Licence | Use it for |
|---|---|---|
| axe-core (`dequelabs/axe-core`) | MPL-2.0 | Accessibility violations on the built page. The tester runs it. |
| Playwright screenshot compare (`microsoft/playwright`) | Apache-2.0 | Built-versus-mockup pixel diff. Cloud sessions only; local testing stays in Claude in Chrome. |
| BackstopJS (`garris/BackstopJS`) or reg-suit (`reg-viz/reg-suit`) | MIT | Visual regression across releases, once a product has a second release. |
