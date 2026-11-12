# 06 · Performance

Panel: FAANG and e-commerce (Flipkart, Swiggy, Zepto). The interviewer wants a measure-first habit, a budget with a number, and three fixes ordered by payoff.

Ledger items: `measure-first`, `bundle-and-splitting`, `web-vitals-fixes`, `render-perf`, `virtualization`, `workers`, `images-fonts`, `caching-layers`, `memory-leaks`.

## Probe

1. A page is slow. Your first five minutes. Name the tools and the order.
2. LCP is 4s. Five causes and the fix for each.
3. CLS from a late-loading banner. Fix without removing the banner.
4. INP is 400ms on a search input. What is likely. What does `useTransition` do to it. What does a worker do to it.
5. Route-based vs component-based code splitting. What does `React.lazy` need, what does a preload hint do, how do you avoid a waterfall of chunks.
6. A list re-renders every row on each keystroke. Find it with the Profiler. Three fixes, cheapest first.
7. Memory leak in a SPA: three usual suspects. How you prove it with the heap snapshot.
8. `font-display`, `preconnect`, `preload`, `fetchpriority`, responsive images with `srcset` and `sizes`, AVIF vs WebP. One sentence each.

## Build

1. Take `src/ui/data-grid` from module 04 to 100k rows: virtualize, memoize rows, move sort and filter to a worker, measure before and after with the Profiler and `performance.mark`. Write the numbers in the README [90 min].
2. Build-time: `vite-bundle-visualizer` on fe-dojo, lazy-load every `src/ui` problem by route, add `modulepreload` for the next likely route, prove the main chunk shrank [45 min].
3. `src/js/scheduler.ts`: a `runWhenIdle(tasks)` chunker on `requestIdleCallback` with a `scheduler.yield` fallback that keeps INP under 200ms while processing 50k items [40 min].
4. Image pipeline: responsive images with `srcset`, `sizes`, `fetchpriority=high` on the LCP image, lazy on the rest, measure LCP before and after in Lighthouse [30 min].
5. Find and fix a planted leak: the sensei adds a listener leak and an interval leak to a problem; you find both with DevTools and prove the fix with a heap snapshot [30 min].

## Follow-ups

- "Your worker: what crosses the boundary. What is the cost of structured clone at 100k rows. Transferables."
- "The product manager wants a carousel above the fold. LCP budget is 2.5s. What do you say."
- "Code splitting made the first interaction slower. Why. What is the fix."
- "Give me a perf budget for a mobile e-commerce listing page, with numbers."

## Pass bar

Build 1 and 2 have before-and-after numbers in the README. Probe 1, 2, 4, 6 at score 4 or above cold. A perf budget said with numbers and a reason for each.

## Resources

- web.dev performance section, especially "Optimize LCP", "Optimize INP".
- Chrome DevTools Performance panel docs.
- Addy Osmani, "Image Optimization".
