{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    nuget-packageslock2nix = {
      url = "github:mdarocha/nuget-packageslock2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, nuget-packageslock2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.buildDotnetModule rec {
          pname = "Console";
          version = "0.1";
          src = ./.;
          
          projectFile = "${pname}.csproj";
          executables = [ pname ];
          buildInputs = [];
          runtimeDeps = [];

          dotnet-sdk = pkgs.dotnetCorePackages.sdk_8_0;
          dotnet-runtime = dotnet-sdk.runtime;

          nugetDeps = nuget-packageslock2nix.lib {
            inherit system;
            lockfiles = [ ./packages.lock.json ];
          };
        };
      }
    );
}
