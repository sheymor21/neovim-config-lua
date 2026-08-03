# Azure DevOps Credential Provider

This guide covers installing and configuring the [Azure DevOps Credential Provider](https://github.com/microsoft/azure-devops-credentialprovider) on Arch Linux. It authenticates `dotnet`/NuGet against Azure Artifacts feeds so private package pulls/pushes (`restore`, `add source`, `push`) work without stuffing a PAT into plain-text config.

> **Why it matters for this Neovim setup**: This config's C# workflow is formatter-driven (`csharpier`) and builds against NuGet feeds. The credential provider is the NuGet-side companion to GCM (see `git-credential-manager.md`) — GCM handles `git`, this provider handles `dotnet`/NuGet against `pkgs.dev.azure.com`.

## ✅ Prerequisites

- Arch Linux
- `dotnet` (already a dependency of this config)
- A `nuget.config` with your Azure Artifacts feed (see `installation.md`)

## 📦 Install

The Azure DevOps Credential Provider ships a set of [releases](https://github.com/microsoft/azure-devops-credentialprovider/releases) per .NET target. Two supported routes:

### Install

```bash
# 1. Install the tool
dotnet tool install -g Microsoft.Artifacts.CredentialProvider.NuGet.Tool --source https://api.nuget.org/v3/index.json
# Ensure ~/.dotnet/tools is on your PATH (see installation.md)

# 2. Wire it into NuGet's plugin discovery dir (REQUIRED — the tool install alone is not enough)
# The tool only drops an executable in ~/.dotnet/tools/; NuGet loads credential
# plugins only from ~/.nuget/plugins/netcore/. Copy the ENTIRE folder — a partial
# copy makes the provider load but crash (SIGABRT) on missing dependencies.
SRC=~/.dotnet/tools/.store/microsoft.artifacts.credentialprovider.nuget.tool/*/microsoft.artifacts.credentialprovider.nuget.tool/*/tools/net8.0/any
DEST=~/.nuget/plugins/netcore/CredentialProvider.Microsoft
mkdir -p "$DEST"
cp -r "$SRC"/. "$DEST"/
```

Verify the provider is discovered:
```bash
cd /some/project
dotnet restore -v diag 2>&1 | grep "as a credential provider plugin"
# Expect: Using ~/.nuget/plugins/netcore/CredentialProvider.Microsoft/...dll as a credential provider plugin
```

## ⚙️ Configure

Point `nuget.config` at your feed (no PAT — the provider handles auth interactively, or reuses `az login`):

```xml
<packageSources>
  <add key="devops" value="https://pkgs.dev.azure.com/<org>/<project-if-applicable>/_packaging/<feed>/nuget/v3/index.json" />
</packageSources>
```

> **Note**: No PAT is stored in `nuget.config`. The provider authenticates interactively (device/login flow) or reuses an existing `az login`/MSAL session. Tokens are kept in a protected session cache, not in plain text.

## 🧪 Test the setup

```bash
dotnet restore ./MyProject.csproj
```

On the first restore the provider reports its selected credential source, for example `Found a MSAL secret in the environmental store` or `THIS_IS_AZURE_DEVOPS...` when a PAT is provided. No interactive prompt should appear.

## 🐛 Troubleshooting

### Restore fails with "The feed ... cannot be reached" or 401/403

- Confirm the feed URL matches the Artifacts feed name verbatim.
- Ensure the PAT has the `packaging` scope (`Read` for restore; `Read & Write` for push).
- Re-run the interactive login flow that the build tooling offers (e.g. `dotnet` restore) and verify the credential provider logs which source it resolved.

### Provider not picked up

Make sure `~/.nuget/NuGet/NuGet.Config` (user) doesn't globally blank `packageSources`. The provider activates per-project `nuget.config` feeds.

### After upgrading the tool

Re-run step 2 (the plugin copy) so the plugin stays in sync with the new version:
```bash
SRC=~/.dotnet/tools/.store/microsoft.artifacts.credentialprovider.nuget.tool/*/microsoft.artifacts.credentialprovider.nuget.tool/*/tools/net8.0/any
DEST=~/.nuget/plugins/netcore/CredentialProvider.Microsoft
mkdir -p "$DEST"
cp -r "$SRC"/. "$DEST"/
```

## 🔄 Updates

```bash
dotnet tool update --global Microsoft.Artifacts.CredentialProvider.NuGet.Tool
# then re-run the plugin copy step above
```