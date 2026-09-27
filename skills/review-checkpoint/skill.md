# 👊 JUKEN — Review Checkpoint Skill

## Description
Post-implementation review that evaluates code quality, DRY principles, readability, accessibility, and API resilience. Runs after each logical feature chunk.

## Triggers
- User invokes `/review-checkpoint`
- Auto-invoked by Claude after each implementation checkpoint (component done, hook layer done, API connected, styling done)

---

## Review Checklist

### 1. Code Readability (Score /10)
- Is the code self-explanatory without excessive comments?
- Are variable/function names descriptive and consistent?
- Is the logic flow easy to follow top-to-bottom?
- No complex logic inside JSX — extracted to variables or functions above return

### 2. DRY Principle (Score /10)
- Any repeated patterns that should be extracted?
- Could any logic be moved to an existing util/hook/component?
- Are there pre-existing components, functions, or utils in the codebase that do the same thing?

### 3. Component Health (Score /10)
- Component under ~400 lines? If over, identify split points
- Clear separation: logic above, JSX below
- No business logic inside JSX expressions
- Props interface is clean and minimal

### 4. Accessibility - WCAG (Score /10)
- Semantic HTML elements used correctly
- Keyboard navigation works
- ARIA labels where needed
- Color contrast and focus indicators
- Screen reader compatibility

### 5. API Falsy Value Resilience (Score /10)
- All API response fields have fallback values
- No raw `value` renders that could show "undefined" or "null"
- Arrays checked before `.map()` — `items?.map()` or `items ?? []`
- Numbers handled for `0` vs `null/undefined` distinction
- Empty strings won't break the UI layout
- Optional chaining used for nested API objects

### 6. Best Practices (Score /10)
- Proper memoization where needed (useMemo, useCallback, React.memo)
- No unnecessary re-renders
- Error boundaries / error handling for async operations
- Loading and empty states handled
- No memory leaks (cleanup in useEffect)

### 7. Necessity & Simplicity (Score /10)
- Is every added line actually needed by the requirement? Could the same outcome be achieved with fewer lines?
- Is there a simpler mechanism the change could use instead (e.g., inline at the existing point of truth vs. a new useEffect, an existing hook vs. a new abstraction)?
- Are there defensive checks, fallbacks, null-guards, error wrappers, or "just in case" branches that aren't tied to a real failure mode? Flag them. The framework or parent already guarantees most things.
- For each new piece of state/ref/effect/util: write down why it's required. If you can't justify it in one sentence tied to the requirement, it shouldn't be there.
- Reuse > new. If similar logic exists, extend it; don't recreate.

### 8. Spec Fidelity (Score /10)
Separate axis from the seven above: they ask "is the code good?"; this asks "is it the code the ticket asked for, no more, no less?" Kept apart so a clean-standards pass can't mask a spec miss. Judge the diff against the originating ticket / PRD / Figma, not against itself.
- Every requirement the ticket asked for: present, partial, or missing? Quote the requirement for each gap.
- Any behavior in the diff the ticket did NOT ask for (scope creep)? Flag it. This is the [[feedback_ui_only_change_needs_pm_approval]] V2/V4/Modules-relabel class.
- Any requirement that looks implemented but wrong — a gate predicate merged, a default changed, an enum collapsed? This is the [[feedback_ui_redesign_preserve_functionality]] frozen-auth-gate class.
- For a wide or gated diff, run this axis as parallel workers/models (interrogate-style): each tries to break it, then merge the findings.

---

## Output Format

```
## Checkpoint Review: [what was just implemented]

| Category                  | Score |
|---------------------------|-------|
| Readability               | X/10  |
| DRY                       | X/10  |
| Component Health          | X/10  |
| Accessibility (WCAG)      | X/10  |
| API Falsy Resilience      | X/10  |
| Best Practices            | X/10  |
| Necessity & Simplicity    | X/10  |
| Spec Fidelity             | X/10  |
| **Overall**               | X/10  |

### Issues Found
- [Critical] ...
- [Warning] ...
- [Suggestion] ...

### Fixes Applied
- ...

### Verdict
[PASS if overall >= 7] / [NEEDS WORK if < 7 — list what to fix]
```

---

## Rules
- Minimum passing score: **7/10 overall**
- If score < 7: fix issues before moving to next checkpoint
- Always check the existing codebase for reusable code before flagging something as "needs extraction"
- Be honest and strict — this is a senior engineer's review
- For every new piece of code, ask: "Is this required by the demand?" If you can't justify it in one sentence tied to the requirement, propose removing or simplifying. Reject defensive/safety code that isn't tied to a real failure mode.
- Before approving an approach (useEffect, ref, helper, abstraction, util), check if a simpler one exists — extending an existing call site, inlining at the point of truth, or reusing an existing util — and prefer it.
