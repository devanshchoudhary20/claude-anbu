# OpenPencil manual

Read by `drafter` before it draws. The CLI is `openpencil` (MIT, npm `@open-pencil/cli`), headless, with no account, login, or desktop app, so it runs in WSL and in cloud sessions. Verified on v0.16.0: full procedure 2026-11-12, smoke test (tokens, modes, binding, wrap, dark clone, export, tokens CSS) 2026-11-13.

## Setup

- Preflight: `openpencil --version`. If the command is missing, run `npm i -g @open-pencil/cli`; if that fails, stop and return `needs openpencil install`.
- You are the agent: call the CLI directly. The built-in AI assistant and the MCP agent setup stay unused.
- The design file is `<project>/design/<project-slug>.fig`, committed next to the code. Change it only through `openpencil eval`.
- Create the file once from an empty HTML import, because `openpencil documents new` needs the desktop app:
  ```bash
  echo '<div></div>' > /tmp/seed.html
  openpencil import /tmp/seed.html -o design/app.fig --pageName Screens
  ```

## Scripts

- Write each batch of operations as a script file under `.anbu/design/scripts/`, then run it. Multi-line scripts, top-level `await`, and `return` all work. The scripts stay in the repo, so anyone can re-run a screen:
  ```bash
  openpencil eval design/app.fig --stdin -w --json < .anbu/design/scripts/home.js
  ```
- Scripts add to the file, so each one starts by removing the nodes it owns: `00-tokens.js` clears the page's children on the first run, and a screen script removes the frames whose names start with `<screen>/`.
- Learn the current syntax from the tool: `openpencil <command> --help`, `openpencil tool list`, `openpencil tool describe <name>`. Keep notes on the operations you use in `.anbu/design/openpencil-notes.md`.
- Scripts use Figma's Plugin API for nodes (`figma.createFrame()`, `figma.createText()`, `figma.createComponent()`, `createInstance()`, `clone()`, auto-layout properties). The variables API is OpenPencil's own; `figma.variables` does not exist.

## Tokens

Tokens become variables, defined once in `00-tokens.js` before any frame: every color, radius, and spacing step from the screens file.

```js
const col = figma.createVariableCollection("Theme");
const light = col.defaultModeId;
const dark = figma.graph.createMode(col.id, "Dark");
const bg = figma.createVariable("bg", "COLOR", col.id, {r:0.98,g:0.97,b:0.94,a:1});
figma.setVariableValue(bg.id, dark, {r:0.07,g:0.08,b:0.09,a:1});
```

- Later scripts look variables up with `figma.getLocalVariables()` and `figma.getLocalVariableCollections()`; a collection's modes are in `col.modes` as `{modeId, name}`.
- `figma.graph` is the engine's internal graph, not a documented API. If `createMode` or `updateNode` fails after an upgrade, grep the installed `@open-pencil/core/dist` for the new name and record it in the notes file.
- Frames reference variables, never raw hex. Give the node a placeholder solid fill, then bind it: `figma.bindVariable(node.id, "fills/0/color", variable.id)`. `openpencil tool describe bind_variable` lists the other bindable fields (radius, padding, spacing, font size).

## Frames

- One frame per screen per state, named `<screen>/<state>/<theme>`.
- Repeated pieces (buttons, inputs, cards, rows) are components placed as instances, so a token or component change lands everywhere. Park the main components to the right of the screens.
- A vertical auto-layout frame hugs its content and ignores the height you gave it. For a screen-sized frame, set `frame.primaryAxisSizingMode = "FIXED"` and then `frame.resize(w, h)`.
- Make the dark version by cloning and switching its mode; the variables resolve per mode with no second design to maintain:
  ```js
  const d = frame.clone(); d.name = "home/empty/dark"; d.x = frame.x + frame.width + 40;
  figma.graph.updateNode(d.id, { variableModes: { [col.id]: dark } });
  ```
- Text wraps only inside an auto-layout frame with `layoutAlign = "STRETCH"` and `textAutoResize = "HEIGHT"`, set after `appendChild`. Call `await figma.loadFontAsync({family, style})` before setting characters. Let wrapping and layout size the text.

## Export and handoff

- Node ids change when the file is saved, so ids returned by a script are stale. After the last script, read the saved ids with `openpencil tree design/app.fig`, then export each frame at 2x:
  ```bash
  openpencil export design/app.fig --node "0:5" -s 2 -o .anbu/design/home-empty-light.png
  ```
  Name every PNG `.anbu/design/<screen>-<state>-<theme>.png`; a narrow frame adds `-390` before the theme.
- Open every PNG with Read before you report. Fix clipped or overflowing text, overlaps, missing-font warnings from the export, and anything that differs from the screens file, then export again.
- Token handoff: `openpencil tokens design/app.fig > .anbu/design/tokens.css` writes the variables as CSS custom properties with a `[data-theme="dark"]` block. Optional markup reference: `openpencil export design/app.fig --node <id> -f tailwind-jsx -o .anbu/design/<screen>.jsx`. The builder still writes its own components.
- Append a `## Design files` section to `.anbu/screens.md`: the `.fig` path, the `openpencil --version` used, and a table of frame name, state, width, theme, and PNG path.
- Watching live is optional: the human can open the `.fig` in the OpenPencil desktop app or at app.openpencil.dev.
