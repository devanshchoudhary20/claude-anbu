# 07 · TypeScript

Panel: startups and Atlassian ask it directly; FAANG expects it to be invisible and correct. Half a week. The interviewer wants types that make illegal states unrepresentable, not types that mirror JSON.

Ledger items: `narrowing`, `discriminated-unions`, `generics-constraints`, `utility-types`, `conditional-mapped-types`, `type-vs-interface`, `unknown-vs-any`, `boundary-parsing`.

## Probe

1. `unknown` vs `any` vs `never`. Where does each belong in a fetch wrapper.
2. A status union `idle | loading | success | error` with data only on success and error only on error. Write the type. Why is `{status, data?, error?}` wrong.
3. `type` vs `interface` for a props object, for a union, for declaration merging. Your default and why.
4. Write `Partial`, `Pick`, `Omit`, `Record`, `ReturnType` from scratch.
5. What does `satisfies` do that an annotation does not.
6. Brand an id: `UserId` that is a string but not assignable from a plain string. Where do brands get applied.
7. A generic `useFetch<T>` where `select` changes the result type. Write the signature.
8. Exhaustive switch on a union with `never`. What happens when a variant is added.

## Build

1. Retype `src/ui/use-fetch` with the discriminated status union and a `select` generic. The test proves `data` is not accessible on `loading` [30 min].
2. `src/js/parse.ts`: a tiny `parse<T>(schema, input): Result<T, ParseError>` for objects, arrays, strings, numbers, literals, unions, optional. No library. Then use it at the storage boundary from module 02 [45 min].
3. Type challenges: `DeepPartial`, `DeepReadonly`, `PathKeys<T>` (dotted paths), `Get<T, Path>`, a typed `EventEmitter` where `on('user:login', handler)` infers the payload [45 min].
4. Typed form: a `useForm<Schema>` where field names are keys of the schema and errors are typed per field, from module 03 build 4 [30 min].

## Follow-ups

- "Your parse returns Result. Why not throw. When would you throw."
- "The API added a field. Nothing in the FE broke. Is that good. Where would a silent break show up."
- "Show me a type that is correct but a reviewer would reject."

## Pass bar

Probe 2, 6, 8 cold at 4 or above. Build 1 and 2 pass with a compile-time test (`// @ts-expect-error`) that proves the illegal state fails.

## Resources

- TypeScript handbook: Narrowing, Generics, Conditional Types, Mapped Types.
- type-challenges on GitHub for build 3 variants.
- Matt Pocock, Total TypeScript free tutorials.
