# 08 · Architecture

Panel: the senior and lead signal everywhere. Said in the system design round, the "tell me about a project" round, and the bar-raiser. The interviewer wants tradeoffs with the condition that flips them, not a favourite stack.

Ledger items: `state-placement`, `folder-and-module-boundaries`, `design-system`, `monorepo`, `micro-frontends`, `ssr-ssg-isr-choice`, `testing-strategy`, `error-handling-and-observability`, `feature-flags-and-rollout`, `i18n-theming`.

## Probe

1. Where does state live: component, lifted, context, store, URL, server cache. Give the rule, then the exception.
2. Feature folders vs type folders. What breaks at 50 engineers in each.
3. A design system: tokens, primitives, composites, patterns. What is the API of a Button in a good system. How does a team version and break it safely.
4. Monorepo: what it buys, what it costs, what tool, how you keep a shared package from becoming a dumping ground.
5. Micro-frontends: when they are right (name the org shape), when they are wrong, how routing and shared deps and auth work across them. Module federation in one sentence.
6. Testing pyramid for a React app: what gets a unit test, what gets Testing Library, what gets Playwright, what gets nothing. What is a flaky test's usual cause.
7. Error boundaries: where they go, what they catch, what they do not. What you log, what you alert on, what an SLO for a frontend looks like.
8. Feature flags: client vs server evaluated, how you avoid a flash of the wrong UI, how you clean them up.
9. Theming and i18n: where tokens live, RTL, plurals, dates, what the bundle cost is and how you split it.

## Build

1. Restructure `fe-dojo` into feature folders with a `shared/` package boundary enforced by an ESLint `no-restricted-imports` rule. Write the rule and the one-paragraph ADR [45 min].
2. Write three ADRs (Architecture Decision Records) for a real past decision at work and two hypothetical ones from the probe: context, options, decision, consequences. One page each [60 min].
3. `src/ui/error-boundary`: an `ErrorBoundary` with reset keys, a fallback that reports to a `report(error, info)` sink, and a test that proves the boundary resets on key change [30 min].
4. `src/js/flags.ts`: a typed flag client with a default map, a remote override, a `useFlag(key)` hook that never flashes the default after the remote has loaded, and a test for the flash [40 min].
5. Testing strategy doc for a 30-screen app: what runs on PR, what runs nightly, what budgets, in `design/testing-strategy.md` [30 min].

## Follow-ups

- "Your team wants to split the monolith into micro-frontends because deploys are slow. Push back or agree. Say why."
- "A shared package change broke three apps. What process change, not what code change."
- "Which of your ADRs would you reverse today."
- "What do you measure to know the frontend is healthy in production. Three metrics."

## Pass bar

Probe 1, 3, 5, 6 cold at 4 or above. Three ADRs written and defended against follow-ups. Build 3 and 4 pass tests.

## Resources

- Khalil Stemmler and Michael Nygard on ADRs.
- Kent C. Dodds, "The Testing Trophy" and "Write tests. Not too many. Mostly integration."
- Luca Mezzalira, "Building Micro-Frontends" summary chapters.
