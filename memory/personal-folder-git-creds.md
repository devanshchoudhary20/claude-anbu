---
name: personal-folder-git-creds
description: Which GitHub account/SSH key to use for repos under ~/developer/personal
metadata: 
  type: reference
---

Anything under `~/developer/personal/` is PERSONAL and must use the personal GitHub account `devanshchoudhary20` — never the company account `devanshc-lambdaTest`.

Setup in place:
- SSH key `~/.ssh/id_ed25519` → company account; `~/.ssh/id_ed25519_personal` → personal account.
- `~/.ssh/config` host alias `github.com-personal` maps to the personal key.
- `~/.gitconfig-personal` (loaded via includeIf for `~/developer/personal/`) sets identity Devansh Choudhary <devanshchoudhary999@gmail.com> AND rewrites `git@github.com:` → `git@github.com-personal:`.

**How to apply:** for personal repos set the remote to `git@github.com-personal:devanshchoudhary20/<repo>.git` (or rely on the insteadOf rewrite). Before any push to a personal repo, confirm `gh api user --jq .login` is `devanshchoudhary20`. `~/developer/company/` uses the company account/key — leave it alone.
