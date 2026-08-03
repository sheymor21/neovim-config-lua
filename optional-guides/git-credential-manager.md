# Git Credential Manager (Linux)

This guide walks through installing and configuring [Git Credential Manager (GCM)](https://github.com/git-ecosystem/git-credential-manager) on Arch Linux. GCM securely stores credentials for GitHub, GitLab, Azure Repos, Bitbucket, and other Git hosting services, so you no longer get repeated username/password prompts.

> **Why it matters for this Neovim setup**: Git is a required tool, and most workflows here (`<leader>ig` for lazygit, custom formatting tools, cloning config updates) hit remote hosts. GCM removes credential prompt friction without storing passwords in plain text.

## ✅ Prerequisites

- Arch Linux
- `git` installed
- An AUR helper (`yay` is used below; `paru` works the same)
- `dotnet` (already a dependency of this config) for building, though the prebuilt binary skips it

## 📦 Install

### Option 1 (Recommended): Pre-built binary from the AUR

The `git-credential-manager-bin` package ships a precompiled binary — no build time, newest version.

```bash
yay -S git-credential-manager-bin

# Verify it installed
git-credential-manager --version
# Expect: 2.9.1+...
```

### Option 2: Build from source (AUR)

Only if you prefer to compile; it's slower and pins an older version.

```bash
yay -S git-credential-manager
```

### Option 3: .NET global tool

User-local, no AUR helper required.

```bash
dotnet tool install -g git-credential-manager
# Ensure ~/.dotnet/tools is on your PATH (see installation.md)
```

## 🔐 Choose a credential store

GCM needs a backend to persist credentials. On Linux the valid values are:

| Value | Backend | Notes |
|-------|---------|-------|
| `secretservice` | GNOME Keyring / libsecret | **Recommended** — encrypted, desktop-integrated, no extra setup if your keyring is running |
| `gpg` | GNU `pass`-compatible | Most secure; requires GPG secret keys plus `pass` |
| `cache` | In-memory cache | Short-lived, no persistence across restarts |
| `plaintext` | Plain-text file | ⚠️ Unencrypted; avoid unless trivially convenient |
| `none` | None | Credentials are never stored |

> **Note**: The **correct spelling is `secretservice`** — `secrets` is not a valid value (GCM will error out listing these options).

### Verify your system supports the secret service

```bash
# libsecret present?
pacman -Qs libsecret

# GNOME Keyring daemon running + reachable on D-Bus?
pidof gnome-keyring-daemon
busctl --user list | grep -i secret
# Expect output containing: org.freedesktop.secrets
```

If `org.freedesktop.secrets` is listed, `secretservice` works out of the box.

## ⚙️ Configure GCM

```bash
# 1. Let GCM write its config + register itself as a helper
git-credential-manager configure

# 2. Ensure GCM is the global credential helper
git config --global credential.helper manager

# 3. Set the credential store (use `secretservice`, not `secrets`)
git config --global credential.credentialStore secretservice
```

> **Note**: You may see `warning: credential.helper has multiple values`. That's expected — `git-credential-manager configure` writes a reset line (`credential.helper=`) before the actual helper, which is the standard way to clear earlier inherited helpers. It's harmless.

### Verify the configuration

```bash
git config --global --get-all credential.helper
# Expect:
#   (empty reset line)
#   /usr/bin/git-credential-manager  (or `manager`)

git config --global --get credential.credentialStore
# Expect: secretservice
```

### GitHub CLI note

If you use `gh`, your `~/.gitconfig` may already have:

```
credential.https://github.com.helper=!/usr/bin/gh auth git-credential
```

That's fine — `gh` handles GitHub, and GCM handles every other host. Remove those lines only if you want GCM to manage GitHub too.

## 🧪 Test the setup

```bash
# Any HTTP(S) repo on a non-GitHub host (or GitHub, if GCM manages it)
git ls-remote https://gitlab.com/<namespace>/<project>.git

# On the first auth, GCM launches its login flow, then stores the token.
# List stored credentials (if your secret tool is available):
secret-tool search service git-credential-manager
```

For interactively testing GitHub auth you can also run `git-credential-manager github auth` first.

## 🐛 Troubleshooting

### `Cannot read "clipboard"`

Happens when GCM tries to save the credential before `credential.credentialStore` is set to a valid value. Fix with:

```bash
git config --global credential.credentialStore secretservice
```

### Prompt to pick a store on every use

The credential store is unset or invalid. Set one of the valid values (above).

### `warning: credential.helper has multiple values`

Expected after `git-credential-manager configure`; harmless.

### No `org.freedesktop.secrets` on D-Bus

The GNOME Keyring isn't available. Either:

- Start your desktop keyring (re-login to your session usually fixes this), or
- Use a different store, e.g. `git config --global credential.credentialStore cache`.

## 🔄 Updates

```bash
yay -S git-credential-manager-bin   # re-run to upgrade
```