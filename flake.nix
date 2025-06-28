{
  description = "Some .NET flake templates";
  outputs = { self }: {
    templates = rec {
      default = {
        path = ./default;
        description = "Generic .NET 8 flake, intended to be used with `dotnet new`";
        welcomeText = ''
          Welcome to the .NET 8 flake template!

          To create a new project for use with this flake, run `dotnet new` from the dev shell:

          ```
          nix develop
          dotnet new console
          dotnet run
          ```
        '';
      };
      photino = {
        path = ./photino;
        description = "Photino .NET 8 flake for Photino apps, intended to be used with `dotnet new`";
        welcomeText = ''
          Welcome to the Photino .NET 8 flake template!

          To create a new project for use with this flake, run `dotnet new` from the dev shell:

          ```
          nix develop
          dotnet new install TryPhotino.VSCode.Project.Templates
          dotnet new photinoapp
          dotnet run
          ```
        '';
      };
    };
  };
}