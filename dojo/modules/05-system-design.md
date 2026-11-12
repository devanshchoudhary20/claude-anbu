# 05 · Frontend System Design

Panel: the senior gate at FAANG (Meta, Google, Uber); Atlassian and Razorpay run it for 3+ years. Forty-five minutes, whiteboard. The interviewer wants requirements first, then data flow, state ownership, rendering strategy, and failure modes, with the senior signals said unprompted.

Ledger items: `radio-framework`, `news-feed`, `autocomplete`, `chat`, `ecommerce-pdp`, `video-player`, `collab-editor`, `dashboard`, `image-carousel`, `notification-center`.

## The frame: RADIO

Requirements (functional, non-functional, scope cut), Architecture (component tree, boundaries), Data model (normalized entities, client vs server state), Interface (API shape, pagination, real-time), Optimizations (perf, a11y, i18n, offline, security). Say the five words at the start so the interviewer can follow.

## Senior signals the panel listens for

Optimistic updates with rollback; AbortController and request de-duplication for races; normalized store with ids, not nested arrays; cursor pagination over offset and why; cache invalidation policy named; virtualization threshold named with a number; rendering strategy chosen with the tradeoff; accessibility as a requirement, not a polish item; error and empty and loading states designed, not mentioned; observability (what you log, what alerts); what you would cut for v1.

## Probe

1. Say RADIO cold with one sentence per letter.
2. Offset vs cursor pagination for a feed where new posts arrive at the top. Which one duplicates rows and why.
3. WebSocket vs SSE vs long polling. Pick for chat, for a stock ticker, for notifications. What does each cost the server.
4. Normalize a post with author and comments into a store. Why. What does the UI subscribe to.
5. Optimistic like on a post. What state do you keep to roll back. What if the user likes twice fast.

## Build (timed, 45 minutes each, written in `design/<slug>.md` as a whiteboard would be)

1. News feed (Facebook). Infinite feed, post composer, likes and comments, images and video, real-time new-post indicator.
2. Autocomplete (Google search box). Debounce, cache, abort, keyboard, result ranking on the client, offline cache, i18n.
3. Chat (WhatsApp web). Message list, threads, typing indicator, delivery states, offline queue, 100k-message history, media.
4. E-commerce product page (Flipkart). Variants, inventory, image gallery, reviews, add to cart, SSR and SEO, Core Web Vitals budget.
5. Video player (YouTube). Adaptive streaming at a high level, controls, captions, keyboard, picture-in-picture, analytics events.
6. Collaborative editor (Google Docs). Operational transform vs CRDT at a high level, presence, cursor sync, conflict, offline.
7. Analytics dashboard with 50 widgets and polling. Widget registry, shared time range, data layer, virtualization, export.
8. Notification center: unread count, grouping, mark read, real-time, cross-tab sync.

After each: the sensei plays the interviewer for 15 minutes of follow-ups, then scores on the senior signals list, one point each.

## Follow-ups

- "The feed is slow on a low-end Android. Where do you look first. What is your budget."
- "Two tabs. One likes a post. What does the other show."
- "The API returns the same post twice across pages. Where is the bug and who owns it."
- "How do you ship this behind a flag to 1 percent. What do you measure."
- "What would you delete to ship in two weeks."

## Pass bar

RADIO said cold. Feed, autocomplete, chat, product page each scored 8 of 11 senior signals or above in a timed run. One re-run of the weakest at 9 or above.

## Resources

- GreatFrontEnd Front End System Design guide and its question set (the RADIO source).
- "Frontend System Design: the RADIOS framework" on techinterview.net for the extended frame.
- Google Docs and Figma engineering blog posts on multiplayer for build 6.
