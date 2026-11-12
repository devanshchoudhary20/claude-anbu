# 02 · Browser

Panel: FAANG quiz round; India fundamentals round; Atlassian "how does the browser" questions. The interviewer wants a mental model of the render pipeline and the network, said in plain words with one concrete number.

Ledger items: `critical-rendering-path`, `reflow-repaint`, `event-model`, `storage`, `http-caching`, `cors`, `security-xss-csrf`, `web-vitals`, `rendering-strategies`.

## Probe

1. From URL to pixels in under two minutes. Where does JS block, where does CSS block, what does `defer` change, what does `async` change, what does `type=module` default to.
2. Reflow vs repaint vs composite. Name three properties that trigger each. Why `transform` is cheap. What `will-change` costs.
3. Event capture, target, bubble. `stopPropagation` vs `stopImmediatePropagation`. Why delegation on a 10k-row table. Which events do not bubble.
4. `localStorage`, `sessionStorage`, cookies, IndexedDB, Cache API. Size, sync or async, sent with requests, per-tab or per-origin. When would you reach for IndexedDB.
5. `Cache-Control: max-age` vs `no-cache` vs `no-store`. ETag flow. What `immutable` is for. How a hashed bundle filename changes the answer.
6. CORS: simple vs preflight. Which header makes it preflight. Why the server must opt in, why cookies need `credentials: include` and what that forbids on the server side.
7. XSS: stored, reflected, DOM-based. Why `dangerouslySetInnerHTML` is named that. CSP in one sentence. CSRF: why SameSite cookies mostly killed it and when they do not.
8. LCP, CLS, INP. One cause and one fix for each. What replaced FID and why.
9. CSR, SSR, SSG, ISR, streaming SSR, islands. Pick one for a news site, a dashboard, a marketing page, a chat app. Defend each.

## Build

1. `src/js/delegate.ts`: `on(root, selector, event, handler)` with closest-match and unsubscribe [20 min]. Test with Testing Library.
2. `src/ui/lazy-images`: an `<img>` list that loads with IntersectionObserver, with `loading=lazy` as the comparison, blur-up placeholder, no CLS (reserve the box) [45 min]. Measure CLS in DevTools and write the number in the README.
3. `src/js/storage.ts`: a typed `createStorage<T>(key, {ttl, schema})` over localStorage with TTL, version, and a parse-at-the-boundary step that returns the default on bad data [30 min].
4. `src/js/fetchWithCache.ts`: in-memory cache with `staleWhileRevalidate`, dedupes in-flight requests by key, AbortController per request, max entries [40 min]. This is the seed of module 03's data hook.
5. Write a 10-line CSP for the fe-dojo dev app and explain each directive in a comment. Serve it from `vite.config.ts` headers [20 min].

## Follow-ups

- "Your lazy image list: a user tabs through the page. What does a screen reader get for an image that has not loaded?"
- "fetchWithCache: two components mount at once and call the same key. Prove only one request leaves."
- "What does the browser do with a 200 that has no cache headers at all? Heuristic caching. Why is that a bug for your API?"
- "A third-party script is slowing LCP. You cannot remove it. Three options."
- "Why does `position: fixed` with a `transform` on the parent break? What is a containing block?"

## Pass bar

- Render pipeline and event model explained with no notes in under two minutes each, including one number (16ms frame, 100ms INP target, 2.5s LCP).
- Build items 1 to 4 pass tests; item 2 has a measured CLS under 0.1 in the README.
- Can pick a rendering strategy for four app types and give the tradeoff each pays.

## Resources

- web.dev "Core Web Vitals" and "Rendering on the web".
- MDN HTTP caching, CORS.
- yangshun front-end-interview-handbook quiz section for the question bank.
