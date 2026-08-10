# Local GitIgnore (`.git/info/exclude`) & Skip-Worktree

This guide covers two ways to keep files out of Git **without** touching a tracked `.gitignore`: the repo-local exclude file `.git/info/exclude`, and the `skip-worktree` flag for files already under version control. Both end with a **rollback** section so you can undo everything.

> **Why it matters for this Neovim setup**: lazygit (`<leader>ig`) and diffview (`<leader>gd`) surface every local change. A stray local-only file (`.env`, editor config, secrets) or a tweaked tracked file pollutes the diff. These two mechanisms hide them locally without pushing ignore rules to every collaborator.

## ✅ Prerequisites

- `git` installed
- A repo to test in

## 📝 Local ignore: `.git/info/exclude`

A `.gitignore` is **tracked** — it gets committed and shared. If you want to ignore a file only for yourself, use `.git/info/exclude`. It lives in `.git/` (never committed) and uses the same pattern syntax as `.gitignore`.

```bash
# Open the file
$EDITOR .git/info/exclude

# Example contents
# Ignore editor/OS droppings just for me
*.swp
.idea/
.env.local
```

**Precedence**: `.gitignore` in a dir > repo root `.gitignore` > `.git/info/exclude` > global `core.excludesFile`. Unlike a tracked `.gitignore`, this file is invisible to everyone else.

To confirm a path is now ignored:

```bash
git check-ignore -v .env.local
# Expect: .git/info/exclude:3:.env.local  .env.local
```

### Rollback local ignore

```bash
# Remove the rule(s) you added
$EDITOR .git/info/exclude
# or reset the whole file to the default comment block:
git config --unset-all core.excludesFile 2>/dev/null || true
```

The file itself was never tracked, so nothing to commit — just delete the lines. Any already-tracked files are unaffected (ignore rules don't apply to tracked files).

## ⚙️ Skip-worktree: ignore changes to a tracked file

For a file that IS tracked (e.g. a config with local tweaks you never want committed), the `skip-worktree` flag makes Git pretend the file is unchanged:

```bash
git update-index --skip-worktree path/to/config.json
```

Now `git status` and lazygit no longer show it as modified, even though the file on disk differs.

> **Note**: This is distinct from `assume-unchanged` (an older, speed-oriented flag that Git may silently drop the marker from on conflicts). Prefer `skip-worktree` for "I've modified this locally and want to keep it that way".

### Rollback skip-worktree

```bash
# Un-mark the file so its changes show up again
git update-index --no-skip-worktree path/to/config.json

# Verify the flag is gone (blank output = cleared)
git ls-files -v | grep -i '^S' path/to/config.json || true
```

> **⚠️ Before pulling/merging**: `skip-worktree` files won't be overwritten by `git pull` — Git keeps your local version. If the upstream genuinely changed, you'll see conflicts after removing the flag. To fetch upstream into it safely:
> ```bash
> git update-index --no-skip-worktree path/to/config.json
> git checkout -- path/to/config.json   # rollback local tweaks, take upstream
> # re-apply your tweaks, then re-mark if desired
> git update-index --skip-worktree path/to/config.json
> ```

### Rollback everything (reset both)

```bash
# Un-mark all skip-worktree files
git ls-files -v | awk '$1 == "S" { print $2 }' | xargs -r git update-index --no-skip-worktree

# Confirm none remain
git ls-files -v | grep -i '^S' || echo "No skip-worktree files."

# Clear local ignore rules (revert .git/info/exclude to its default comment block)
git config --unset-all core.excludesFile 2>/dev/null || true
```

## 🧪 Test the setup

```bash
# 1. Local ignore
echo ".env.local" >> .git/info/exclude
echo "SECRET=1" > .env.local
git status            # .env.local should NOT appear
git check-ignore -v .env.local

# 2. Skip-worktree
git update-index --skip-worktree some-tracked-file
git status            # some-tracked-file should NOT appear as modified
git diff              # empty

# 3. Rollback
git update-index --no-skip-worktree some-tracked-file
git status            # change reappears
```

## 🐛 Troubleshooting

### Ignore rule matches but the file still shows in `git status`

The file is already tracked — ignore rules never apply to tracked files. Either commit the deletion or mark it with `skip-worktree`.

### `skip-worktree` file got overwritten by a merge anyway

Merge can't always protect them. Roll back, take the upstream version, re-apply tweaks, then re-mark (see the pull/merge recipe above).

### Changes still showing in lazygit after `skip-worktree`

lazygit reads from the index — the flag must be applied to the file in the **index** via `git update-index`, not by editing the working copy. Re-run the flag command in the repo root.

## 📚 Reference

- Local ignore file: `.git/info/exclude` (per-repo, never committed)
- Global ignore file: `git config --global core.excludesFile ~/.gitignore_global`
- Mark/unmark: `git update-index --skip-worktree` / `--no-skip-worktree`
- List marked files: `git ls-files -v | grep '^S'`
- Show why a path is ignored: `git check-ignore -v <path>`
