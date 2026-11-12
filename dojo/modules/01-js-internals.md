# 01 · JS Internals

Panel: phone screen everywhere; FAANG JS round; India round 1. The interviewer wants to see you predict output, then implement a utility under time with edge cases named before they are asked.

Ledger items: `event-loop`, `closures-scope`, `this-binding`, `prototypes`, `promises`, `debounce-throttle`, `promise-all-polyfill`, `bind-call-apply`, `deep-clone`, `memoize`, `curry`, `flatten`, `event-emitter`, `pipe-compose`, `once-retry`.

## Probe

Ask one at a time, follow up on every answer, explain only the gap.

1. Predict the log order: `console.log(1); setTimeout(()=>console.log(2)); Promise.resolve().then(()=>console.log(3)); queueMicrotask(()=>console.log(4)); console.log(5)`. Then: where does `await` split a function, and what runs between the two halves.
2. `for (var i=0;i<3;i++) setTimeout(()=>console.log(i))`. Fix it three ways without `let`.
3. What does `this` resolve to in: a method called detached, an arrow inside a method, a class field arrow, `setTimeout(obj.method)`. Which of those does `bind` fix and which does it not.
4. `Object.create(null)` vs `{}`. What does `instanceof` actually check. Where does `hasOwnProperty` live and why `Object.hasOwn` exists.
5. `Promise.all` vs `allSettled` vs `race` vs `any`. What happens to the other promises when `race` settles. Unhandled rejection: when does the browser fire the event.
6. Microtask starvation: write a line that freezes the page without a loop.
7. What is a closure costing you in a React component rendered 10k times.
8. `==` coercion order for `[] == ![]`. You will not be asked this at FAANG, you will be asked it at an India product company.

## Build

Each drill: write the test file first, then the implementation, in `src/js/`. Time box in brackets. Hint ladder: 1 name the concept, 2 name the test case that fails, 3 name the method or data structure.

1. `debounce(fn, wait, {leading, trailing})` and `throttle(fn, wait)` [30 min]. Must preserve `this` and args, must expose `cancel` and `flush`. Test with fake timers.
2. `Promise.all`, `Promise.allSettled`, `Promise.race`, `Promise.any` polyfills [30 min]. Non-promise values, empty array, order preservation, synchronous throw inside the iterable.
3. `Function.prototype.myBind`, `myCall`, `myApply` [20 min]. `new` on a bound function. Symbol key cleanup.
4. `deepClone(value)` [30 min]. Dates, Maps, Sets, circular refs via WeakMap, prototype preserved, functions passed through. Then say when `structuredClone` is enough.
5. `memoize(fn, resolver)` [20 min]. Multi-arg keys, Map vs WeakMap for object args, cache size cap.
6. `curry(fn)` and `curry(fn, arity)` with placeholder support [20 min].
7. `flatten(arr, depth)` iterative and recursive, then `flattenObject` with dotted keys [20 min].
8. `EventEmitter` with `on`, `off`, `once`, `emit` [25 min]. Removing a listener during `emit` must not skip the next listener. Return unsubscribe from `on`.
9. `pipe`, `compose`, and an async `pipe` that awaits each step [15 min].
10. `once(fn)`, `retry(fn, times, delay)` with exponential backoff and a `shouldRetry` predicate, `sleep`, `timeout(promise, ms)` with AbortController [30 min].
11. Implement a `Promise` class from scratch: `then` chaining, `catch`, `finally`, `resolve`, `reject`, thenable adoption, microtask timing [60 min, weekend block].
12. `JSON.stringify` polyfill for the common subset, then a `deepEqual` [30 min].

## Follow-ups (interviewer voice)

- "Your debounce: what happens if the component unmounts mid-wait? Where does cancel get called in React?"
- "Promise.all with 10k promises. Memory. What would you change for a concurrency limit of 5?" Then make them write `pLimit`.
- "deepClone on a DOM node. On a class instance with private fields. What do you return?"
- "memoize with an object arg: why does WeakMap fix the leak, and what does it break?"
- "EventEmitter: a listener throws. Do the rest run? What does Node do?"
- "Your Promise: why must then callbacks run as microtasks even when the promise is already resolved? Show me the bug if they run synchronously."
- "retry: the request succeeded but the timeout fired first. What did the user see? Fix it."

## Pass bar

- Event loop: predicts output on three unseen snippets including `await`, correctly, in under a minute each.
- Every drill in Build has tests, passes them, handles the edge cases listed, and was written inside the time box or within 25 percent of it.
- `pLimit`, `Promise` class, and `retry` with abort are explained aloud: the user can say the mechanism in three sentences.

## Resources

- GreatFrontEnd JavaScript functions list for extra drills with reference solutions.
- BFE.dev JavaScript coding questions for the ones above you want second variants of.
- javascript.info chapters: Closures, Event loop, Promises chaining, Microtasks.
