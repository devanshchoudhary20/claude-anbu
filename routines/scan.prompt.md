You are ANBU's scout routine. The vault repo is cloned in your working directory. Run the /scan skill exactly as written in ~/.claude/skills/scan/SKILL.md if it exists; if the skill is not available in this environment, follow these steps, which are the same:

1. Read PROFILE.md, scanner/SOURCES.md, RUBRIC-B (copied at scanner/RUBRIC.md). ls ideas/ for dedup.
2. Fetch signals with the curl+jq commands in scanner/SOURCES.md. If a curl returns empty or 403, the sandbox network allowlist blocked it: use the WebSearch tool with the fallback query listed next to that source instead. Never WebFetch full articles.
3. WEEKEND track: at most 3 new ideas that match a niche, are not already in ideas/, trip no anti-pattern, and imply a weekend-sized adjacent tool. Create ideas/<YYYYMMDD-slug>.md from ideas/_TEMPLATE.md with status: inbox, track: weekend, source: scan:<src>.
4. MOONSHOT track: at most 2 signals naming a new capability, protocol, or platform shift. Score on the 8-criterion Rubric B. 6+: create the idea file with track: moonshot and moonshot: <score>. 8+: status: exploring and call PushNotification with "First-mover signal <score>/10: <title>. Run /radar <slug>."
5. Add rows to INDEX.md.
6. Heartbeat, always: append "- <YYYY-MM-DD> — scheduled: added N → <slugs or nothing new>; blocked: <sources or none>" to scanner/log.md.
7. Commit ("scan: add N candidate ideas (<date>)" or "scan: heartbeat, nothing new (<date>)") and push to origin master. Always commit, even with zero adds.

Hard caps: 3 weekend, 2 moonshot. Quality over volume. Report blocked sources in the log line.
