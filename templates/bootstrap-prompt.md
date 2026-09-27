# Bootstrap prompt for a fresh machine

Paste this into Claude Code on the new machine after `claude login`. It installs the base layer and stops only for the two logins.

```
Bootstrap my personal Claude Code setup on this machine. Work autonomously; do not ask for confirmation except at the two manual login steps below. On Windows use Git Bash for every shell command.

1. Prerequisites. Check git (Git for Windows, so Git Bash exists), node 20+, gh, jq, and claude. Install anything missing (winget: Git.Git, OpenJS.NodeJS.LTS, GitHub.cli, jqlang.jq; mac: brew). Report versions.

2. Personal GitHub identity. Everything under ~/developer/personal uses my personal account devanshchoudhary20, never a company account.
   - If ~/.ssh/id_ed25519_personal does not exist, generate it: ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_personal -C devanshchoudhary999@gmail.com -N ""
   - Ensure ~/.ssh/config has this block (append if missing):
       Host github.com-personal
         HostName github.com
         User git
         IdentityFile ~/.ssh/id_ed25519_personal
         IdentitiesOnly yes
   - Create ~/.gitconfig-personal with user.name "Devansh Choudhary", user.email devanshchoudhary999@gmail.com, and url."git@github.com-personal:".insteadOf "git@github.com:". Add to ~/.gitconfig: [includeIf "gitdir:~/developer/personal/"] path = ~/.gitconfig-personal
   - MANUAL STEP 1: print the contents of ~/.ssh/id_ed25519_personal.pub and tell me to add it at https://github.com/settings/keys, then wait for me to say "added". Then verify with: ssh -T git@github.com-personal
   - MANUAL STEP 2: tell me to run "! gh auth login" (personal account, SSH, browser). Wait for me, then verify: gh api user --jq .login must print devanshchoudhary20.

3. Clone and install.
   git clone git@github.com-personal:devanshchoudhary20/claude-anbu.git ~/developer/personal/claude-anbu
   bash ~/developer/personal/claude-anbu/setup.sh
   Read every line of the output. Fix any ✘ by installing what it names, then rerun setup.sh until a run shows only ✔ and – lines. setup.sh is idempotent. On Windows it copies files instead of linking, so it must be rerun after every git pull in that repo; remember that.

4. Verify. Confirm these exist: ~/.claude/CLAUDE.md (starts with "# My Development Context"), ~/.claude/settings.json (valid JSON, contains "statusLine"), ~/.claude/statusline-command.sh, ~/.claude/skills/mission, ~/.claude/skills/unslop, ~/.claude/agents/strategist.md, ~/developer/personal/idea-engine/.git, and a memory folder under ~/.claude/projects whose name ends with developer-personal (starts with C--Users on Windows, -Users on mac), containing MEMORY.md and four .md files. Run: echo '{}' | bash ~/.claude/statusline-command.sh and confirm it prints a line.

5. Report a short table of each step and its result, list what is still manual (Claude in Chrome extension, Figma authorization on the personal account, claude /web-setup), and tell me to restart Claude Code so the new CLAUDE.md, skills, and status line load.
```
