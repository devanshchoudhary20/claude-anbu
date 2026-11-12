# 09 · Accessibility

Panel: FAANG UI rounds decide modal, dropdown, and tabs on this. Interleaved into module 04 from week 9; the machine-coding rubric scores it. The interviewer wants keyboard-first thinking and the ARIA pattern named, not "we'll add aria-labels".

Ledger items: `keyboard-first`, `focus-management`, `aria-patterns`, `live-regions`, `forms-and-errors`, `color-and-motion`, `testing-a11y`.

## Probe

1. The first rule of ARIA. Why `<button>` beats `<div role=button>`.
2. Roving tabindex vs `aria-activedescendant`. Pick for tabs, for a listbox, for a grid.
3. A modal opens. Five things that must happen for focus and for the page behind it.
4. `aria-live` polite vs assertive. What goes in each. Why a toast is polite and a form error is assertive.
5. A form field with an error. Which attributes wire the error to the field. What does a screen reader say on focus.
6. Contrast ratio numbers for text and large text. `prefers-reduced-motion`: what you turn off and what you keep.
7. How you test: keyboard walk, VoiceOver basics, axe, Testing Library queries by role. What axe cannot catch.

## Build

1. Audit every Tier A problem built so far in `src/ui` with axe and a keyboard walk. Write the findings in `design/a11y-audit.md` and fix the top three per component [90 min].
2. `src/ui/combobox`: ARIA combobox pattern with listbox, typeahead, `aria-activedescendant`, `aria-expanded`, announcements of result count. Tested by role queries only [60 min].
3. `src/ui/menu`: ARIA menu button with submenu, arrow keys, type-ahead by letter, Escape closes and returns focus [45 min].
4. `src/js/focus.ts`: `trapFocus(container)` and `getTabbable(container)` without a library; handle `inert`, hidden, negative tabindex, shadow DOM is a stated non-goal [40 min].

## Follow-ups

- "Your combobox announces 'five results'. The user keeps typing. What is the announcement cadence and why."
- "A designer wants a custom select that looks nothing like native. What do you lose, what do you keep."
- "Screen reader user, infinite scroll. What do they hear when new items load."

## Pass bar

Probe 1, 3, 5 cold at 4 or above. Build 2 and 4 pass tests written with role queries. Audit doc exists with before-and-after axe counts.

## Resources

- WAI-ARIA Authoring Practices Guide (the patterns, with keyboard tables).
- Testing Library "Which query should I use".
- Sara Soueidan, accessible components articles.
