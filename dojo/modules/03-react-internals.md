# 03 · React Internals

Panel: every React loop. FAANG asks "why" questions about rendering; startups ask "show me" with a hook; India product companies ask both plus "what is the virtual DOM" as a warm-up you must not fumble.

Ledger items: `render-commit-phases`, `reconciliation-keys`, `hooks-rules-why`, `effects-timing`, `memo-when-wrong`, `context-perf`, `refs-and-dom`, `custom-hooks`, `concurrent-features`, `suspense-and-rsc`, `state-mgmt-tradeoffs`.

## Probe

1. Render phase vs commit phase. What can be interrupted, what cannot. Where do `useLayoutEffect` and `useEffect` run relative to paint.
2. Why hooks cannot be conditional. Describe the data structure React uses to find the right hook on re-render.
3. Keys: what happens with `index` keys when you prepend an item that has an uncontrolled input. What does changing a key do on purpose.
4. "A state update in an event handler, then a `console.log` of the state." Why stale. Then the same in a `setTimeout` inside an effect. Then with the functional updater.
5. `useMemo` and `React.memo`: when do they make things slower. What does the React Compiler change.
6. A Context value that is an object literal. What re-renders and why. Three fixes, cheapest first.
7. What is a ref, why does it not trigger a render, when does `ref.current` get set, what is a callback ref for.
8. `useEffect` with an async function and a fetch. Race on fast prop change. Fix it. Then say why Strict Mode double-invokes and what it is trying to catch.
9. `useTransition` vs `useDeferredValue`. A concrete case for each.
10. Suspense for data: what does a component throw. Server Components: what cannot they do, what do they send across the wire, where do client components start.
11. Redux Toolkit vs Zustand vs Jotai vs server state (TanStack Query). Pick for a dashboard with 50 widgets and polling. Pick for a form-heavy admin.

## Build

1. `src/ui/use-fetch`: `useFetch<T>(url, {enabled, select})` on top of module 02's `fetchWithCache`. Status union (`idle | loading | success | error`), abort on unmount and on url change, retry, refetch, stale-while-revalidate [60 min]. This is item 4 of the original post, done properly.
2. `src/ui/hooks`: `useDebouncedValue`, `useThrottledCallback`, `useLocalStorage` (synced across tabs via `storage` event), `useIntersection`, `usePrevious`, `useEventCallback` [45 min total]. Each with a test.
3. `src/ui/context-store`: a `createStore(initial)` with `useStore(selector)` using `useSyncExternalStore`, so a selector re-renders only its subscribers. Then compare render counts against plain Context in a README table [60 min].
4. `src/ui/reducer-form`: Context plus `useReducer` for a multi-step form with validation per step, back and forward, draft persistence [60 min]. Item 9 and 10 of the post in one.
5. Mini React: `createElement`, a render that diffs children by key, `useState` with a hook index. Under 150 lines [90 min, weekend block]. Not for production, for the ability to explain reconciliation with your own code on the table.

## Follow-ups

- "useFetch: two components use the same url. How many requests. Where does the cache live. What happens on logout."
- "Your store: a selector returns a new array each time. What breaks. Fix it in the API, not in the caller."
- "Multi-step form: the user refreshes on step 3. What do they see. Where is the draft, and what if it is stale against a new schema version?"
- "Mini React: why does your useState need the hook index reset per component? Show me the bug if you forget."
- "Why is `useEffect` the wrong place to derive state? Show the derive-in-render version."
- "Explain reconciliation to a PM in three sentences, then to a senior engineer in three."

## Pass bar

- Probe answers 1, 2, 4, 6, 8 given cold at score 4 or above.
- Build 1, 3, 4 have tests and pass; build 1 proves abort on url change with a test.
- Can explain reconciliation at two levels and name the one React Compiler change to memoization advice.

## Resources

- react.dev "Learn" section: Escape Hatches, You Might Not Need an Effect, Reusing Logic with Custom Hooks.
- Dan Abramov, "A Complete Guide to useEffect" and the overreacted archive.
- Rodrigo Pombo, "Build your own React" for build 5.
