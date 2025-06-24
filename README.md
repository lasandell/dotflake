# dotflake

Nix flake templates for .NET projects

## Available Templates

### default

Generic .NET 8 template, intended to be used with `dotnet new`

Requires no editing of the the `flake.nix` to get started. Uses a `packges.lock.json` file  that is automatically updated by NuGet to enable building with nix.

```bash
nix flake init -t github:lasandell/dotflake
nix develop -c "dotnet new console"
nix run
```