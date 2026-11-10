# Infisical: Dev Secrets Outside the Repos

This guide covers an optional workflow for keeping development secrets out of the repositories: an [Infisical](https://infisical.com) project per repo, a small launcher per project in `~/.local/bin`, and a lister that shows them all.

The setup is meant to be **personal and local**. It is not required by any project, nothing about it is committed to the repositories, and the projects keep working without it.

> **Why it matters for this Neovim setup**: the launchers, the lister and the Infisical session live outside every repository, so a fresh install does not have them. This guide is the reference for rebuilding them. The repositories themselves keep their `appsettings.Development.json` self-sufficient, so `dotnet run` still works without Infisical.

## ✅ Prerequisites

- The `infisical` CLI. On Arch-based systems: `yay -S infisical-bin`. Otherwise use the official installer from the Infisical docs and check `infisical --version`.
- `jq` on `PATH` (used by the import/export recipes).
- `~/.local/bin` on `PATH`. Create it if it does not exist: `mkdir -p ~/.local/bin`.
- An Infisical account. A free/personal account is enough for a handful of projects.

There is no service token or shared credential on disk: each machine logs in once.

## 📦 Restoring the setup on a new machine

1. Install the CLI: `yay -S infisical-bin`.
2. Log in: `infisical login` (see [Account and profiles](#-account-and-profiles)).
3. Confirm the projects are reachable:

   ```bash
   infisical secrets-manager projects list
   ```

4. Recreate `~/.local/bin/infi-proj` from its [source](#-infi-proj).
5. Recreate the launchers from the [template](#-launcher-template), one per project. The project ID of each one is in `infisical secrets-manager projects list`.
6. Verify:

   ```bash
   chmod +x ~/.local/bin/infi-proj ~/.local/bin/my-api
   infi-proj
   my-api --no-build
   ```

   The first log line must contain `Injecting N Infisical secrets`. If it does not, the command is not going through `infisical run`.

The secrets themselves are stored in Infisical, so nothing else needs to be copied between machines.

## 🔐 Account and profiles

```bash
infisical login                      # once per machine; opens the browser
infisical secrets-manager projects list
infisical user switch                # only if more than one account is logged in
```

- The local profile lives in `~/.infisical/infisical-config.json` (mode `600`). It stores the session, not secret values.
- If a launcher suddenly fails with an authentication error, the session expired: run `infisical login` again. There is no offline mode.
- Recent CLI versions use `.infisical.yaml` for project config; older docs and blog posts mention the legacy `.infisical.json`.

Keep this account separate from any organization account if the secrets are your own development values. Copying organization secrets into a personal vault is a bad idea in both directions.

**Do not** run `infisical init` inside a work repository. If it happens anyway, add `.infisical.yaml` to `.git/info/exclude` (local, not versioned), never to `.gitignore`.

## 🆕 Adding a new project

One Infisical project per repository, `dev` environment only. Example with a .NET API whose secrets live in `appsettings.Development.json`.

### 1. Create the project

```bash
infisical secrets-manager projects create --name my-api
```

The output prints the **project ID**; copy it. New projects get `dev`, `staging` and `prod` environments by default.

### 2. Flatten `appsettings` to YAML

.NET maps `Section:Key` to the environment variable `Section__Key`, so flatten the JSON with `__` as separator:

```bash
sed 's|^[[:space:]]*//.*$||' path/to/appsettings.Development.json \
| jq -r 'paths(scalars) as $p | select((getpath($p)|tostring) != "")
         | "\($p|join("__")): \(getpath($p)|tostring|tojson)"' \
> /tmp/appsettings.yaml
chmod 600 /tmp/appsettings.yaml
```

Why each piece:

- `sed` drops full-line `//` comments (many of these files are not strict JSON).
- `paths(scalars)` flattens nested objects.
- `select(... != "")` skips empty values, because the CLI rejects them (`Secret key 'X' has an empty value`). Empty keys stay in the local file, so nothing is lost.
- `tojson` quotes the value, which preserves a trailing `$` in passwords and the `\n` inside multi-line PEM keys (private keys, certificates).
- YAML is used instead of dotenv for the same reason: no quoting surprises.

Arrays are not handled by this recipe. If a file has them, either leave that section in the local file or extend the flattening with indexed keys (`Section__Key__0`).

### 3. Import

```bash
infisical secrets set --file /tmp/appsettings.yaml --env dev --projectId <project-id>
rm /tmp/appsettings.yaml
```

Verify the count before trusting it:

```bash
infisical export --format json --env dev --expand=false --projectId <project-id> | jq length
```

### 4. Create the launcher

Copy the [template](#-launcher-template) to `~/.local/bin/my-api`, adjust the `cd`, the project ID and the comment, then `chmod +x`.

### 5. Verify

```bash
infi-proj              # the new launcher must appear with its project name
my-api --no-build
```

The log must show `Injecting N Infisical secrets` and the app must reach its normal startup. A failing database connection is unrelated to Infisical — see [Troubleshooting](#-troubleshooting).

## 🚀 Launcher template

Every launcher is a small executable script in `~/.local/bin`:

```bash
#!/usr/bin/env bash
# Dev de <ProjectName> con los secretos de Infisical (proyecto personal).
# Alternativa sin Infisical: cd <repo dir> && dotnet run
set -euo pipefail
cd "$HOME/Projects/<repo dir>"
exec infisical run \
  --projectId <project-id> \
  --env dev --expand=false \
  -- dotnet run --launch-profile http "$@"
```

Rules that matter:

- **`--expand=false` is mandatory.** By default `infisical run` runs shell expansion on the values; passwords ending in `$` (or containing `$(...)`) get mangled.
- `--` separates Infisical flags from the command; everything after it runs with the variables injected.
- `"$@"` forwards extra arguments, so `my-api --no-build` or `--launch-profile https` work without editing the script.
- The first comment line must match `# Dev de <name> con los secretos` — `infi-proj` reads the project name from it. Keep the literal format even if the rest of the script is written in another language.
- The `cd` is required: .NET resolves `appsettings*.json` from the working directory, so `dotnet run` must start inside the project folder.
- Without the launcher the normal flow still works: `cd` to the project and run `dotnet run --launch-profile http`, using the local `appsettings.Development.json`.
- The last line is whatever the project needs: `dotnet run` for .NET APIs, `func start` for Azure Functions, `npm run dev` for a frontend. Anything that reads environment variables works.
- Pipeline projects that already load secrets from a managed vault (Azure Key Vault, AWS Secrets Manager, Vault) should not be duplicated here: keeping the original provider is less work and avoids two sources of truth.

## 🗂️ `infi-proj`

Lists every dev launcher that goes through Infisical. It reads `~/.local/bin`, so it never goes stale when a launcher is added or removed.

`~/.local/bin/infi-proj`:

```bash
#!/usr/bin/env bash
# Lista los lanzadores de dev que arrancan con Infisical.
# Un lanzador nuevo debe empezar con: # Dev de <proyecto> con los secretos de Infisical
set -euo pipefail
self=$(basename "$0")
for f in "$HOME"/.local/bin/*; do
  name=$(basename "$f")
  [ "$name" = "$self" ] && continue
  [ -f "$f" ] && [ -x "$f" ] || continue
  grep -q 'infisical run' "$f" 2>/dev/null || continue
  proj=$(sed -n 's/^# Dev de \(.*\) con los secretos.*/\1/p' "$f" | head -1)
  printf '%-18s %s\n' "$name" "${proj:-?}"
done
```

It needs no login, no network call and no configuration. Example output:

```
my-api             MyApi
my-api-uni         MyOtherApi (second copy)
my-worker          MyWorker
```

## 🔁 Daily use and precedence

```bash
my-api                # Infisical values, everything else from appsettings
my-api --no-build     # skip the build
cd ~/Projects/my-repo/MyApi && dotnet run --launch-profile http   # no Infisical
```

How they combine:

- .NET adds environment variables **after** `appsettings*.json`, so injected values win. Nothing in the code knows Infisical exists.
- With a launcher, editing the local `appsettings.Development.json` has **no effect** for the keys present in Infisical. To change one:

  ```bash
  infisical secrets set Security__SecretKey='new-value' --env dev --projectId <project-id>
  ```

  or edit it in the web UI. Restart the app: values are read at startup.
- To know which mode is active, look at the first log line: `Injecting N Infisical secrets` means the launcher; its absence means the local file.
- Some projects need local infrastructure before starting (a database container, an emulator, a message broker). That dependency is unrelated to Infisical.

## 🔄 Restoring a local `appsettings.Development.json`

The dev files are usually git-ignored, so a fresh clone does not have them. Since the local file must keep working standalone, it can be regenerated from Infisical:

```bash
infisical export --format json --env dev --expand=false --projectId <project-id> \
| jq 'map({key, value}) | reduce .[] as $s ({}; setpath($s.key | split("__"); $s.value))' \
> path/to/appsettings.Development.json
```

Notes:

- Keys are unflattened back to nested JSON; `QzTray__PrivateKey` becomes `QzTray.PrivateKey` with its real newlines.
- All values come back as strings. .NET configuration binds `"True"`, `"15"` and similar just fine, so no post-processing is needed.
- Empty values skipped during import do not come back. If the base `appsettings.json` has them empty too, there is nothing to restore.
- Review the result before relying on it; this is a recovery path, not part of the daily flow.

## 🐛 Troubleshooting

### `Injecting 0 Infisical secrets`

Wrong environment or path: the launcher must use `--env dev` and the default path `/`. Check with `infisical export --format json --env dev --projectId <id> | jq length`.

### Authentication error, `project not found`, or the launcher exits immediately

The session expired or the wrong profile is active. Run `infisical login` (or `infisical user switch`) and retry.

### `Secret key '<name>' has an empty value`

The CLI refuses empty strings. Drop those keys from the YAML (the flatten recipe already does) and keep them in the local appsettings, where they are empty anyway.

### A password is cut off or a value looks expanded

`--expand=false` is missing from the `infisical run` call. Values ending in `$` are the usual victims.

### The app exits with a database exception right after startup

That is the app, not Infisical: the secrets arrived (the log line proves it) but the database or container is down. Start the required service and retry.

### `infi-proj` prints `?` instead of a project name

The launcher's first comment line does not follow `# Dev de <name> con los secretos de Infisical`. Fix the comment; no change to the script is needed.

### A launcher does not appear in `infi-proj`

It is not executable, does not live in `~/.local/bin`, or does not contain `infisical run`.

## ⚠️ Caveats

- **Secrets are still plaintext on disk.** The local `appsettings.Development.json` files keep their values; Infisical is an overlay, not an encryption layer. Keeping the file self-sufficient is a deliberate trade-off.
- **Migration does not fix git history.** If a repository already committed secrets, they stay in the history after moving to Infisical. Rotating those credentials is the repository owner's decision.
- **One project per repository** means the account's project limit is the practical ceiling. Check the plan before adding many.
- **No offline mode.** Without a valid session, the launchers do not start. The plain `dotnet run` path always works.
- **`--expand=false` everywhere.** Adding it back by hand on a one-off `infisical run` is the most common way to break a password.
- **Not a team solution.** This is a per-developer convenience layer. A team should standardize on one shared secret store, not on each member's personal vault.

## 📚 Reference

```bash
# Session
infisical login
infisical user switch

# Projects
infisical secrets-manager projects create --name <name>
infisical secrets-manager projects list

# Secrets
infisical secrets set KEY=value --env dev --projectId <id>
infisical secrets set --file <file.yaml> --env dev --projectId <id>
infisical export --format json --env dev --expand=false --projectId <id>
infisical secrets get --env dev --projectId <id>          # masked values

# Running
infisical run --projectId <id> --env dev --expand=false -- <command>
```

- Flattening rule: `Section:Key` in JSON ⇄ `Section__Key` as an environment variable.
- Default environments on a new project: `dev`, `staging`, `prod`.
- Flags change between CLI versions; when something is rejected, check `infisical <command> --help`.
