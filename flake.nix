{
  description = "Some .NET flake templates";
  outputs = { self }: {
    templates = rec {
      default = {
        path = ./default;
        description = "Generic .NET 8 flake, intended to be used with `dotnet new`";
        welcomeText = ''
          Welcome to the .NET 8 flake template!

          To create a new .NET project for use with this flake, run `dotnet new`:

          ```
          nix develop
          dotnet new console
          dotnet run
          ```
        '';
      };
    };
  };
}