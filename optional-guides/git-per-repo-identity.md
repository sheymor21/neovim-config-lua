# Per-Repository Git Identity (Name & Email)

This guide covers configuring a custom `user.name` and `user.email` per repository in Git, so different projects can commit with different identities (e.g. work vs. personal) without editing the global config each time.

> **Why it matters for this Neovim setup**: lazygit (`<leader>ig`) and custom formatting/commit tooling all rely on Git. If you juggle a work identity and a personal one, per-repo identity keeps every commit's author correct without touching `~/.gitconfig`.

## ✅ Prerequisites

- `git` installed
- A global identity already set (or not — per-repo overrides work either way)

## 📝 The simple way: local config

Set the identity for just the current repository:

```bash
git config user.name "Sheymor"
git config user.email "sheymor@example.com"
```

That writes to `.git/config` (the repo-local scope). It overrides `~/.gitconfig` for this repo only.

## ⚙️ The automated way: `includeIf` by directory

If you keep work repos under one folder and personal repos under another, Git can auto-apply identity per path — no per-repo setup needed.

Add to `~/.gitconfig`:

```ini
[includeIf "gitdir:~/work/"]
    path = ~/.gitconfig-work

[includeIf "gitdir:~/personal/"]
    path = ~/.gitconfig-personal
```

> **Note**: `gitdir:` matches the directory and everything beneath it. Use `gitdir/i:` for case-insensitive matching (Windows/macOS).

Then create each identity file:

```bash
cat > ~/.gitconfig-work <<'EOF'
[user]
    name = Sheymor (Work)
    email = sheymor@company.com
EOF

cat > ~/.gitconfig-personal <<'EOF'
[user]
    name = Sheymor
    email = sheymor@example.com
EOF
```

Repos cloned or moved under `~/work/` automatically commit as the work identity; everything else uses the global (or `~/personal/`) identity.

## 🔧 One-off repos: `git init` template

For repos you create with `git init`, set a template so the local identity is written at init time:

```bash
mkdir -p ~/.git-templates
cat > ~/.git-templates/config <<'EOF'
[user]
    name = Sheymor
    email = sheymor@example.com
EOF
git config --global init.templateDir ~/.git-templates
```

New `git init` repos inherit that identity in `.git/config`; existing repos are unaffected.

## 🧪 Verify the setup

```bash
# What identity will THIS repo use?
git config user.name
git config user.email

# Where each value is coming from
git config --show-origin user.name

# All scopes, most-specific last
git config --list --show-origin | grep '^user\.'
```

## 🐛 Troubleshooting

### A repo still commits with the wrong identity

Check for a higher-priority source overriding the local value:

```bash
# 1. Repo-local (most specific) — should win
git config --local user.name

# 2. Environment variables override EVERYTHING
env | grep -i GIT_AUTHOR || true

# 3. The includeIf path didn't match (wrong folder, or file missing)
git config --list --show-origin | grep -i 'gitconfig-'
```

### `includeIf` not applying

- The folder must exist and the repo must live under it (not be the folder itself).
- The included file must exist — a missing path is silently ignored, not an error.
- Verify the match: `git config --list --show-origin | grep -i 'gitconfig-work'` should show the include line when inside a work repo.

### Want to confirm on a fresh clone

Local config is not cloned — set it right after `git clone`:

```bash
git clone git@host:org/repo.git && cd repo
git config user.name "Sheymor"
git config user.email "sheymor@example.com"
```

Or use a conditional `includeIf` so clones under `~/work/` pick it up automatically.

## 📚 Reference

- Global config: `git config --global user.name/email`
- Repo-local config: `git config user.name/email` (writes to `.git/config`)
- Show origin of a value: `git config --show-origin <key>`
- Supported identity config keys: `user.name`, `user.email`, and per-host variants under `includeIf`
