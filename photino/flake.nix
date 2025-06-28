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
        runtimeDeps = with pkgs; [
          webkitgtk_4_0
          gtk3
          glib
          libnotify
        ];
      in rec {
        packages.default = pkgs.buildDotnetModule rec {
          pname = "unnamed";
          version = "1.0";
          src = ./.;

          projectFile = null;
          executables = [ pname ];
          buildInputs = [];
          inherit runtimeDeps;

          dotnet-sdk = pkgs.dotnetCorePackages.sdk_8_0;
          dotnet-runtime = dotnet-sdk.runtime;

          dotnetFlags = [ "-p:AssemblyName=${pname}" ];

          nugetDeps = nuget-packageslock2nix.lib {
            inherit system;
            lockfiles = [ ./packages.lock.json ];
          };
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [ packages.default ];
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath runtimeDeps;
        };
      }
    );
}