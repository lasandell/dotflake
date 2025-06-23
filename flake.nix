{
  description = "Some .net flake templates";
  outputs = { self }: {
    templates = rec {
      default = console;
      console = {
        path = ./console;
        description = ".net 8 console app";
      };
    };
  };
}
