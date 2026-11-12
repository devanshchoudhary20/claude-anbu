# 10 · AI Frontend

Panel: AI startups (Vercel, Perplexity, Cursor, Anthropic, OpenAI front-end roles, Indian AI startups). Only the frontend half: streaming, chat UX, state during generation, failure modes. The interviewer wants a product sense for what the user sees during the 8 seconds a model takes.

Ledger items: `streaming-transport`, `stream-parsing`, `chat-state`, `abort-and-retry`, `partial-render`, `tool-call-ui`, `ai-ux-states`, `cost-and-latency-ux`.

## Probe

1. SSE vs fetch with a ReadableStream vs WebSocket for token streaming. Pick and say why. What does each do on a flaky mobile network.
2. A stream delivers half a markdown code fence. What do you render. What do you buffer.
3. Chat state: messages, the in-flight message, tool calls, errors. Write the shape. Where is the optimistic user message, where does it go on failure.
4. The user hits stop mid-stream. What does the server need to know. What does the UI keep.
5. Retry on a 429 vs a 500 vs a network drop. Which keeps partial output.
6. Latency UX: what you show at 0ms, 300ms, 2s, 10s. What the first token time changes.
7. A tool call happens mid-response. What does the UI show, what can the user do during it.
8. Streaming markdown with React: why naive re-render of the whole message is slow at 2k tokens, and the fix.

## Build

1. `src/js/sse.ts` and `src/js/streamFetch.ts`: parse an SSE stream and a raw chunked stream into an async iterator of events, with AbortSignal, reconnection for SSE with `Last-Event-ID`, and tests using a mock ReadableStream [45 min].
2. Mock model server in `scripts/mock-llm.mjs`: streams tokens with configurable delay, random errors, tool-call events, so every build below runs offline [30 min].
3. `src/ui/chat`: upgrade module 04's chat UI to streaming: token-by-token render, stop button, retry keeps partial text, tool-call card, scroll pinning only when at bottom, `aria-live` summary rather than per-token announcements [90 min, weekend block].
4. `src/ui/stream-markdown`: incremental markdown renderer that only re-parses the last open block, with a benchmark at 5k tokens [60 min].
5. `src/ui/ai-states`: a states gallery for the chat: idle, thinking, first-token, streaming, tool-running, error-retryable, error-final, stopped, rate-limited with countdown. Each a story, each keyboard-reachable [45 min].

## Follow-ups

- "The user navigates away mid-stream and back. What do they see. Where did the partial answer go."
- "Two chats open in two tabs, same conversation. Design the sync or say why you will not."
- "Show me the bug if you append tokens with `setState(prev => prev + token)` on every chunk at 100 tokens a second."
- "The model returns JSON for a UI card. The JSON is cut off. What renders."
- "What do you log per message for the on-call engineer and for the product team. What do you never log."

## Pass bar

Probe 1, 3, 4, 6 cold at 4 or above. Build 1 and 3 pass tests including an abort test. The states gallery has all nine states reachable by keyboard.

## Resources

- MDN Server-sent events and Streams API.
- Vercel AI SDK docs, UI section, to see the shape of a mature `useChat` and then not use it.
- Anthropic Messages API streaming docs for the real event shape.
