{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      scripts = [
        (pkgs.writeShellApplication {
          name = "qs";
          runtimeInputs = with pkgs; [
            nix
          ];
          text = (builtins.readFile ./scripts/qs);
        })

        (pkgs.writeShellApplication {
          name = "cf";
          text = ''
            ts=$(date +%s)
            path=$"/tmp/$ts"

            mkdir -p "$path"
            cp --no-preserve=mode ${./cf.cpp} "$path/cf.cpp"

            ${pkgs.runtimeShell} -c "cd $path && $EDITOR cf.cpp"
          '';
        })
      ];
    in
    {

      inherit scripts;

      devShells = {
        ${system}.default = pkgs.mkShell {
          packages = scripts;
        };
      };
    };
}
