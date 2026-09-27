---
name: remember-project
description: 🧟 EDO TENSEI — Scans and caches project context for faster future sessions. Run once per project to build memory, then context loads instantly on return visits.
allowed-tools: Read, Grep, Glob, Write, Bash
---

# Remember Project Skill

## Purpose
Creates persistent memory of a project's structure, patterns, and conventions. When you return to a project, cached context loads instantly instead of re-scanning.

## Triggers
- `/remember` - Scan and cache current project
- `/remember --refresh` - Force re-scan
- `/remember --view` - View cached memory
- `/remember --list` - List all remembered projects

---

## How It Works

```
First Visit:
  /remember → Deep Scan (2-3 min) → Save to ~/.claude/memory/

Return Visit:
  Start session → Load cache (< 1 sec) → Ready instantly!
```

## Memory Location

```
~/.claude/memory/
├── index.json                    # All remembered projects
└── projects/
    └── <project-name>/
        ├── context.json          # Full cached context
        ├── patterns.json         # Code patterns
        └── meta.json             # Scan metadata
```

---

## Scan Workflow

### Step 1: Generate Project ID
```
project_id = sanitized(project_directory_name)
Example: "mobile-web-client"
```

### Step 2: Check Existing Memory
- If exists, show summary and ask: Use cached or refresh?
- If not, proceed to full scan

### Step 3: Parallel Deep Scan

Launch 4 agents simultaneously:

**Agent 1: Structure Scanner**
- Map all directories
- Count files by type
- Identify key folders

**Agent 2: Tech Stack Analyzer**
- Parse package.json
- Detect framework, state management, styling
- List component libraries

**Agent 3: Pattern Extractor**
- File naming conventions
- Component patterns
- Import styles
- Error handling patterns

**Agent 4: Architecture Mapper**
- Layer identification
- Data flow mapping
- Key abstractions
- Entry points

### Step 4: Read Key Files
- Entry points (main.tsx, App.tsx)
- Config files
- Store setup
- API setup
- Example components

### Step 5: Save Memory

**~/.claude/memory/projects/<name>/context.json:**
```json
{
  "project_name": "my-app",
  "project_path": "/Users/ravi/projects/my-app",
  "scanned_at": "2024-01-21T10:30:00Z",
  "git_commit": "abc123",

  "tech_stack": {
    "framework": "react",
    "version": "18.2.0",
    "language": "typescript",
    "state_management": "redux-toolkit",
    "styling": "tailwind",
    "testing": "vitest",
    "component_libraries": ["@radix-ui/react"]
  },

  "directories": {
    "components": "src/components",
    "pages": "src/pages",
    "hooks": "src/hooks",
    "state": "src/store",
    "utils": "src/lib"
  },

  "patterns": {
    "component_style": "functional + hooks",
    "file_naming": "kebab-case",
    "imports": "absolute from @/",
    "state_pattern": "zustand stores"
  },

  "architecture": {
    "layers": ["UI", "State", "API"],
    "data_flow": "Component → Store → API",
    "key_files": [...]
  },

  "summary": "React 18 + TypeScript app with Zustand state management..."
}
```

**~/.claude/memory/projects/<name>/meta.json:**
```json
{
  "last_scanned": "2024-01-21T10:30:00Z",
  "scan_duration_seconds": 45,
  "files_analyzed": 234,
  "git_commit_at_scan": "abc123",
  "package_json_hash": "def456"
}
```

### Step 6: Update Index

**~/.claude/memory/index.json:**
```json
{
  "projects": {
    "mobile-web-client": {
      "path": "/Users/ravi/Desktop/LambdaTest/mobile-web-client",
      "last_accessed": "2024-01-21",
      "framework": "react"
    },
    "lt-components": {
      "path": "/Users/ravi/Desktop/LambdaTest/lt-components",
      "last_accessed": "2024-01-20",
      "framework": "react"
    }
  }
}
```

---

## Loading Memory (Return Visit)

### On Session Start
1. Get current directory
2. Check index.json for matching project
3. If found:
   - Load context.json
   - Check freshness
   - Display summary
   - Make available to all skills

### Freshness Check
```
Stale if:
- git commit changed significantly
- package.json hash different
- Last scan > 7 days ago

Prompt: "Memory may be stale. Use cached or refresh?"
```

---

## Integration with Other Skills

### /implement (with memory)
```
Before: Phase 2 Explore = 3-5 min scan
After:  Phase 2 Explore = Load cache + verify (30 sec)
```

### /gather-requirements (with memory)
```
Before: Auto-detect tech stack
After:  Load from cache instantly
```

### /design-to-code (with memory)
```
Before: Search for component libraries
After:  Already knows: "Use @radix-ui, follow existing patterns"
```

### code-reviewer (with memory)
```
Before: Detect patterns during review
After:  Already knows patterns to enforce
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/remember` | Scan & cache (or load existing) |
| `/remember --refresh` | Force full re-scan |
| `/remember --quick` | Refresh only changed files |
| `/remember --view` | Display cached memory |
| `/remember --forget` | Delete project memory |
| `/remember --list` | List all projects |

---

## Output Example

```
═══════════════════════════════════════════════════════════════════════════════
PROJECT MEMORY: mobile-web-client
═══════════════════════════════════════════════════════════════════════════════

📁 Last scanned: 2 days ago
✓ Status: Fresh

## Stack
React 18.2 + Redux + CRACO | SCSS + CSS Modules | Jest

## Structure
├── src/component/     (189 files)
├── src/Components/    (shared UI)
├── src/container/     (pages)
├── src/customHooks/   (71 hooks)
├── src/redux/         (20 reducers)
└── src/utils/         (29 files)

## Patterns
- Container/Component pattern
- Redux Saga for async
- Path aliasing from src/

## Component Libraries
- @lambdatestincprivate/lt-components (primary)
- @primer/react (secondary)

───────────────────────────────────────────────────────────────────────────────
Loaded in 0.2s (vs ~45s full scan)
```

---

## Privacy
- Memory stored locally only (~/.claude/memory/)
- Not synced to cloud
- Delete anytime with `/remember --forget`
