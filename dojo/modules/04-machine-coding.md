# 04 · Machine Coding

Panel: India product companies (Flipkart, Swiggy, Razorpay, Cred, Zepto) run this as a 60 to 90 minute round; startups run it as pair programming; FAANG runs the 45-minute UI version. The interviewer wants a working, keyboard-usable, accessible component with clean state, built under time, and a candidate who names tradeoffs while typing.

Interleaved from week 2: two problems a week, 60 minutes each, then a 30-minute review. Every problem lands in `src/ui/<problem>/` with a test.

Ledger items: one per problem below, keyed by slug.

## Rules of the round

- Read the prompt, list requirements and non-goals aloud for two minutes, then state the component tree and the state shape before typing.
- Happy path first, then edge cases, then a11y, then polish. Say which you are on.
- Commit each stage with a message. The interviewer reads your git log.
- Time up means time up. The review grades what exists.

## Problem pool (ordered by frequency in real loops)

Tier A, asked everywhere:
1. `toast` Toast / notification system: queue, auto-dismiss, pause on hover, stack limit, `aria-live`.
2. `accordion` Searchable accordion: filter by title and body, highlight matches, single or multi open, keyboard (Home/End/arrows).
3. `infinite-scroll` Infinite scroll with IntersectionObserver, loading and end states, error retry, scroll restoration.
4. `modal` Accessible modal: focus trap, return focus, Escape, `inert` background, scroll lock, stacked modals.
5. `typeahead` Debounced search with API cache, abort stale requests, keyboard navigation, `aria-activedescendant`, highlight.
6. `virtual-list` Virtualized list: fixed height first, then variable height with measurement cache, 100k rows.
7. `file-upload` File upload with progress, multiple files, cancel, retry per file, drag and drop, size and type validation.
8. `multi-step-form` Covered in module 03 build 4. Re-run timed.
9. `file-explorer` Nested file tree (Atlassian): expand and collapse, add and rename and delete, keyboard, lazy children.
10. `nested-comments` Reddit-style comments: reply at any depth, collapse, optimistic add, normalized state.

Tier B, common:
11. `kanban` Three columns, drag and drop (native DnD, no library), persist order.
12. `otp-input` OTP input: paste handling, auto-advance, backspace, mobile `inputmode`.
13. `star-rating` Hover preview, half stars, keyboard, form-compatible.
14. `carousel` Autoplay with pause, swipe, dots, infinite loop without a jump, reduced motion.
15. `pagination` Server-driven with page size, windowed page numbers, URL sync.
16. `tabs` ARIA tabs with roving tabindex, lazy panels.
17. `data-grid` Sortable, filterable, resizable columns, row selection, 10k rows virtualized.
18. `poll-widget` Vote once, optimistic, live results bar.
19. `calendar` Month view, select a range, keyboard.
20. `tic-tac-toe` with undo history, then generalize to N by N with a win check in O(1) per move.

Tier C, startup pair rounds:
21. `chat-ui` Message list with grouping, optimistic send, retry, scroll to bottom only when at bottom. Feeds module 10.
22. `countdown-timer` Multiple timers, drift-corrected with `Date.now`, pause and resume.
23. `progress-bar` Multiple concurrent, queued.
24. `stopwatch-with-laps`, `traffic-light`, `tabs-with-url`.

## Review rubric (score each 0-2, total out of 12)

Correctness; edge cases named before being asked; keyboard and screen reader; state shape (normalized, no derived state stored); performance under 10x data; communication (said the plan, said the tradeoffs). 9 or above passes. The reviewer writes the three changes that would make it a 12.

## Follow-ups (rotate)

- "Make it work with 10k items." "Make it work offline." "Two tabs open." "The API is slow and flaky." "A screen reader user." "Mobile." "Now it needs to be a library other teams install: what is the API?"

## Pass bar

All Tier A problems at 9 or above within time, with tests. At least six Tier B. Chat UI from Tier C before module 10 starts.

## Resources

- GreatFrontEnd UI coding questions for reference solutions after you have built yours.
- workat.tech frontend machine coding problems for India-style prompts.
- Devtools-Tech front-end-interview-questions for company tags.
